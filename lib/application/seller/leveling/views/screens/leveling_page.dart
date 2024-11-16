import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/leveling/controllers/leveling_seller_controller.dart';
import 'package:projek_skripsi/application/seller/leveling/views/screens/leveling_home_page.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class SellerLevelingPage extends StatelessWidget {
  const SellerLevelingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LevelingSellerController());
    return Scaffold(
      backgroundColor: AppThemes.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppThemes.white
        ),
        centerTitle: true,
        backgroundColor: AppThemes.blue,
        title: Text('Leveling',
            style: AppThemes().text3Bold(color: AppThemes.white)),
      ),
      body: const LevelingHomePage(),
    );
  }
}
