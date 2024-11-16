import 'package:flutter/material.dart';
import 'package:projek_skripsi/application/app_informaton/views/app_information_page_body.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class AppInformationPage extends StatelessWidget {
  const AppInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: AppThemes.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppThemes.white
        ),
        centerTitle: true,
        backgroundColor: AppThemes.blue,
        title: Text('Informasi Aplikasi',
            style: AppThemes().text3Bold(color: AppThemes.white)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppThemes().veryExtraSpacing),
        child: const Column(
          children: [
            AppInformationPageBody()
          ],
        ),
      ),
    );
  }
}