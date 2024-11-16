import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/dashboard/controllers/dashboard_seller_controller.dart';
import 'package:projek_skripsi/application/seller/dashboard/views/screens/coupons/public_coupon_page.dart';
import 'package:projek_skripsi/application/seller/dashboard/views/screens/coupons/special_coupon_page.dart';
import 'package:projek_skripsi/application/seller/dashboard/views/widgets/leveling_widget.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/models/m_level.dart';

class DashboardPageBody extends GetView<DashboardSellerController> {
  const DashboardPageBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        controller.isLoadingLevel.isFalse && controller.nullLevel.value != 0 ?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.warning,
                color: Colors.yellow[700],
              ),
              SizedBox(width: AppThemes().biggerSpacing,),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Toko Anda tidak tampil di pembeli',
                    maxLines: 2,
                    softWrap: true,
                  ),
                  Text(
                    'Isi exp dan reward untuk 5 level dahulu',
                    maxLines: 1,
                    softWrap: true,
                  ),
                ],
              )
            ],
          ) : SizedBox(),
        SizedBox(height: AppThemes().extraSpacing),
        const LevelingWidget(),
        SizedBox(height: AppThemes().veryExtraSpacing),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.grey.shade500, blurRadius: 1.0)],
              color: AppThemes.blue,
              borderRadius: BorderRadius.circular(8.0)),
          child:
          TabBar(
            unselectedLabelColor: Colors.grey.shade400,
            labelColor: Colors.white,
            indicator: const BoxDecoration(
              border: Border(
                  bottom:
                      BorderSide(width: 3, color: AppThemes.white)),
            ),
            tabs: controller.tabs,
            controller: controller.tabsController,
          ),
        ),

        Expanded(
          child: TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: controller.tabsController,
            children: const [
              PublicCouponPage(),
              SpecialCouponPage(),
            ],
          ),
        ),
      ],
    ));
  }
}