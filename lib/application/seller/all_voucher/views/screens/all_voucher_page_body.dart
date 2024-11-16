import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/all_voucher/controllers/all_voucher_controller.dart';
import 'package:projek_skripsi/application/seller/all_voucher/views/screens/coupons/expired_coupon_page.dart';
import 'package:projek_skripsi/application/seller/all_voucher/views/screens/coupons/public_coupon_page.dart';
import 'package:projek_skripsi/application/seller/all_voucher/views/screens/coupons/special_coupon_page.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class AllVoucherPageBody extends GetView<AllVoucherController> {
  const AllVoucherPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
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
        Expanded(
          child: TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: controller.tabsController,
            children: const [
              PublicCouponPage(),
              SpecialCouponPage(),
              ExpiredCouponPage(),
            ],
          ),
        ),
      ],
    );
  }
}
