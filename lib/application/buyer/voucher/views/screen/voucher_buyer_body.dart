import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projek_skripsi/application/buyer/voucher/views/screen/Coupon/all_voucher_buyer_page.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import '../../controllers/voucher_buyer_controller.dart';
import 'package:get/get.dart';
class VoucherBuyerBody extends StatelessWidget {
  final VoucherBuyerController controller;
  const VoucherBuyerBody({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => 
    controller.isLoadingCoupon.isTrue ? 
    const Center(
      child: CircularProgressIndicator(
        color: AppThemes.blue,
        strokeWidth: 5.0,
      ),
    ) : 
    controller.lsFilterFinalStore.isNotEmpty || controller.wordTextField.value != '' ?
    ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.lsFilterFinalStore.length,
      itemBuilder: (context, index){
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: AppThemes().extraSpacing, vertical: AppThemes().defaultSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(controller.lsFilterFinalStore[index]['StoreName'],textAlign: TextAlign.start, style: AppThemes().text5Bold(color: AppThemes.blue)),
                    Obx( () => RichText(text: TextSpan(
                      text: (controller.isInvisible[index] == false ? "Lebih banyak" : "Sembunyikan"),
                      style: AppThemes().text4Bold(color: AppThemes.blue),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        controller.isInvisible[index] = !controller.isInvisible[index];
                      },
                    ),
                    )
                    )
                  ],
                ),
                Obx(() {
                  if (controller.isInvisible[index]) {
                    return AllVoucherBuyer(
                      data: controller.lsFilterFinalStore[index]['MergeCustomerVoucher'],
                    );
                  } else {
                    return Container(); // Empty container when not visible
                  }
                }),
              ],
            ),
          );
      },
    )
    :
    Center(
      child: Text("Tidak Ditemukan", style: AppThemes().text4Bold(color: AppThemes.black), textAlign: TextAlign.center,)
    ),
    );
  }
}
