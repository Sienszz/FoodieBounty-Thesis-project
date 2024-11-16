import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/account/controllers/account_controller.dart';
import 'package:projek_skripsi/application/buyer/account/views/widgets/many_coins.dart';
import 'package:projek_skripsi/application/buyer/account/views/widgets/many_coupons.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class AccountBestInfo extends GetView<BuyerAccountController> {
  const AccountBestInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          width: Get.size.width * .9,
          decoration: BoxDecoration(
            color: AppThemes.veryDarkBlue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            )
          ),
          child:  const ManyCoins(),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          width: Get.size.width * .9,
          decoration: BoxDecoration(
            color: AppThemes.moreDarkBlue,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500, 
                blurRadius: 2.0,
                offset: const Offset(0,5))],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            )
          ),
          child:  const ManyCoupons(),
        ),
      ],
    );
  }
}