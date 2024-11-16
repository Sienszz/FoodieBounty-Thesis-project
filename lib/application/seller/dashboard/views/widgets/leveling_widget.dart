import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/dashboard/controllers/dashboard_seller_controller.dart';
import 'package:projek_skripsi/application/seller/dashboard/views/widgets/dialog_widget.dart';
import 'package:projek_skripsi/core/const/app_assets.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class LevelingWidget extends GetView<DashboardSellerController> {
  const LevelingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Obx(() => controller.isLoadingLevel.isTrue? 
        const Center(
          child: CircularProgressIndicator(
            color: AppThemes.blue,
            strokeWidth: 5.0,
          ),
        ) : ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: controller.lsLevel.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => controller.lsLevel[index].exp == null ? null :
                DialogWidget().onShowDetailLevel(
                  data: controller.lsLevel[index], level: index+1),
              child: Container(
                width: Get.size.width * .6,
                margin: EdgeInsets.only(
                  top: AppThemes().defaultSpacing,
                  bottom: AppThemes().defaultSpacing,
                  left: AppThemes().extraSpacing,
                ),
                decoration: BoxDecoration(
                  color: controller.levelColors[index],
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade500,
                        blurRadius: 3.0,
                        offset: const Offset(0, 1))
                  ],
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppThemes().extraSpacing,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Level ${index+1}',
                              style: AppThemes().text5Bold(color: AppThemes.white)),
                          SizedBox(height: AppThemes().defaultSpacing),
                          Text('Exp diperlukan: ${controller.lsLevel[index].exp ?? '-'}',
                              style: AppThemes().text5Bold(color: AppThemes.white)),
                          SizedBox(height: AppThemes().defaultSpacing),
                          Text('Hadiah: ${controller.lsLevel[index].coinReward ?? "-"} Koin' ' & ${controller.lsLevel[index].voucherReward == null ? "-" : controller.lsLevel[index].voucherReward!.length} Voucer',
                              style: AppThemes().text5Bold(color: AppThemes.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    controller.lsLevel[index].exp == null ?
                      Container(
                        width: Get.size.width,
                        height: Get.size.height,
                        padding: EdgeInsets.symmetric(
                            vertical: AppThemes().veryExtraSpacing),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Image.asset(AppAssets.lock),
                      ) : const SizedBox()
                  ],
                ),
              ),
            );
          }),)
    );
  }
}
