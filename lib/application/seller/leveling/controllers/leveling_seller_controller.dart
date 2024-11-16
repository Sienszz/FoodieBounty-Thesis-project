
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/models/m_level.dart';
import 'package:projek_skripsi/core/providers/local_storage.dart';

class LevelingSellerController extends GetxController {
  final List<Color> levelColors = [
    AppThemes.levelColor[1]!,
    AppThemes.levelColor[2]!,
    AppThemes.levelColor[3]!,
    AppThemes.levelColor[4]!,
    AppThemes.levelColor[5]!,
  ];

  var isLoading = false.obs;
  var lsLevel = List<LevelModel>.empty(growable: true).obs;

  @override
  void onInit() async {
    isLoading(true);
    List.generate(5, (index) => lsLevel.add(LevelModel()));
    await onGetLevelData();
    isLoading(false);
    super.onInit();
  }

  Future<void> onGetLevelData() async {
    var storeId = await LocalStorage().onGetUser();
    print('storeId: $storeId');
    var levelData = await FirebaseFirestore.instance
      .collection('stores').doc(storeId)
      .collection('store_levels').get(); 
    print("level docs: ${levelData.docs}");
    for(var element in levelData.docs){
      var temp = LevelModel.fromJson(element.data());
      temp.id = element.id;
      print(temp);
      var currLevel = int.parse(temp.id!.substring(5));
      print("currLevel: $currLevel");
      lsLevel[currLevel-1] = temp; 
    }
  }
}