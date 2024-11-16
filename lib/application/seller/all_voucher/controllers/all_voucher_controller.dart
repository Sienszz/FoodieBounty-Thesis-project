
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projek_skripsi/application/seller/all_voucher/views/widgets/success_create_voucher.dart';
import 'package:projek_skripsi/application/seller/dashboard/controllers/dashboard_seller_controller.dart';
import 'package:projek_skripsi/core/models/m_storeVoucher.dart';
import 'package:projek_skripsi/core/providers/local_storage.dart';
import 'package:projek_skripsi/utils/routes.dart';

class AllVoucherController extends GetxController with GetSingleTickerProviderStateMixin{
  TabController? tabsController;
  var formkey = GlobalKey<FormState>();

  var isLoading = false.obs;
  var fieldisDelete = false.obs;
  var isCheckDiscount = false.obs;
  var isCheckMaxDisc = false.obs;
  var fieldName = TextEditingController();
  var fieldDesc = TextEditingController();
  var fieldQty = TextEditingController();
  var fieldMinTransaction = TextEditingController();
  var fieldCoin = TextEditingController();
  var fieldExpDate = TextEditingController();
  var fieldPercentage = TextEditingController();
  var fieldNominal = TextEditingController();

  var fieldType = 'Voucer Publik'.obs;
  var fieldTypeDiscount = 'Diskon Persentase'.obs;

  var lsVoucher = List<StoreVoucherModel>.empty(growable: true).obs;

  final List<String> typeDiscount = const [
    'Diskon Persentase',
    'Diskon Nominal'
  ];
  final List<String> types = const [
    'Voucer Publik',
    'Voucer Spesial'
  ];
  final List<Tab> tabs = const [
    Tab(child: Text('Voucer Publik', textAlign: TextAlign.center)),
    Tab(child: Text('Voucer Spesial', textAlign: TextAlign.center)),
    Tab(child: Text('Voucer Kadaluarsa', textAlign: TextAlign.center)),
  ];

  @override
  void onInit() async {
    isLoading(true);
    tabsController = TabController(length: tabs.length, vsync: this);
    await onGetDataVoucher();
    isLoading(false);
    super.onInit();
  }

  void addVoucher() async {
    if(formkey.currentState!.validate()){
      saveToCloudFirestore();
    } else {
      Get.back();
    }
  }

  Future<void> onGetDataVoucher() async {
    var accountId = await LocalStorage().onGetUser();
    var storeVouchers = await FirebaseFirestore.instance
      .collection('stores').doc(accountId).collection('store_vouchers')
      .where('is_deleted', isEqualTo: false).get();
    for (var element in storeVouchers.docs) {
      var temp = StoreVoucherModel.fromJson(element.data());
      temp.id =  element.id;
      lsVoucher.add(temp);
    }
    lsVoucher.sort((a, b){
      return a.expDate!.compareTo(b.expDate!);
    });
  }

  Future<void> onDeleteVoucher({required String voucherId}) async {
    var accountId = await LocalStorage().onGetUser();
    var storeVoucherCollection = FirebaseFirestore.instance
      .collection('stores').doc(accountId).collection('store_vouchers');

    await storeVoucherCollection.doc(voucherId)
      .update({'is_deleted': true})
      .then((value) {
        onRefreshPage();
        Get.find<DashboardSellerController>().onRefreshPage();
      })
      .catchError((error) =>
        Get.defaultDialog(
          title: 'Gagal',
          middleText: 'Gagal menghapus voucer',
          textConfirm:'Ok',
          onConfirm: () => Get.back()
        ));
  }

  void onRefreshPage() async {
    isLoading(true);
    lsVoucher.clear();
    await onGetDataVoucher();
    isLoading(false);
  }

  void saveToCloudFirestore() async {
    var accountId = await LocalStorage().onGetUser();
    CollectionReference storeVoucher = FirebaseFirestore.instance
      .collection('stores').doc(accountId).collection('store_vouchers');

    var voucher = {
      'name': fieldName.text,
      'description': fieldDesc.text,
      'exp_date': DateFormat('yyyy-MM-dd').parse(fieldExpDate.text),
      'min_transaction': int.parse(fieldMinTransaction.text),
      'coin': fieldType.value == "Voucer Publik" ? int.parse(fieldCoin.text) : null,
      'qty': fieldType.value == "Voucer Publik" ? int.parse(fieldQty.text) : null,
      'type': fieldType.value.toLowerCase().contains("publik") ?
      "public" : "special",
      'is_deleted': fieldisDelete.value,
    };

    if(isCheckDiscount.isTrue){
      if(fieldTypeDiscount.contains("Persentase")){
        voucher['percentage'] = double.parse(fieldPercentage.text);
        voucher['type_discount'] = 'persentase';
        if(isCheckMaxDisc.isTrue){
          voucher['max_nominal'] = int.parse(fieldNominal.text);
        }

      } else if(fieldTypeDiscount.contains("Nominal")){
        voucher['nominal'] = int.parse(fieldNominal.text);
        voucher['type_discount'] = 'nominal';
      }
    }

    await storeVoucher.add(voucher)
    .then((docRef) =>
            Get.to(() => SuccessCreateVoucher(data: StoreVoucherModel(
              id: docRef.id,
              description: fieldDesc.text,
              expDate: DateFormat('yyyy-MM-dd').parse(fieldExpDate.text),
              minTransaction: int.parse(fieldMinTransaction.text),
              name: fieldName.text,
              coin: fieldType.value == "Voucer Publik" ? int.parse(fieldCoin.text) : null,
              qty: fieldType.value == "Voucer Publik" ? int.parse(fieldQty.text) : null,
              type: fieldType.value.toLowerCase().contains("publik") ?
                "public" : "special"
            )))
          )
    .catchError((error) =>
      Get.defaultDialog(
          title: 'Gagal',
          middleText: 'Data pengguna gagal disimpan',
          textConfirm:'Ok',
          onConfirm: () => Get.back()
      )
    );
  }

  void reuseVoucher(StoreVoucherModel data){
    fieldName.text = data.name!;
    fieldDesc.text = data.description!;
    fieldMinTransaction.text = data.minTransaction.toString();
    fieldCoin.text = data.type!.contains('public') ? data.coin.toString() : "";
    fieldType.value = data.type!.contains('public') ?
      "Voucer Publik" : "Voucer Spesial";

    if(data.typeDiscount != null){
      isCheckDiscount(true);
      if(data.typeDiscount == 'persentase'){
        fieldTypeDiscount.value = "Diskon Persentase";
        fieldPercentage.text = data.percentage.toString();
        if(data.maxNominal != null){
          isCheckMaxDisc(true);
          fieldNominal.text = data.maxNominal.toString();
        }
      } else if(data.typeDiscount == 'nominal'){
        fieldTypeDiscount.value = "Diskon Nominal";
        fieldNominal.text = data.nominal.toString();
      }
    }
    Get.toNamed(AppRoutes.sellercreatevoucher);

  }
}
