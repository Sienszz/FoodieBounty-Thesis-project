import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/authorization/modules/register/seller_register/controllers/register_seller_controller.dart';
import 'package:projek_skripsi/authorization/modules/register/seller_register/views/register_page_body.dart';
import 'package:projek_skripsi/authorization/modules/register/seller_register/views/register_page_footer.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class SellerRegisterPage extends StatelessWidget {
  const SellerRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RegisterSellerController());
    return Scaffold(
      backgroundColor: AppThemes.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppThemes.white
        ),
        centerTitle: true,
        backgroundColor: AppThemes.blue,
        title: Text('Daftar',
            style: AppThemes().text3Bold(color: AppThemes.white)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppThemes().veryExtraSpacing),
        child: Column(
          children: [
            const RegisterPageBody(),
            SizedBox(height: AppThemes().veryExtraSpacing),
            const RegisterPageFooter()
          ],
        ),
      ),
    );
  }
}



