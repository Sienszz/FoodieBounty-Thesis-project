import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projek_skripsi/authorization/data/models/m_customerHistory.dart';
import 'package:projek_skripsi/authorization/data/models/m_store.dart';
import 'package:projek_skripsi/core/models/m_storeVoucher.dart';
import 'package:projek_skripsi/core/providers/local_storage.dart';

class HistoryBuyerController extends GetxController with GetSingleTickerProviderStateMixin {
  var currentIndex = 0.obs;
  var isLoadingHistory = false.obs;
  var accountId;
  TabController? tabsController;
  DateTime? currentDate;

  var lsHistory = List<CustomerHistoryModel>.empty(growable: true).obs;
  var lsHistoryAll = List<dynamic>.empty(growable: true).obs;
  var lsHistoryCoupon = List<dynamic>.empty(growable: true).obs;
  var lsHistoryWithCoupon = List<dynamic>.empty(growable: true).obs;
  var lsHistoryWithoutCoupon = List<dynamic>.empty(growable: true).obs;
  var lsHistorySorted = List<List<CustomerHistoryModel>>.empty(growable: true).obs;

  final List<Tab> tabs = const [
    Tab(child: Text('Lihat Semua', textAlign: TextAlign.center, style: TextStyle(fontSize: 12),)),
    Tab(child: Text('Voucer', textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
    Tab(child: Text('Transaksi Dengan Voucer', textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
    Tab(child: Text('Transaksi Tanpa Voucer', textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
  ];

  var activePage = 0.obs;

  List<Image> lsImage = List<Image>.empty(growable: true).obs;


  @override
  void onInit() async{
    isLoadingHistory(true);
    tabsController = TabController(length: tabs.length, vsync: this);
    accountId = await LocalStorage().onGetUser();
    await onGetDataHistory();
    isLoadingHistory(false);
    super.onInit();
  }
  Future<void> onGetDataHistory() async {
    var history = await FirebaseFirestore.instance
        .collection('customers').doc(accountId).collection('customer_history').get();
    for(var element in history.docs){
      var temp = CustomerHistoryModel.fromJson(element.data());
      temp.id =  element.id;
      StoreModel storeModel;
      var storeSnapshot = await FirebaseFirestore.instance
          .collection('stores')
          .doc(temp.storeId)
          .get();
      storeModel = StoreModel.fromJson( storeSnapshot.data()!);
      storeModel.id = storeSnapshot.id;
      temp.storeModel =  storeModel;
      StoreVoucherModel voucherModel;
      if(temp.voucherid != null){
        var voucherSnapshot = await FirebaseFirestore.instance
            .collection('stores')
            .doc(temp.storeId)
            .collection('store_vouchers')
            .doc(temp.voucherid)
            .get();
        voucherModel = StoreVoucherModel.fromJson( voucherSnapshot.data()!);
        voucherModel.id = temp.voucherid;
        temp.voucherModel = voucherModel;
      }
      lsHistory.add(temp);
    }

    lsHistory.sort((a,b){
      return b.transactionDate!.compareTo(a.transactionDate!);
    });

    var temp = List<CustomerHistoryModel>.empty(growable: true);
    if(lsHistory.isNotEmpty) lsHistoryAll.value = groupbyDate(lsHistory);

    temp.clear();
    for(var item in lsHistory){
      if(item.type! == "voucher") temp.add(item);
    }
    if(temp.isNotEmpty) lsHistoryCoupon.value = groupbyDate(temp);

    temp.clear();
    for(var item in lsHistory){
      if(item.type! == "transaction" && item.voucherid != null) temp.add(item);
    }
    if(temp.isNotEmpty) lsHistoryWithCoupon.value = groupbyDate(temp);

    temp.clear();
    for(var item in lsHistory){
      if(item.type! == "transaction" && item.voucherid == null) temp.add(item);
    }
    if(temp.isNotEmpty) lsHistoryWithoutCoupon.value = groupbyDate(temp);
  }

  List<dynamic> groupbyDate(List<CustomerHistoryModel> list){
    var newList = List<dynamic>.empty(growable: true);
    var currentDate = DateFormat("dd/MM/yyyy").format(list[0].transactionDate!);
    var tempList = List<CustomerHistoryModel>.empty(growable: true);
    Map<String,dynamic> tempMap = {};
    // var total = 0;

    for(var item in list){
      var dateNow = DateFormat("dd/MM/yyyy").format(item.transactionDate!);
      if(currentDate != dateNow){
        tempMap['data'] = List.from(tempList);
        // tempMap['total'] = total;
        tempMap['date'] = currentDate;
        newList.add(tempMap);

        // total = 0;
        tempList.clear();
        tempMap = {};
        currentDate = dateNow;
      }
      // if(item.totalPrice != null) total += item.totalPrice!;
      tempList.add(item);
    }
    tempMap['data'] = tempList;
    // tempMap['total'] = total;
    tempMap['date'] = currentDate;
    newList.add(tempMap);
    return newList;
  }

  void onItemTapped(int index) {
    if (index != 2) {
      currentIndex.value = index;
    }
  }
}
