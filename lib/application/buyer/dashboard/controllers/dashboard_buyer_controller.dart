import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:projek_skripsi/application/buyer/history/views/screen/history_buyer_page.dart';
import 'package:projek_skripsi/application/buyer/voucher/views/screen/voucher_buyer_page.dart';
import 'package:projek_skripsi/authorization/data/models/m_buyer.dart';
import 'package:projek_skripsi/authorization/data/models/m_store.dart';
import 'package:projek_skripsi/application/buyer/account/views/screens/account_page.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/screens/dashboard_page.dart';
import 'package:projek_skripsi/core/models/m_level.dart';
import 'package:projek_skripsi/core/models/m_storeMembership.dart';
import 'package:projek_skripsi/core/models/m_storeVoucher.dart';
import 'package:projek_skripsi/core/providers/local_storage.dart';
import 'package:uuid/uuid.dart';

class DashboardBuyerController extends GetxController with GetSingleTickerProviderStateMixin {
  var currentIndex = 0.obs;
  var activePage = 0.obs;
  var ExpandMoreStoreTitle = 'Nearby'.obs;
  var isLoadingUser = false.obs;
  var user = BuyerModel().obs;
  var wordTextField = ''.obs;
  var isOpen = false.obs;
  var currentLocation = Position(
    longitude: 0.0,
    latitude: 0.0,
    timestamp: DateTime.now(),
    accuracy: 0.0,
    altitude: 0.0,
    altitudeAccuracy: 0.0,
    heading: 0.0,
    headingAccuracy: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0
  ).obs;

  List<String> imagePaths = [
    'assets/vector/rice.jpg',
    'assets/vector/vegetable.jpeg',
    'assets/vector/nuts.jpeg',
    'assets/vector/noodle.jpeg',
    'assets/vector/fastfood.jpeg',
    'assets/vector/snacks.jpg',
    'assets/vector/seafood.jpg',
    'assets/vector/pastry.jpeg',
    'assets/vector/coffee.jpeg',
    'assets/vector/meat.jpeg',
    'assets/vector/sweets.jpeg',
    'assets/vector/beverages.jpeg'
  ];
  final tabsPage = const [
    BuyerDashboardPage(),
    VoucherBuyerPage(),
    BuyerDashboardPage(),
    HistoryBuyerPage(),
    AccountPage()
  ];

  List<Image> images = [
    Image.asset('assets/photo/photo_ads_1.png', fit: BoxFit.cover, width: Get.size.width),
    Image.asset('assets/photo/photo_ads_2.png', fit: BoxFit.cover, width: Get.size.width),
  ].obs;
  List<Image> lsImage = List<Image>.empty(growable: true).obs;
  var lsStore = List<StoreModel>.empty(growable: true).obs;
  var lsStoreMembership = List<StoreMembershipModel>.empty(growable: true).obs;
  var lsFilterStore = List<StoreMembershipModel>.empty(growable: true).obs;
  List<StoreMembershipModel> lsFilter = [];
  var lsLevel = List<LevelModel>.empty(growable: true).obs;

  var lsStoreRice = List<StoreMembershipModel>.empty(growable: true).obs;
  var lsStoreNoodles = List<StoreMembershipModel>.empty(growable: true).obs;
  var lsStoreSeaFood = List<StoreMembershipModel>.empty(growable: true).obs;
  var lsStoreMeat = List<StoreMembershipModel>.empty(growable: true).obs;
  var lsStoreVegetables = List<StoreMembershipModel>.empty(growable: true).obs;
  var lsStoreFastFood = List<StoreMembershipModel>.empty(growable: true).obs;
  var lsStorePastry = List<StoreMembershipModel>.empty(growable: true).obs;
  var lsStoreSweets = List<StoreMembershipModel>.empty(growable: true).obs;
  var lsStoreNuts = List<StoreMembershipModel>.empty(growable: true).obs;
  var lsStoreSnacks = List<StoreMembershipModel>.empty(growable: true).obs;
  var lsStoreCoffee = List<StoreMembershipModel>.empty(growable: true).obs;
  var lsStoreBeverages = List<StoreMembershipModel>.empty(growable: true).obs;

  @override
  void onInit() async {
    isLoadingUser(true);
    // await precacheImage(const AssetImage('assets/photo/photo_ads.png'), Get.context!);
    // await precacheImage(const AssetImage('assets/photo/photo_1.jpeg'), Get.context!);
    // await loadCachedImages();
    var storageperm = await Permission.storage.request();
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    await assignUser();
    await onInitMembership();
    if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
      await onInitNearbyStore();
    }
    onInitStoreCategory();
    await onCheckResetLevel();
    isLoadingUser(false);
    super.onInit();
  }

  Future<void> loadCachedImages() async {
    double cacheHeight = Get.size.height * 0.08;
    double cacheWidth = Get.size.width * 0.08;
    isLoadingUser(true);
    for (String imagePath in imagePaths) {
      await precacheImage(AssetImage(imagePath), Get.context!, size: Size(cacheWidth, cacheWidth));
    }
    isLoadingUser(false);
  }

  void onItemTapped(int index) {
    if (index != 2) {
      currentIndex.value = index;
    }
  }

  Future<void> refreshData() async {
    isLoadingUser(true);
    lsImage.clear();
    lsStore.clear();
    lsStoreMembership.clear();

    lsStoreRice.clear();
    lsStoreNoodles.clear();
    lsStoreSeaFood.clear();
    lsStoreMeat.clear();
    lsStoreVegetables.clear();
    lsStoreFastFood.clear();
    lsStorePastry.clear();
    lsStoreSweets.clear();
    lsStoreNuts.clear();
    lsStoreSnacks.clear();
    lsStoreCoffee.clear();
    lsStoreBeverages.clear();

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    await assignUser();
    await onInitMembership();
    if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
      await onInitNearbyStore();
    }
    onInitStoreCategory();
    await onCheckResetLevel();
    isLoadingUser(false);
  }

  Future<void> assignUser() async {
    var id = await LocalStorage().onGetUser();
    CollectionReference storeCollection =
        FirebaseFirestore.instance.collection('customers');
    var snapshot = await storeCollection.doc(id).get();

    if (snapshot.exists) {
      user.value = BuyerModel.fromJson(snapshot.data() as Map<String, dynamic>);
      user.value.id = snapshot.id;
    }
  }

  Future<void> onInitMembership() async {
    await onGetDataStore();
    await onGetDataLevel();
    await onGetDataStoreMembership();
    onCompleteData();
  }

  Future<void> onGetDataStore() async {
    var stores = await FirebaseFirestore.instance
      .collection('stores').get();

    for(var element in stores.docs){
      var storeLevels = await FirebaseFirestore.instance
          .collection('stores').doc(element.id)
          .collection('store_levels').get();

      var temp = StoreModel.fromJson(element.data());
      temp.id =  element.id;
      if(storeLevels.docs.length == 5){
        lsStore.add(temp);
      }
    }
  }
  Future<void> onGetDataStoreMembership() async {
    var accountId = await LocalStorage().onGetUser();
    var storeMemberships = await FirebaseFirestore.instance
      .collection('customers').doc(accountId).collection('store_membership').get();
    for(var element in storeMemberships.docs){
      var temp = StoreMembershipModel.fromJson(element.data());
      temp.id =  element.id;
      lsStoreMembership.add(temp);
    }
  }

  Future<void> onInitNearbyStore() async {
    currentLocation.value = (await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high));
    sortNearby();
  }

  Future<void> onGetDataLevel() async {
    isLoadingUser(true);
    for(var i = 0 ; i < lsStore.length ; i++) {
      var lsLevel = List<LevelModel>.empty(growable: true);
      List.generate(5, (index) => lsLevel.add(LevelModel()));
      var levelData = await FirebaseFirestore.instance
      .collection('stores').doc(lsStore[i].id)
      .collection('store_levels').get();

      for(var element in levelData.docs){
        var temp = LevelModel.fromJson(element.data());
        temp.id = element.id;

        var currLevel = int.parse(temp.id!.substring(5));
        lsLevel[currLevel-1] = temp; 
      }
      lsStore[i].lsLevel = lsLevel;
    }
    isLoadingUser(false);
  }

  void onCompleteData(){
    for(var e in lsStore){
      var membership = lsStoreMembership.firstWhereOrNull((element) => element.id == e.id!);
      if(membership == null){
        // temp data for show on dashboard
        var temp = StoreMembershipModel();
        temp.id = e.id!;
        temp.name = e.name!;
        temp.imgUrl = e.imgUrl!;
        temp.longitude = e.longitude!;
        temp.latitude = e.latitude!;
        temp.lsLevelStore = e.lsLevel;
        temp.tag = e.lsTag;
        temp.level = 0;
        temp.coin = 0;
        temp.exp = 0;
        temp.totalVoucher = 0;
        lsStoreMembership.add(temp);
      } else {
        membership.name = e.name!;
        membership.imgUrl = e.imgUrl!;
        membership.longitude = e.longitude!;
        membership.latitude = e.latitude!;
        membership.tag = e.lsTag;
        membership.lsLevelStore = e.lsLevel;
      }
    }
  }

  void onInitStoreCategory() {
    for (var e in lsStoreMembership) {
      if (e.tag!.contains("Nasi")) {
        lsStoreRice.add(e);
      }
      if (e.tag!.contains("Mie")) {
        lsStoreNoodles.add(e);
      }
      if (e.tag!.contains("Makanan Laut")) {
        lsStoreSeaFood.add(e);
      }
      if (e.tag!.contains("Daging")) {
        lsStoreMeat.add(e);
      }
      if (e.tag!.contains("Sayuran")) {
        lsStoreVegetables.add(e);
      }
      if (e.tag!.contains("Cepat Saji")) {
        lsStoreFastFood.add(e);
      }
      if (e.tag!.contains("Kue")) {
        lsStorePastry.add(e);
      }
      if (e.tag!.contains("Manis")) {
        lsStoreSweets.add(e);
      }
      if (e.tag!.contains("Kacang")) {
        lsStoreNuts.add(e);
      }
      if (e.tag!.contains("Cemilan")) {
        lsStoreSnacks.add(e);
      }
      if (e.tag!.contains("Kopi")) {
        lsStoreCoffee.add(e);
        print("Coffee: ${e.tag}");
      } 
      if (e.tag!.contains("Minuman")) {
        lsStoreBeverages.add(e);
        print("Beverage: ${e.tag}");
      } 
    }
  }

  void sortNearby() {
    for(var e in lsStoreMembership){
      e.distanceWithUser = getDistance(e.latitude!, e.longitude!) / 1000;
    }
    lsStoreMembership.sort((a,b) => a.distanceWithUser.compareTo(b.distanceWithUser));
  }

  double getDistance(double latitude, double longitude) {
    return Geolocator.distanceBetween(
      currentLocation.value.latitude,
      currentLocation.value.longitude,
      latitude,
      longitude
    );
  }

  Future<void> onCheckResetLevel() async {
    var accountId = await LocalStorage().onGetUser();
    var accountCollection = FirebaseFirestore.instance
        .collection('customers').doc(accountId);

    var dateNow = DateTime.now();
    var lessThanNowYear = user.value.resetDate!.year < dateNow.year;
    if( (dateNow.month >= 1 && dateNow.month <= 6 && (user.value.resetDate!.month > 6 || lessThanNowYear)) ||
        (dateNow.month >= 7 && dateNow.month <= 12 && (user.value.resetDate!.month < 7 || lessThanNowYear))
      ){

      // get all reward
      for(var element in lsStoreMembership){
        var store = lsStore.firstWhere((e) => e.id == element.id);

        var membershipExp = element.exp!;
        var currLevel = element.level!;

        if(currLevel == 0) continue;
        var levelStore = store.lsLevel[currLevel - 1];

        var coin = 0;
        var lsVoucherReward = [];

        // get reward for every level
        while(levelStore.exp! <= membershipExp){
          membershipExp -= levelStore.exp!;
          if(levelStore.coinReward != null){
            coin += levelStore.coinReward!;
          }
          if(levelStore.voucherReward != null){
            lsVoucherReward.addAll(levelStore.voucherReward!);
          }
          if(currLevel == 5) break;
          currLevel++;
          levelStore = store.lsLevel[currLevel-1];
        }

        // update reward firebase
        await accountCollection.collection('store_membership')
          .doc(store.id).update({
            'coin': element.coin! + coin,
            'total_voucher': element.totalVoucher! + lsVoucherReward.length
        });

        // get all voucher
        var storeVouchers = await FirebaseFirestore.instance
          .collection('stores').doc(store.id)
          .collection('store_vouchers').get();
        var lsVouchers = List<StoreVoucherModel>.empty(growable: true);
        for(var e in storeVouchers.docs){
          var temp = StoreVoucherModel.fromJson(e.data());
          temp.id = e.id;
          lsVouchers.add(temp);
        }

        // update get voucher
        for(var e in lsVoucherReward){
          var customerVoucherId = accountId.substring(accountId.length-3)
              + store.id!.substring(store.id!.length-3) + (const Uuid().v6());
          var voucher = lsVouchers.firstWhereOrNull((element) => element.id == e['id']);
          await accountCollection.collection('store_membership')
              .doc(store.id).collection('vouchers')
              .doc(customerVoucherId).set({
                'voucher_id': voucher!.id,
                'exp_date': Timestamp.fromDate(voucher.expDate!),
                'purchase_date': Timestamp.fromDate(DateTime.now())
              });
        }
      }

      // update reset
      await accountCollection.update(
          {'reset_date': Timestamp.fromDate(DateTime.now())});
      for(var element in lsStoreMembership){
        await accountCollection.collection('store_membership')
            .doc(element.id!).update({'exp': 0, 'level': 0});
      }
    }
  }

  Stream streamData() {
    Stream item = FirebaseFirestore.instance
        .collection('customers').doc(user.value.id!)
        .collection('customer_history')
        .where('transaction_success', isEqualTo: false)
        .where('type', isEqualTo: 'transaction')
        .orderBy('date', descending: true)
        .snapshots();
    return item;
  }

  updateTransactionSuccessfull(var id) async {
    FirebaseFirestore.instance
      .collection('customers').doc(user.value.id)
      .collection('customer_history').doc(id)
      .update({'transaction_success': true});
  }
  StoreMembershipModel getStoreleveledUp(var storeId) {
    var storeMembership = lsStoreMembership.firstWhereOrNull((element) => element.id == storeId);
    return storeMembership!;
  }

  bool isLevelUp({required String storeId}) {
    var storeMembership = lsStoreMembership.firstWhereOrNull((element) => element.id == storeId);
    return storeMembership!.exp! >= storeMembership!.lsLevelStore![storeMembership.level!-1 <= 4 ? storeMembership.level!-1 : 4].exp! ?
      true : false ;
  }

  int getLevel({required String storeId}) {
    var storeMembership = lsStoreMembership.firstWhereOrNull((element) => element.id == storeId);
    return storeMembership!.level!;
  }
}
