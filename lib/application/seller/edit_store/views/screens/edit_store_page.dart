import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/edit_store/controllers/edit_store_controller.dart';
import 'package:projek_skripsi/application/seller/edit_store/views/screens/edit_store_page_body.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class EditStorePage extends StatelessWidget {
  const EditStorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(EditStoreController());
    return Scaffold(
      backgroundColor: AppThemes.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppThemes.white, //change your color here
        ),
        centerTitle: true,
        backgroundColor: AppThemes.blue,
        title: Text('Edit toko',
            style: AppThemes().text3Bold(color: AppThemes.white)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppThemes().veryExtraSpacing),
        child: const Column(
          children: [
            EditStorePageBody()
          ],
        ),
      ),
    );
  }
}
