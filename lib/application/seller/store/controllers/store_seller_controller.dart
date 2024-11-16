
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projek_skripsi/authorization/data/models/m_store.dart';
import 'package:projek_skripsi/core/providers/local_storage.dart';
import 'package:projek_skripsi/utils/routes.dart';

class StoreSellerController extends GetxController {
  var user = StoreModel().obs;
  var isLoading = false.obs;

  @override
  void onInit() async {
    isLoading(true);
    await assignUser();
    isLoading(false);
    super.onInit();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(AppRoutes.onBoarding);
  }

  Future<void> assignUser() async {
    var id = await LocalStorage().onGetUser();
    CollectionReference storeCollection =
        FirebaseFirestore.instance.collection('stores');
    var snapshot = await storeCollection.doc(id).get();

    if (snapshot.exists) {
      user.value = StoreModel.fromJson(snapshot.data() as Map<String, dynamic>);
      user.value.id = snapshot.id;
    }
  }
}
