
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:projek_skripsi/application/seller/scan/views/widgets/transaction_succesful.dart';
import 'package:projek_skripsi/authorization/data/models/m_buyer.dart';
import 'package:projek_skripsi/authorization/data/models/m_store.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/core/components/scanner/views/scanner_page.dart';
import 'package:projek_skripsi/core/models/m_customerVoucher.dart';
import 'package:projek_skripsi/core/providers/cloud_messaging.dart';
import 'package:projek_skripsi/core/models/m_storeVoucher.dart';
import 'package:projek_skripsi/core/providers/local_storage.dart';
import 'package:projek_skripsi/utils/routes.dart';

class ScanSellerController extends GetxController {
  ScanSellerController(this.arguments);
  Map arguments;

  var isLoading = false.obs;
  var isLoadingDetailVoucher = false.obs;
  var errorMsg = ''.obs;
  var customer = BuyerModel().obs;
  var customerVoucher = CustomerVoucher().obs;
  var voucher = StoreVoucherModel().obs;
  var store = StoreModel().obs;

  var formKey = GlobalKey<FormState>();
  var fieldTotal = TextEditingController();
  var fieldVoucherId = TextEditingController();

  @override
  void onInit() async {
    isLoading(true);
    await onGetCustomer();
    await onGetStore();
    isLoading(false);
    super.onInit();
  }

  Future<void> onGetCustomer() async {
    var customerData = await FirebaseFirestore.instance
      .collection('customers').doc(arguments['qrResult']).get();

    if(customerData.data() == null){
      Get.defaultDialog(
        title: 'Gagal',
        middleText: 'Pelanggan tidak ditemukan',
        textConfirm:'Ok',
        onConfirm: () => Get.until((route) => Get.currentRoute == AppRoutes.sellerdashboard)
      );
      return;
    }  

    customer.value = BuyerModel.fromJson(customerData.data() as Map<String,dynamic>);
    customer.value.id = customerData.id;
  }

  void scanBarcode() async {
    voucher.value = StoreVoucherModel();
    var barcodeResult = await Get.to(() => const QRScanner());
    if(barcodeResult != null) {
      fieldVoucherId.text = barcodeResult;
      onGetCustomerVoucher();
    }
  }


  Future<void> onGetCustomerVoucher() async {
    isLoadingDetailVoucher(true);
    var storeId = await LocalStorage().onGetUser();
    var customerVoucherData = await FirebaseFirestore.instance.collection('customers')
      .doc(customer.value.id!).collection('store_membership').doc(storeId)
      .collection('vouchers').doc(fieldVoucherId.text).get();

    if(customerVoucherData.data() != null){
      customerVoucher.value = CustomerVoucher.fromJson(customerVoucherData.data() as Map<String,dynamic>);
      customerVoucher.value.id = customerVoucherData.id;
      await onGetVoucher();
    }
    isLoadingDetailVoucher(false);
  }

  Future<void> onGetVoucher() async {
    var storeId = await LocalStorage().onGetUser();
    var voucherData = await FirebaseFirestore.instance
      .collection('stores').doc(storeId).collection('store_vouchers')
      .doc(customerVoucher.value.voucherId!).get();

    voucher.value = StoreVoucherModel.fromJson(voucherData.data() as Map<String,dynamic>);  
    voucher.value.id = voucherData.id;
  }

  Future<void> onGetStore() async {
    var storeId = await LocalStorage().onGetUser();
    var storeData = await FirebaseFirestore.instance
      .collection('stores').doc(storeId).get();

    store.value = StoreModel.fromJson(storeData.data() as Map<String,dynamic>);  
    store.value.id = storeData.id;
  }

  void onConfirm() async {
    errorMsg.value = '';
    var storeId = await LocalStorage().onGetUser();
    if(fieldVoucherId.text != ''){
      voucher.value.minTransaction != null  && voucher.value.minTransaction! > int.parse(fieldTotal.text) ?
        errorMsg.value = 'Maaf, pesanan Anda tidak memenuhi persyaratan minimum pembelian.' : null;
    }

    if(formKey.currentState!.validate() && errorMsg.value == ''){
      DialogComponent().onLoadingDismissible();
      
      var storeHistoryCollection = FirebaseFirestore.instance
        .collection('stores').doc(storeId).collection('store_history');
      var customerHistoryCollection = FirebaseFirestore.instance
        .collection('customers').doc(customer.value.id!).collection('customer_history');
      var membershipDoc = FirebaseFirestore.instance.collection('customers')
        .doc(customer.value.id!).collection('store_membership').doc(storeId);
      var membershipData = await membershipDoc.get();

      var totalPrice = int.parse(fieldTotal.text) - (calculateDiscount() ?? 0);
      var totalCoinExp = totalPrice~/1000;
      var time = DateTime.now();

      // history store
      await storeHistoryCollection.add({
        'date': Timestamp.fromDate(time),
        'customer_id': customer.value.id,
        'customer_name': customer.value.name,
        'store_name': store.value.name,
        'voucher_id': voucher.value.id,
        'total': totalPrice,
      })
        .then((value) => null)
        .catchError((error) => null);

      // history customer
      await customerHistoryCollection.add({
        'date': Timestamp.fromDate(time),
        'exp': totalCoinExp,
        'coin': totalCoinExp,
        'store_id': store.value.id,
        'total_price': totalPrice,
        'type': 'transaction',
        'voucher_id': voucher.value.id,
        'transaction_success': false
      })
        .then((value) => null)
        .catchError((error) => null);

      // delete customer voucher
      FirebaseFirestore.instance
        .collection('customers').doc(customer.value.id)
        .collection('store_membership').doc(storeId)
        .collection('vouchers').doc(customerVoucher.value.id)
        .delete()
          .then((value) => null)
          .catchError((error) => null);

      await membershipDoc.set({
          'coin': (membershipData.data() == null ? 0 : membershipData.data()!['coin']) + totalCoinExp,
          'exp': (membershipData.data() == null ? 0 : membershipData.data()!['exp']) + totalCoinExp,
          'level': (membershipData.data() == null ? 1 : membershipData.data()!['level']),
          'total_voucher': (membershipData.data() == null ? 0 : membershipData.data()!['total_voucher'])
      });

      // send fcm to customer
      await FirebaseMessagingAPI().sendPushMessage(
        recipientToken: customer.value.token! != store.value.token! ? customer.value.token! : '',
        title: "Hoorayyyy",
        body: "Transaksi Berhasil",
        route: AppRoutes.buyerDashboard,
      );

      //send fcm to store
      // await FirebaseMessagingAPI().sendPushMessage(
      //   recipientToken: store.value.token!,
      //   title: "Tadaa!!!",
      //   body: "Your Transaction Succesful",
      //   route: AppRoutes.sellerhistory,
      // );
      
      Get.isDialogOpen != null && Get.isDialogOpen! == true ? Get.back() : null;
      Get.to(() => TransactionSuccessful(
        voucher: voucher.value,
        customerName: customer.value.name!,
        time: time,
        totalPurchase: int.parse(fieldTotal.text),
        discount: calculateDiscount() ?? 0
      ));
    }
  }

  int? calculateDiscount(){
    int? discount;
    if(voucher.value.typeDiscount == null) return discount;
    if(voucher.value.typeDiscount == 'percentage'){
      var tempDisc = int.parse(fieldTotal.text) * (voucher.value.percentage!/100.0);
      if(voucher.value.maxNominal != null){
        discount =  tempDisc > voucher.value.maxNominal! ?
            voucher.value.maxNominal! : tempDisc.toInt();
      } else {
        discount = tempDisc.toInt();
      }
    }
    else if(voucher.value.typeDiscount == 'nominal'){
      discount = voucher.value.nominal!;
    }
    return discount;
  }
}
