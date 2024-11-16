
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/dashboard/views/screens/dashboard_page.dart';
import 'package:projek_skripsi/application/seller/store/views/screens/store_page.dart';
import 'package:projek_skripsi/authorization/data/models/m_store.dart';
import 'package:projek_skripsi/core/components/scanner/views/scanner_page.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/models/m_level.dart';
import 'package:projek_skripsi/core/models/m_storeVoucher.dart';
import 'package:projek_skripsi/core/providers/local_storage.dart';
import 'package:projek_skripsi/utils/routes.dart';

class DashboardSellerController extends GetxController with GetSingleTickerProviderStateMixin{
  var currentIndex = 0.obs;
  var isLoadingUser = false.obs;
  var isLoadingCoupon = false.obs;
  var isLoadingLevel = false.obs;
  var user = StoreModel().obs;
  var nullLevel = 5.obs;
  var tagString = "".obs;
  TabController? tabsController;

  final tabsPage = const [
    SellerDashboardPage(),
    SizedBox(),
    StorePage(),
  ];

  final List<Tab> tabs = const [
    Tab(text: 'Voucer Publik'),
    Tab(text: 'Voucer Spesial'),
  ];

  final List<Color> levelColors = [
    AppThemes.levelColor[1]!,
    AppThemes.levelColor[2]!,
    AppThemes.levelColor[3]!,
    AppThemes.levelColor[4]!,
    AppThemes.levelColor[5]!,
  ];

  var lsLevel = List<LevelModel>.empty(growable: true).obs;
  var lsVoucher = List<StoreVoucherModel>.empty(growable: true).obs;

  @override
  void onInit() {
    tabsController = TabController(length: tabs.length, vsync: this);
    assignUser();
    onGetDataVoucher();
    onGetDataLevel();
    super.onInit();
  }

  void onItemTapped(int index){
    if(index != 1){
      currentIndex.value = index;
    }
  }

  void onScan() async {
    var barcodeResult = await Get.to(() => const QRScanner());
    if(barcodeResult != null){
      Get.toNamed(AppRoutes.sellerscan, arguments: {'qrResult': barcodeResult});
    }
  }

  Future<void> onGetDataVoucher() async {
    isLoadingCoupon(true);
    var storeId = await LocalStorage().onGetUser();
    var storeVouchers = await FirebaseFirestore.instance
      .collection('stores').doc(storeId).collection('store_vouchers')
      .where('is_deleted', isEqualTo: false)
      .get();

    for (var element in storeVouchers.docs) {
      var temp = StoreVoucherModel.fromJson(element.data());
      temp.id =  element.id;
      lsVoucher.add(temp);
    }

    lsVoucher.sort((a, b){
      return a.expDate!.compareTo(b.expDate!);
    });
    isLoadingCoupon(false);
  }

  Future<void> assignUser() async {
    isLoadingUser(true);
    var id = await LocalStorage().onGetUser();
    CollectionReference storeCollection =
        FirebaseFirestore.instance.collection('stores');
    var snapshot = await storeCollection.doc(id).get();

    if (snapshot.exists) {
      user.value = StoreModel.fromJson(snapshot.data() as Map<String, dynamic>);
      user.value.id = snapshot.id;
    }
    for (var i = 0; i < user.value.lsTag!.length; i++) {
      tagString.value += user.value.lsTag![i];
      if (i != user.value.lsTag!.length - 1) {
          tagString.value += ", ";
      }
    }
    isLoadingUser(false);
  }

  Future<void> onGetDataLevel() async {
    isLoadingLevel(true);
    List.generate(5, (index) => lsLevel.add(LevelModel()));
    
    var storeId = await LocalStorage().onGetUser();
    var levelData = await FirebaseFirestore.instance
      .collection('stores').doc(storeId)
      .collection('store_levels').get();

    for(var element in levelData.docs){
      var temp = LevelModel.fromJson(element.data());
      temp.id = element.id;

      var currLevel = int.parse(temp.id!.substring(5));
      if(temp.exp != null && nullLevel.value != 0){
        nullLevel.value -= 1;
      }
      lsLevel[currLevel-1] = temp; 
      
    }
    isLoadingLevel(false);
  }

  void onRefreshPage(){
    lsVoucher.clear();
    tagString.value = '';

    assignUser();
    onGetDataVoucher();
  }
}