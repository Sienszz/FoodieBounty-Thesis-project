import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/edit_account/controllers/edit_account_controller.dart';
import 'package:projek_skripsi/application/buyer/edit_account/views/edit_buyer_page_body.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class EditBuyerPage extends StatelessWidget {
  const EditBuyerPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(EditAccountController());
    return Scaffold(
      backgroundColor: AppThemes.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppThemes.white
        ),
        centerTitle: true,
        backgroundColor: AppThemes.blue,
        title: Text('Sunting Akun',
            style: AppThemes().text3Bold(color: AppThemes.white)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppThemes().veryExtraSpacing),
        child: const Column(
          children: [
            EditBuyerPageBody()
          ],
        ),
      ),
    );
  }
}