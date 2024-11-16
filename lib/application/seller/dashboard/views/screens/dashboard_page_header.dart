import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/dashboard/controllers/dashboard_seller_controller.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class DashboardPageHeader extends GetView<DashboardSellerController> {
  const DashboardPageHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: AppThemes().extraSpacing),
        width: Get.size.width,
        height: 65,
        decoration: BoxDecoration(
          color: AppThemes.blue,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: controller.isLoadingUser.isTrue ?
          const Center(
            child: CircularProgressIndicator(
              color: AppThemes.white,
              strokeWidth: 5.0,
            ),
          ) : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(controller.user.value.name!,
                style: AppThemes().text2Bold(color: AppThemes.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              Text(
                controller.tagString.value,
                style: AppThemes().text5(color: AppThemes.white),
              )
            ],
          ),
      )
    );
  }
}
