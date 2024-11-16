import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/account/controllers/account_controller.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class AccountPageHeader extends GetView<BuyerAccountController> {
  const AccountPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.size.width,
      height: Get.size.height *.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: Get.size.height * .13,
              height: Get.size.height * .13,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: controller.user.value.imgUrl! != '' ? 
                        NetworkImage(controller.user.value.imgUrl!) 
                        : const AssetImage('assets/photo/profile.jpeg') as ImageProvider,
                      fit: BoxFit.cover
                  ),
                  border: Border.all(color: Colors.grey.shade300),
              )
          ),
          SizedBox(height: AppThemes().extraSpacing),
          SizedBox(
              width: Get.size.width * .8,
            child: Text(
              controller.user.value.name!,
              style: AppThemes().text5Bold(color: AppThemes.white),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: AppThemes().defaultSpacing),
          SizedBox(
            width: Get.size.width * .8,
            child: Text(
              controller.user.value.email!,
              style: AppThemes().text5(color: AppThemes.white),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: AppThemes().defaultSpacing),
          SizedBox(
            width: Get.size.width * .8,
            child: Text(
              controller.user.value.phoneNumber!,
              style: AppThemes().text5(color: AppThemes.white),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}