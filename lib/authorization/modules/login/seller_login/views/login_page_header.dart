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
          Image.asset(AppAssets.sellerlogin),
          SizedBox(height: AppThemes().extraSpacing),
          Text('Selamat datang kembali Mitra,',
              style: AppThemes().text3Bold(color: AppThemes.lightBlue)),
          const Text(
            "Mulailah pertumbuhan toko Anda hari ini",
          )
        ],
      ),
    );
  }
}
