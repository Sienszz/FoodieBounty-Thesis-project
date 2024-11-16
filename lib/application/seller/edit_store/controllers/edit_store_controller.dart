import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/dashboard/controllers/dashboard_seller_controller.dart';
import 'package:projek_skripsi/authorization/modules/register/seller_register/controllers/seller_attachment_controller.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/core/components/map/controllers/maps_controller.dart';
import 'package:projek_skripsi/core/providers/local_storage.dart';
import 'package:projek_skripsi/utils/routes.dart';


class EditStoreController extends GetxController {
  var formKey = GlobalKey<FormState>();

  var errorMsg = ''.obs;
  var countTag = 0.obs;

  var fieldName = TextEditingController();
  var fieldEmail = TextEditingController();
  var fieldPassword = TextEditingController();
  var fieldConfirmPassword = TextEditingController();
  var fieldPhoneNumber = TextEditingController();
  var fieldAddress = TextEditingController();
  var fieldTag = TextEditingController();

  var mapController = Get.put(MapsController());
  var attController = Get.put(SellerAttachmentController());
  var dashboardController = Get.find<DashboardSellerController>();

  var lsTag = List<dynamic>.empty(growable: true).obs;

  @override
  void onInit() async {
    initTag();
    onInitForm();
    super.onInit();
  }

  void initTag(){
    var temp = ['Minuman', 'Kopi', 'Cepat Saji', 'Daging', 'Mie',
      'Kacang', 'Kue', 'Nasi', 'Makanan Laut', 'Ceminal', 'Manis', 'Sayuran'];
    for(var e in temp) {
      lsTag.add({
        'isClick': false,
        'name': e
      });
    }
  }

  void onInitForm() {
    var user = dashboardController.user.value;
    fieldName.text = user.name!;
    fieldEmail.text = user.email!;
    fieldPhoneNumber.text = user.phoneNumber!;
    fieldAddress.text = user.address!;
    attController.imgUrl.value = user.imgUrl!;
    mapController.latitude.value = user.latitude!;
    mapController.longitude.value = user.longitude!;
    for(var e in user.lsTag!){
      lsTag.firstWhere((element) => element['name'] == e)['isClick'] = true;
    }
    countTag.value = user.lsTag!.length;
  }

  void onSave() async {
    errorMsg.value = '';
    if(!isTagValidate()) {
      errorMsg.value = 'Tag must filled minimum one';
    }
    if(formKey.currentState!.validate() && errorMsg.value == '' &&
        ((attController.imgUrl.value == '' && attController.imgPath.value != '') 
          || attController.imgUrl.value != '')
      ){
      DialogComponent().onLoadingDismissible();

      if(attController.imgUrl.value == ''){
        await attController.uploadFileToFirebase();
        if(attController.imgUrl.value == '') {
          Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
          Get.defaultDialog(
              title: 'Failed',
              middleText: 'Failed upload photo',
              textCancel:'Ok',
          );
          return;
        }
      }

      await saveToCloudFirestore();
    }
  }
  
  Future<void> saveToCloudFirestore() async {
    var storeId = await LocalStorage().onGetUser();
    var storeDoc = FirebaseFirestore.instance
      .collection('stores').doc(storeId);

    await storeDoc.update({
      'name': fieldName.text,
      'phone_number': fieldPhoneNumber.text,
      'address': fieldAddress.text,
      'img_url': attController.imgUrl.value,
      'tag': getTag(),
      'latitude': mapController.latitude.value.toString(),
      'longitude': mapController.longitude.value.toString(),
    })
        .then((value) {
          Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
          Get.defaultDialog(
              title: 'Success',
              middleText: 'User data has been successfully update',
              textConfirm:'Ok',
              onConfirm: () {
                Get.offAllNamed(AppRoutes.sellerdashboard);
              }
          );
        })
        .catchError((error) {
          Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
          Get.defaultDialog(
              title: 'Failed',
              middleText: 'User data failed to update',
              textConfirm:'Ok',
              onConfirm: () => Get.back()
          );});
  }

  void onGetAddress(){
    fieldAddress.text = mapController.address.value;
  }

  bool isTagValidate(){
    var check = lsTag.firstWhereOrNull((element) => element['isClick'] == true);
    return check == null ? false : true;
  }

  List getTag(){
    var temp = [];
    for(var e in lsTag){
      if(e['isClick']) {
        temp.add(e['name']);
      }
    }
    return temp;
  }
}