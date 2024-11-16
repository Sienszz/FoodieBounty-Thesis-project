import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/store_detail_controller.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/widgets/card_coupon_wdiget.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/core/components/voucher_buyer_card.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class CouponStorePage extends GetView<StoreDetailController> {
  final int selectedTab;
  const CouponStorePage({Key? key, required this.selectedTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: selectedTab == 0 ? controller.lsVoucher.length : controller.lsMergeVoucher.length,
      itemBuilder: (context, index) {
        if (selectedTab == 0) {
          final voucher = controller.lsVoucher[index];
          return GestureDetector(
            onTap: () => DialogComponent().onShowDetailVoucher(data: voucher),
            child: CouponCard(
              data: voucher,
            ),
          );
        } else {
          final mergeVoucher = controller.lsMergeVoucher[index];
          return GestureDetector(
            onTap: () => DialogComponent().onShowDetailVoucher(data: mergeVoucher['StoreVoucher'], qty: 1),
            child: Container(
              padding: EdgeInsets.only(
                left: AppThemes().extraSpacing,
                right: AppThemes().extraSpacing,
                bottom: AppThemes().veryExtraSpacing,
              ),
              child: VoucherBuyerCard(
                data: mergeVoucher,
              ),
            ),
          );
        }
      },
    );
  }
}
