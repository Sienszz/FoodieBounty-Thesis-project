import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/authorization/data/models/m_store.dart';
import 'package:projek_skripsi/core/models/m_customerVoucher.dart';
import 'package:projek_skripsi/core/models/m_storeMembership.dart';
import 'package:projek_skripsi/core/models/m_storeVoucher.dart';
import 'package:projek_skripsi/core/providers/local_storage.dart';

class VoucherBuyerController extends GetxController with GetSingleTickerProviderStateMixin {
  var currentIndex = 0.obs;
  TabController? tabsController;
  var activePage = 0.obs;
  var itemCount = 6.obs;
  var isLoadingCoupon = false.obs;
  var wordTextField = ''.obs;

  final List<Tab> tabs = const [
    Tab(child: Text('Semua Voucer', textAlign: TextAlign.center, style: TextStyle(fontSize: 12),)),
    Tab(child: Text('Toko', textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
  ];

  var isInvisible = List<bool>.empty(growable: true).obs;
  List<Image> lsImage = List<Image>.empty(growable: true).obs;
  var lsStore = List<StoreModel>.empty(growable: true).obs;
  var lsVoucher = List<StoreVoucherModel>.empty(growable: true).obs;
  var lsStoreMembership = List<StoreMembershipModel>.empty(growable: true).obs;
  var lsCustomerVoucher = List<CustomerVoucher>.empty(growable: true).obs;
  List<RxMap<String, dynamic>> lsMergeCompleteVoucher = List<RxMap<String, dynamic>>.empty(growable: true).obs;
  var lsFilterFinalStore = List<RxMap<String, dynamic>>.empty(growable: true).obs;
  List<RxMap<String, dynamic>> lsFilter = [];



  @override
  Future<void> onInit() async {
    super.onInit();
    tabsController = TabController(length: tabs.length, vsync: this);
    isLoadingCoupon(true);
    await onGetDataStore();
    // await onInitStoreMembership();
    await onGetDataVoucher();
    isInvisible.value = List.generate(lsMergeCompleteVoucher.length, (index) => true);
    print(isInvisible.length);
    isLoadingCoupon(false);
    
  }

  void onItemTapped(int index) {
    if (index != 2) {
      currentIndex.value = index;
    }
  }

  Future<void> onGetDataStore() async {
    var stores = await FirebaseFirestore.instance
      .collection('stores').get();

    for(var element in stores.docs){
      var temp = StoreModel.fromJson(element.data());
      temp.id =  element.id;
      lsStore.add(temp);
    }
  }

  Future<void> onGetDataVoucher() async {
    var accountId = await LocalStorage().onGetUser();
    for (var store in lsStore) {
      var customerVouchers = await FirebaseFirestore.instance.collection('customers')
      .doc(accountId).collection('store_membership').doc(store.id).collection('vouchers').get();
      
      for (var element in customerVouchers.docs) {
        var temp = CustomerVoucher.fromJson(element.data());
        temp.id =  element.id;
        lsCustomerVoucher.add(temp);
      }

      List<RxMap<String, dynamic>> lsMergeVoucher = List<RxMap<String, dynamic>>.empty(growable: true).obs;
      var storeVouchers = await FirebaseFirestore.instance
      .collection('stores').doc(store.id).collection('store_vouchers')
      .where('is_deleted', isEqualTo: false)
      .where('type', isEqualTo: 'public')
      .where('qty', isGreaterThan: 0)
      .get();
      // add condition if voucher not buy with customer
      // print("storeVouchers: ${storeVouchers.docs}");
    
      var ctr = 0;
      for (var e in storeVouchers.docs) {
        var temp = StoreVoucherModel.fromJson(e.data());
        temp.id =  e.id;
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
          .collection('stores').doc(store.id).collection('store_vouchers')
          .where('is_deleted', isEqualTo: false)
          .where('type', isEqualTo: 'special')
          .get();

      for (var e in storeVoucherSpecial.docs) {
        var temp = StoreVoucherModel.fromJson(e.data());
        temp.id =  e.id;
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

      if (lsCustomerVoucher.isNotEmpty) {
        print("lsMergeVoucher: $lsMergeVoucher");
        lsMergeCompleteVoucher.add(
          RxMap({
              'StoreName': store.name,
              'MergeCustomerVoucher': lsMergeVoucher,
          })
        );
      }

      lsFilter = lsMergeCompleteVoucher;
      lsFilterFinalStore.value = lsFilter;
  
      lsVoucher.clear();
      // lsMergeVoucher.clear();
      lsCustomerVoucher.clear();
    }
  }
}
