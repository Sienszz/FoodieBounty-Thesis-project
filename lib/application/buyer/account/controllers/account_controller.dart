import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/authorization/data/models/m_store.dart';
import 'package:projek_skripsi/core/models/m_storeMembership.dart';
import '../../../../authorization/data/models/m_buyer.dart';
import '../../../../utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projek_skripsi/core/providers/local_storage.dart';

class BuyerAccountController extends GetxController {
  var user = BuyerModel().obs;
  var isLoading = false.obs;
  var mostCoinStoreMembership = StoreMembershipModel().obs;
  var mostVoucherStoreMembership = StoreMembershipModel().obs;

  @override
  void onInit() async {
    isLoading(true);
    await assignUser();
    await onGetInfographic();
    isLoading(false);
    super.onInit();
  }

  Future<void> onRefresh() async {
    isLoading(true);
    await assignUser();
    await onGetInfographic();
    isLoading(false);
  }
  
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(AppRoutes.onBoarding);
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

  Future<void> onGetInfographic() async {
    var accountId = await LocalStorage().onGetUser();
    var mostStoreCoin = await FirebaseFirestore.instance
      .collection('customers').doc(accountId).collection('store_membership')
      .orderBy('coin', descending: true)
      .limit(1)
      .get();
    if (mostStoreCoin.docs.isNotEmpty) {
      mostCoinStoreMembership.value = StoreMembershipModel.fromJson(mostStoreCoin.docs[0].data());
      mostCoinStoreMembership.value.id = mostStoreCoin.docs[0].id;
      var theStore = await FirebaseFirestore.instance
      .collection('stores').doc(mostCoinStoreMembership.value.id).get();
    
      if(theStore.data() != null) {
        var temp = StoreModel.fromJson(theStore.data() as Map<String,dynamic>);
        mostCoinStoreMembership.value.name = temp.name;
      }
    }
    var mostVoucherStore = await FirebaseFirestore.instance
      .collection('customers')
      .doc(accountId).collection('store_membership')
      .orderBy('total_voucher', descending: true)
      .limit(1)
      .get();

    if (mostVoucherStore.docs.isNotEmpty) {
      mostVoucherStoreMembership.value = StoreMembershipModel.fromJson(mostVoucherStore.docs[0].data());
      mostVoucherStoreMembership.value.id = mostVoucherStore.docs[0].id;
      var theStore = await FirebaseFirestore.instance
      .collection('stores').doc(mostVoucherStoreMembership.value.id).get();

      if(theStore.data() != null) {
        var temp = StoreModel.fromJson(theStore.data() as Map<String,dynamic>);
        print("temp Name: ${temp.name}");
        mostVoucherStoreMembership.value.name = temp.name;
      }
      
    }

  }

}