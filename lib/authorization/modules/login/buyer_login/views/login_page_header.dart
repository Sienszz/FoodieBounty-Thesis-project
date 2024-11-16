import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/core/const/app_assets.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class LoginPageHeader extends StatelessWidget {
  const LoginPageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.size.width * .8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppAssets.buyerlogin),
          SizedBox(height: AppThemes().extraSpacing),
          Text('Selamat datang kembali Pemburu Harta,',
              style: AppThemes().text3Bold(color: AppThemes.lightBlue)),
          // SizedBox(height: AppThemes().defaultSpacing),
          const Text(
            "Lanjutkan perjalanan penjelajahan Anda untuk membuka promosi eksklusif",
          )
        ],
      ),
    );
  }
}
