import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:projek_skripsi/authorization/modules/register/buyer_register/controllers/register_buyer_controller.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/authorization/modules/register/buyer_register/views/register_page_header.dart';
import 'package:projek_skripsi/authorization/modules/register/buyer_register/views/register_page_body.dart';
import 'package:projek_skripsi/authorization/modules/register/buyer_register/views/register_page_footer.dart';

class BuyerRegisterPage extends StatelessWidget {
  const BuyerRegisterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RegisterBuyerController());
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
        child: Container(
          padding: EdgeInsets.all(AppThemes().veryExtraSpacing),
          width: Get.size.width,
          child: Column(
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const RegisterPageHeader(),
                    SizedBox(height: AppThemes().veryExtraSpacing),
                    const RegisterPageBody(),
                  ],
              ),
              SizedBox(height: AppThemes().veryExtraSpacing),
              Container(
                alignment: Alignment.center,
                child: const RegisterPageFooter()
              )
            ],
          ),
        ),
      ),
    );
  }
}
