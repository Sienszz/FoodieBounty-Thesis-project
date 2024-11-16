
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/dashboard_buyer_controller.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/widgets/dialog_widget.dart';
import 'package:projek_skripsi/authorization/data/models/m_store.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/core/models/m_customerVoucher.dart';
import 'package:projek_skripsi/core/models/m_level.dart';
import 'package:projek_skripsi/core/models/m_storeMembership.dart';
import 'package:projek_skripsi/core/models/m_storeVoucher.dart';
import 'package:projek_skripsi/core/providers/local_storage.dart';
import 'package:projek_skripsi/utils/routes.dart';
import 'package:uuid/uuid.dart';
import 'package:audioplayers/audioplayers.dart';

class StoreDetailController extends GetxController with GetTickerProviderStateMixin{
  StoreDetailController(this.arguments);
  Map arguments;

  TabController? tabsController;
  var valueLevel = 100.0.obs;
  var storeId = ''.obs; // selected store
  var userId = ''.obs;
  var isOpen = false.obs;
  var isLoading = false.obs;
  var isLoadingCoupon = false.obs;
  var storeMembership = StoreMembershipModel().obs;
  List<RxMap<String, dynamic>> lsMergeVoucher = List<RxMap<String, dynamic>>.empty(growable: true).obs;

  final player = AudioPlayer();

  final List<Tab> tabs = const [
    Tab(text: 'Voucer Toko'),
    Tab(text: 'Voucer Saya'),
  ];

  var lsVoucher = List<StoreVoucherModel>.empty(growable: true).obs;
  var lsCustomerVoucher = List<CustomerVoucher>.empty(growable: true).obs;

  @override
  void onInit() async {
    isLoading(true);
    storeId.value = arguments['store'].id;
    storeMembership.value = arguments['store'];
    userId.value = await LocalStorage().onGetUser();
    tabsController = TabController(length: tabs.length, vsync: this);
    // await onInitStoreMembership();
    await onGetDataVoucher();
    isLoading(false);
    super.onInit();
  }

  Future<void> refreshData() async {
    // isLoading(true);
    lsVoucher.clear();
    lsCustomerVoucher.clear();
    storeMembership = StoreMembershipModel().obs;
    lsMergeVoucher.clear();
    storeId.value = arguments['store'].id;
    await onGetDataStoreMembership();
    print(storeMembership.value.coin!);
    tabsController = TabController(length: tabs.length, vsync: this);
    // await onInitStoreMembership();
    await onGetDataVoucher();
    // isLoading(false);
    
  }

  Future<void> onGetDataStoreMembership() async {
    var accountId = await LocalStorage().onGetUser();
    var storesRaw = await FirebaseFirestore.instance
      .collection('stores').doc(storeId.value).get();
    var store = StoreModel.fromJson(storesRaw.data()!);
    store.id = storeId.value;
    var storeLevels = await FirebaseFirestore.instance
      .collection('stores').doc(store.id)
      .collection('store_levels').get();
      print("storeLevel: ${store.lsLevel}");
      print("length: ${storeLevels.docs.length == 5}");
    if(storeLevels.docs.length == 5){
      var lsLevel = List<LevelModel>.empty(growable: true).obs;
      for(var element in storeLevels.docs){
        var temp = LevelModel.fromJson(element.data());
        temp.id = element.id;
        lsLevel.add(temp);
      }
      store.lsLevel = lsLevel;
      var storeMemberships = await FirebaseFirestore.instance
      .collection('customers').doc(accountId).collection('store_membership').doc(storeId.value).get();
      storeMembership.value = StoreMembershipModel.fromJson(storeMemberships.data()!);
      storeMembership.value.name = store.name!;
      storeMembership.value.longitude = store.longitude!;
      storeMembership.value.imgUrl = store.imgUrl!;
      storeMembership.value.latitude = store.latitude!;
      storeMembership.value.tag = store.lsTag;
      storeMembership.value.lsLevelStore = store.lsLevel;
    }
    
  }
  
  Future<void> onGetDataVoucher() async {
    isLoadingCoupon(true);
    var accountId = await LocalStorage().onGetUser();

    var customerVouchers = await FirebaseFirestore.instance.collection('customers')
    .doc(accountId).collection('store_membership').doc(storeId.value).collection('vouchers').get();
    
    for (var element in customerVouchers.docs) {
      var temp = CustomerVoucher.fromJson(element.data());
      temp.id =  element.id;
      lsCustomerVoucher.add(temp);
    }

    var storeVouchers = await FirebaseFirestore.instance
      .collection('stores').doc(storeId.value).collection('store_vouchers')
      .where('is_deleted', isEqualTo: false)
      .where('type', isEqualTo: 'public')
      .where('qty', isGreaterThan: 0)
      .get();

    var ctr = 0;
    for (var e in storeVouchers.docs) {
      var temp = StoreVoucherModel.fromJson(e.data());
      temp.id = e.id;
      for(var element in lsCustomerVoucher) {
        if(element.voucherId == temp.id){
          lsMergeVoucher.add(
          RxMap({
                'StoreVoucher': temp,
                'CustomerVoucherId': element.id
            })
          );
        }
      }
      if(ctr == lsMergeVoucher.length) {
        lsVoucher.add(temp);
      } else if(ctr != lsMergeVoucher.length) {
        ctr = lsMergeVoucher.length;
      }
    }

    var storeVoucherSpecial = await FirebaseFirestore.instance
        .collection('stores').doc(storeId.value).collection('store_vouchers')
        .where('is_deleted', isEqualTo: false)
        .where('type', isEqualTo: 'special')
        .get();

    for (var e in storeVoucherSpecial.docs) {
      var temp = StoreVoucherModel.fromJson(e.data());
      temp.id = e.id;
      for(var element in lsCustomerVoucher) {
        if(element.voucherId == temp.id){
          lsMergeVoucher.add(
              RxMap({
                'StoreVoucher': temp,
                'CustomerVoucherId': element.id
              })
          );
        }
      }
    }

    for(var e in lsCustomerVoucher){
      var storeVoucher = lsVoucher.firstWhereOrNull((element) => element.id == e.voucherId);
      if(storeVoucher != null){
        print("storeVoucher: ${storeVoucher.id}");
        lsVoucher.removeWhere((element) => element.id == e.voucherId);
      }
    }
    isLoadingCoupon(false);
  }
  
  void onBuyVoucher({required String voucherId}) async {
    DialogComponent().onLoadingDismissible();
    var accountId = await LocalStorage().onGetUser();

    // check qty
    var voucherDoc = FirebaseFirestore.instance.collection('stores')
      .doc(storeId.value).collection('store_vouchers').doc(voucherId);
    var voucherData = await voucherDoc.get();
    if(voucherData.data()!['qty'] <= 0){
      Get.isDialogOpen != null && Get.isDialogOpen! == true ? Get.back() : null;
      Get.defaultDialog(
          title: 'Gagal',
          middleText: 'Stok Habis',
          textCancel:'Ok',
      );
      return;
    }

    // check coin
    var membershipDoc = FirebaseFirestore.instance.collection('customers')
      .doc(accountId).collection('store_membership').doc(storeId.value);
    var membershipData = await membershipDoc.get();
    if(membershipData.data()!['coin'] < voucherData.data()!['coin']){
      Get.isDialogOpen != null && Get.isDialogOpen! == true ? Get.back() : null;
      Get.defaultDialog(
          title: 'Gagal',
          middleText: 'Koin tidak mencukupi',
          textCancel:'Ok',
      );
      return;
    }

    var customerVoucherId = accountId.substring(accountId.length-3)
        + storeId.value.substring(storeId.value.length-3) + (const Uuid().v6());
    CollectionReference voucherCollection = FirebaseFirestore.instance.collection('customers')
      .doc(accountId).collection('store_membership').doc(storeId.value).collection('vouchers');
    await voucherCollection.doc(customerVoucherId).set({
      'voucher_id': voucherId,
      'exp_date': voucherData.data()!['exp_date'],
      'purchase_date': Timestamp.fromDate(DateTime.now())
    })
      .then((v) async {
        var historyCollection = FirebaseFirestore.instance.collection('customers')
            .doc(accountId).collection('customer_history');

        await voucherDoc.update({
          'qty': voucherData.data()!['qty'] - 1
        });
        await membershipDoc.update({
          'coin': membershipData.data()!['coin'] - voucherData.data()!['coin'],
          'total_voucher': (await voucherCollection.get()).size
        });

        print("storeMembership: ${storeMembership.value.id}");

        await historyCollection.add({
          'store_id': storeMembership.value.id ?? storeId.value,
          'total_coin': voucherData.data()!['coin'],
          'date': Timestamp.fromDate(DateTime.now()),
          'type': "voucher",
          'voucher_id': voucherId,
        });
        
        await player.play(AssetSource('sfx/voucher-transaction.mp3'));
        Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
        DialogWidget().popupVoucher(name: voucherData.data()!['name']);
      });
  }

  Stream streamData() {
    Stream item = FirebaseFirestore.instance
        .collection('customers').doc(userId.value)
        .collection('customer_history')
        .where('transaction_success', isEqualTo: false)
        .where('type', isEqualTo: 'transaction')
        .orderBy('date', descending: true)
        .snapshots();
    return item;
  }

  updateTransactionSuccessfull(var id) async {
    FirebaseFirestore.instance
        .collection('customers').doc(userId.value)
        .collection('customer_history').doc(id)
        .update({'transaction_success': true});
  }

  onGetReward() async {
    var accountId = await LocalStorage().onGetUser();
    var accountCollection = FirebaseFirestore.instance
        .collection('customers').doc(accountId);
    int membershipExp = storeMembership.value.exp!;
    var levelStore = storeMembership.value.lsLevelStore!
      [storeMembership.value.level!-1];
    if(membershipExp >= levelStore.exp!){
      // update level and exp
      await accountCollection
          .collection('store_membership').doc(storeId.value)
          .update({'exp': membershipExp - levelStore.exp!,
          'level': storeMembership.value.level! + 1});

      // get reward and update membership
      var storeMembershipDoc = accountCollection
          .collection('store_membership').doc(storeId.value);
      if(levelStore.coinReward != null){
        await storeMembershipDoc.update({
          'coin': storeMembership.value.coin! + levelStore.coinReward!
        });
      }
      
      if(levelStore.voucherReward != null){
        
        await storeMembershipDoc.update({
          'total_voucher': storeMembership.value.totalVoucher! + levelStore.voucherReward!.length
        });
      }

      // get all voucher
      var storeVouchers = await FirebaseFirestore.instance
          .collection('stores').doc(storeId.value)
          .collection('store_vouchers').get();
      var lsVouchers = List<StoreVoucherModel>.empty(growable: true);
      for(var e in storeVouchers.docs){
        var temp = StoreVoucherModel.fromJson(e.data());
        temp.id = e.id;
        lsVouchers.add(temp);
      }

      // add customer voucher
      if (levelStore.voucherReward != null) {
        for(var e in levelStore.voucherReward!){
          var customerVoucherId = accountId.substring(accountId.length-3)
              + storeId.value.substring(storeId.value.length-3) + (const Uuid().v6());
          var voucher = lsVouchers.firstWhereOrNull((element) => element.id == e['id']);
          await accountCollection
            .collection('store_membership').doc(storeId.value)
            .collection('vouchers').doc(customerVoucherId).set({
              'voucher_id': voucher!.id,
              'exp_date': Timestamp.fromDate(voucher.expDate!),
              'purchase_date': Timestamp.fromDate(DateTime.now())
            });
        }
      }
      isLoading(true);
      await Get.find<DashboardBuyerController>().refreshData();
      await refreshData();
      isLoading(false);
      await player.play(AssetSource('sfx/claim-reward.mp3'));
      DialogComponent().popupReward(levelStore.coinReward ?? -1,
          levelStore.voucherReward?.length ?? -1);
    }
  }
}



