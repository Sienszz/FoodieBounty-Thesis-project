import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/history/views/screen/Coupon/all_history_page.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/application/buyer/history/controllers/history_buyer_controller.dart';

class HistoryBuyerBody extends GetView<HistoryBuyerController> {
  const HistoryBuyerBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: Get.size.height *.075,
          decoration: BoxDecoration(
              color: AppThemes.white,
              borderRadius: BorderRadius.circular(8.0)),
          child:
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            unselectedLabelColor: Colors.grey.shade400,
            labelColor: AppThemes.blue,
            indicator: const BoxDecoration(
              border: Border(
                  bottom:
                  BorderSide(width: 3, color: AppThemes.blue)),
            ),
            tabs: controller.tabs,
            controller: controller.tabsController,
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: controller.tabsController,
            children: [
              AllCouponHistory(lsData: controller.lsHistoryAll),
              AllCouponHistory(lsData: controller.lsHistoryCoupon),
              AllCouponHistory(lsData: controller.lsHistoryWithCoupon),
              AllCouponHistory(lsData: controller.lsHistoryWithoutCoupon),
            ],
          ),
        ),
      ],
    );
  }
}