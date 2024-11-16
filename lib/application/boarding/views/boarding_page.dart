import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/core/const/app_assets.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/utils/routes.dart';

class BoardingPage extends StatelessWidget {
  const BoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: Get.size.width,
                height: Get.size.height * .7,
                child: const BoardingHeader()),
            SizedBox(
                width: Get.size.width,
                height: Get.size.height * .3,
                child: const BoardingBody()),
          ],
        ),
      ),
    );
  }
}

class BoardingHeader extends StatelessWidget {
  const BoardingHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppAssets.boarding),
        // SizedBox(height: AppThemes().veryExtraSpacing),
        Text('Selamat datang di Foodie Bounty',
            style: AppThemes().text3Bold(color: AppThemes.lightBlue)),
        SizedBox(height: AppThemes().extraSpacing),
        SizedBox(
          width: Get.size.width * .7,
          child: const Text(
            "Mendukung kemajuan perekonomian UMKM sekaligus menawarkan "
                "manfaat eksklusif bagi pembeli",
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

class BoardingBody extends StatelessWidget {
  const BoardingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.size.width * .6,
          child: ElevatedButton(
            onPressed: () => Get.toNamed(AppRoutes.sellerlogin),
            style: ElevatedButton.styleFrom(
              elevation: 3,
              backgroundColor: AppThemes.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
              ),
            ),
            child: Text(
              'Mulai sebagai Penjual',
              style: AppThemes().text4Bold(color: AppThemes.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: AppThemes().extraSpacing),
        SizedBox(
          width: Get.size.width * .6,
          child: ElevatedButton(
            onPressed: () => Get.toNamed(AppRoutes.buyerlogin),
            style: ElevatedButton.styleFrom(
              elevation: 3,
              backgroundColor: AppThemes.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
              ),
            ),
            child: Text(
              'Mulai sebagai Pembeli',
              style: AppThemes().text4Bold(color: AppThemes.white),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}


