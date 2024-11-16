import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projek_skripsi/application/seller/dashboard/controllers/dashboard_seller_controller.dart';
import 'package:projek_skripsi/core/models/m_storeHistory.dart';
import 'package:projek_skripsi/core/providers/local_storage.dart';

class HistorySellerController extends GetxController with GetSingleTickerProviderStateMixin{
  TabController? tabsController;
  var dashboardController = Get.find<DashboardSellerController>();

  final List<Tab> tabs = const [
    Tab(child: Text('Lihat Semua', textAlign: TextAlign.center, style: TextStyle(fontSize: 12),)),
    Tab(child: Text('Transaksi Dengan Voucer', textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
    Tab(child: Text('Transaksi Tanpa Voucer', textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
  ];

  var isLoading = false.obs;

  var lsHistory = List<Map<String,dynamic>>.empty(growable: true).obs;
  var lsHistoryWithCoupon = List<Map<String,dynamic>>.empty(growable: true).obs;
  var lsHistoryWithoutCoupon = List<Map<String,dynamic>>.empty(growable: true).obs;

  @override
  void onInit() async {
    isLoading(true);
    tabsController = TabController(length: tabs.length, vsync: this);
    await onGetHistory();
    await onGetHistoryWithCoupon();
    await onGetHistoryWithoutCoupon();
    isLoading(false);
    super.onInit();
  }

  Future<void> onGetHistory() async {
    var storeId = await LocalStorage().onGetUser();
    var ls = List<StoreHistoryModel>.empty(growable: true);
    var historyCollection = await FirebaseFirestore.instance
      .collection('stores').doc(storeId)
      .collection('store_history').get();

    for(var element in historyCollection.docs){
      var temp = StoreHistoryModel.fromJson(element.data());
      temp.id = element.id;
      ls.add(temp);
    }

    ls.sort((a, b){
      return b.date!.compareTo(a.date!);
    });
    if(ls.isNotEmpty) lsHistory.value = groupbyDate(ls);
  }

  Future<void> onGetHistoryWithCoupon() async {
    var storeId = await LocalStorage().onGetUser();
    var ls = List<StoreHistoryModel>.empty(growable: true);
    var historyCollection = await FirebaseFirestore.instance
      .collection('stores').doc(storeId)
      .collection('store_history')
      .where('voucher_id', isNull: false).get();

    for(var element in historyCollection.docs){
      var temp = StoreHistoryModel.fromJson(element.data());
      temp.id = element.id;
      ls.add(temp);
    }

    ls.sort((a, b){
      return b.date!.compareTo(a.date!);
    });
    if(ls.isNotEmpty) lsHistoryWithCoupon.value = groupbyDate(ls);
  }

  Future<void> onGetHistoryWithoutCoupon() async {
    var storeId = await LocalStorage().onGetUser();
    var ls = List<StoreHistoryModel>.empty(growable: true);
    var historyCollection = await FirebaseFirestore.instance
      .collection('stores').doc(storeId)
      .collection('store_history')
      .where('voucher_id', isNull: true).get();


    for(var element in historyCollection.docs){
      var temp = StoreHistoryModel.fromJson(element.data());
      temp.id = element.id;
      ls.add(temp);
    }

    ls.sort((a, b){
      return b.date!.compareTo(a.date!);
    });
    if(ls.isNotEmpty) lsHistoryWithoutCoupon.value = groupbyDate(ls);
  }

  List<Map<String,dynamic>> groupbyDate(List<StoreHistoryModel> list){
    var newList = List<Map<String,dynamic>>.empty(growable: true);
    var currentDate = DateFormat("dd/MM/yyyy").format(list[0].date!);
    var tempList = List<StoreHistoryModel>.empty(growable: true);
    Map<String,dynamic> tempMap = {};
    var total = 0;

    for(var item in list){
      var dateNow = DateFormat("dd/MM/yyyy").format(item.date!);
      if(currentDate != dateNow){
        tempMap['data'] = List.from(tempList);
        tempMap['total'] = total;
        tempMap['date'] = currentDate;
        newList.add(tempMap);

        total = 0;
        tempList.clear();
        tempMap = {};
        currentDate = dateNow;
      }
      if(item.total != null) total += item.total!;
      tempList.add(item);
    }
    tempMap['data'] = tempList;
    tempMap['total'] = total;
    tempMap['date'] = currentDate;
    newList.add(tempMap);
    return newList;
  }
}