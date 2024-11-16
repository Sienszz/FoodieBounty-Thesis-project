import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/store_detail_controller.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/screens/coupons/coupon_selected_store.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class SelectedStoreBody extends GetView<StoreDetailController> {
  const SelectedStoreBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: AppThemes().veryExtraSpacing),
        if ((controller.storeMembership.value.level ?? 0) != 0 && (controller.storeMembership.value.level ?? 0) <= 5 && (controller.storeMembership.value.exp ?? 0) >= (controller.storeMembership.value.lsLevelStore?[(controller.storeMembership.value.level! <= 5 ? controller.storeMembership.value.level! : 5) - 1].exp ?? 0))
          SizedBox(
            width: Get.size.width * .75,
            height: Get.size.width * .15,
            child: ElevatedButton(
              onPressed: () {
                controller.onGetReward();
              },
              style: ElevatedButton.styleFrom(
                elevation: 3,
                backgroundColor: AppThemes.levelColor[controller.storeMembership.value.level! <= 5 ? controller.storeMembership.value.level ?? 1 : 5],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset('assets/vector/gift.png', fit: BoxFit.cover, width: Get.size.width * .1),
                  SizedBox(width: AppThemes().extraSpacing),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ambil hadiah level ${controller.storeMembership.value.level ?? ''}',
                        style: AppThemes().text4Bold(color: AppThemes.white),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/vector/coupon.png', fit: BoxFit.cover, width: Get.size.width * .05),
                              SizedBox(width: AppThemes().minSpacing),
                              Text(
                                controller.storeMembership.value.lsLevelStore?[(controller.storeMembership.value.level! > 5 ? 5 : controller.storeMembership.value.level ?? 1) - 1].voucherReward?.length != null
                                  ? 'x${controller.storeMembership.value.lsLevelStore?[(controller.storeMembership.value.level! > 5 ? 5 : controller.storeMembership.value.level ?? 1) - 1].voucherReward!.length}'
                                  : '-',
                                style: AppThemes().text5(color: AppThemes.white),
                              ),
                            ],
                          ),
                          SizedBox(width: AppThemes().biggerSpacing),
                          Row(
                            children: [
                              Image.asset('assets/vector/coin.png', fit: BoxFit.cover, width: Get.size.width * .05),
                              SizedBox(width: AppThemes().minSpacing),
                              Text(
                                '${controller.storeMembership.value.lsLevelStore?[(controller.storeMembership.value.level! > 5 ? 5 : controller.storeMembership.value.level ?? 1) - 1].coinReward ?? 0} Coin',
                                style: AppThemes().text5(color: AppThemes.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        SizedBox(height: AppThemes().veryExtraSpacing),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.grey.shade500, blurRadius: 1.0)],
              color: AppThemes.blue,
              borderRadius: BorderRadius.circular(8.0)),
          child: TabBar(
            unselectedLabelColor: Colors.grey.shade400,
            labelColor: Colors.white,
            indicator: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 3, color: AppThemes.white)),
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
              Obx(() => controller.isLoadingCoupon.isTrue 
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppThemes.blue,
                      strokeWidth: 5.0,
                    ),
                  ) 
                : controller.lsVoucher.isNotEmpty 
                  ? const CouponStorePage(selectedTab: 0) 
                  : Center(
                      child: Text(
                        'Voucer tidak tersedia pada toko ini', 
                        style: AppThemes().text5Bold(color: AppThemes.black),
                      ),
                    ),
              ),
              Obx(() => controller.isLoadingCoupon.isTrue 
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppThemes.blue,
                      strokeWidth: 5.0,
                    ),
                  ) 
                : controller.lsCustomerVoucher.isNotEmpty 
                  ? const CouponStorePage(selectedTab: 1) 
                  : Center(
                      child: Text(
                        'Anda tidak memiliki voucer di toko ini', 
                        style: AppThemes().text5Bold(color: AppThemes.black),
                      ),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
