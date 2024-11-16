
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/leveling/views/widgets/card_widget.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/core/models/m_level.dart';
import 'package:projek_skripsi/core/models/m_storeVoucher.dart';
import 'package:projek_skripsi/core/providers/local_storage.dart';
import 'package:projek_skripsi/utils/routes.dart';

class CreateLevelController extends GetxController {
  CreateLevelController(this.arguments);
  Map arguments;

  var formKey = GlobalKey<FormState>();
  late final String title;
  var selectedReward = ''.obs;
  var isLoading = false.obs;
  var errorMsg = ''.obs;

  var fieldExp = TextEditingController();
  var fieldCoin = TextEditingController();

  var lsRewardWidget = List<Widget>.empty(growable: true).obs;
  var lsFieldReward = List<dynamic>.empty(growable: true).obs;
  var lsStoreVoucher = List<StoreVoucherModel>.empty(growable: true).obs;

  @override
  void onInit() async {
    title = arguments['title'];
    isLoading(true);
    await onGetSpecialVoucher();
    await onInitForm();
    isLoading(false);
    super.onInit();
  }

  Future<void> onGetSpecialVoucher() async {
    var storeId = await LocalStorage().onGetUser();
    var storeVouchers = await FirebaseFirestore.instance
      .collection('stores').doc(storeId)
      .collection('store_vouchers')
      .where('type', isEqualTo: 'special')
      .where('is_deleted', isEqualTo: false)
      .get();

    for(var element in storeVouchers.docs){
      var temp = StoreVoucherModel.fromJson(element.data());
      temp.id = element.id;
      lsStoreVoucher.add(temp);
    }  
  }

  Future<void> onInitForm() async {
    var storeId = await LocalStorage().onGetUser();
    var levelData = await FirebaseFirestore.instance
      .collection('stores').doc(storeId)
      .collection('store_levels').doc(title.removeAllWhitespace)
      .get();
    
    if(levelData.data() != null){
      var temp = LevelModel.fromJson(levelData.data() as Map<String,dynamic>);
      fieldExp.text = temp.exp!.toString();

      if(temp.coinReward != null){
        lsFieldReward.add(TextEditingController());
        lsRewardWidget.add(CoinField(index: lsRewardWidget.length));
        lsFieldReward[lsFieldReward.length-1].text = temp.coinReward!.toString();
      }
      if(temp.voucherReward != null){
        for(var e in temp.voucherReward!){
          lsFieldReward.add(e['id']);
          lsRewardWidget.add(VoucherField(index: lsRewardWidget.length));
        }
      }
    }
  }

  void addReward(){
    switch(selectedReward.value){
      case 'coin':
        lsFieldReward.add(TextEditingController());
        lsRewardWidget.add(CoinField(index: lsRewardWidget.length));
        break;
      case 'voucher':
        if(lsStoreVoucher.isEmpty) {
          Get.defaultDialog(
            title: 'Gagal',
            middleText: 'Pengguna belum memiliki voucer spesial',
            textConfirm:'Ok',
            onConfirm: () {
              Get.back();
            }
          );
        };
        lsFieldReward.add(lsStoreVoucher[0].id!);
        lsRewardWidget.add(VoucherField(index: lsRewardWidget.length));
        break;
    }
    Get.back(); // dismiss dialog
    lsRewardWidget.refresh(); // refresh list
    selectedReward.value = ''; // reset selected
  }

  void removeReward(int index){
    lsFieldReward.removeAt(index);
    lsRewardWidget.removeAt(index);
    for(int i=index; i<lsRewardWidget.length ;i++){
      if(lsRewardWidget[i].toString() == 'CoinField'){
        lsRewardWidget[i] = CoinField(index: i);
      } else if(lsRewardWidget[i].toString() == 'VoucherField'){
        lsRewardWidget[i] = VoucherField(index: i);
      }
    }
    lsRewardWidget.refresh();
  }

  void onSave() async {
    errorMsg.value = '';
    for(int i=0; i<lsRewardWidget.length ;i++){
      if(lsRewardWidget[i].toString() == 'CoinField' && lsFieldReward[i].text == ''){
        errorMsg.value = 'Semua hadiah wajib diisi';
      } else if(lsRewardWidget[i].toString() == 'VoucherField' && lsFieldReward[i] == ''){
        errorMsg.value = 'Semua hadiah wajib diisi';
      }
    }
    if(lsFieldReward.isEmpty){
      errorMsg.value = 'Minimal satu hadiah';
    }

    if(formKey.currentState!.validate() && errorMsg.value == ''){
      DialogComponent().onLoadingDismissible();
      var storeId = await LocalStorage().onGetUser();
      var levelDoc = FirebaseFirestore.instance
        .collection('stores').doc(storeId)
        .collection('store_levels').doc(title.removeAllWhitespace);

      var totalCoin = 0;
      var vouchers = [];
      for(int i=0; i<lsRewardWidget.length ;i++){
        if(lsRewardWidget[i].toString() == 'CoinField'){
          totalCoin += int.parse(lsFieldReward[i].text);
        } else if(lsRewardWidget[i].toString() == 'VoucherField'){
          vouchers.add({
            'id': lsFieldReward[i],
            'name': lsStoreVoucher.firstWhere(
              (element) => element.id == lsFieldReward[i]).name!
          });
        }
      }
      
      await levelDoc.set({
        'coinReward': totalCoin == 0 ? null : totalCoin,
        'voucherReward': vouchers.isEmpty ? null : vouchers,
        'exp': int.parse(fieldExp.text)
      })
        .then((value) {
          Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
          Get.defaultDialog(
              title: 'Sukses',
              middleText: 'Level berhasil disimpan',
              textConfirm:'Ok',
              onConfirm: () {
                Get.offAllNamed(AppRoutes.sellerdashboard);
              }
          );
        })
        .catchError((error) {
          Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
          Get.defaultDialog(
              title: 'Gagal',
              middleText: 'Gagal menyimpan level',
              textConfirm:'Ok',
              onConfirm: () => Get.back()
          );});
    }
  }
}
