
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/dashboard_buyer_controller.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/widgets/card_expand_store_widget.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/utils/routes.dart';

class SearchStoreDashboardPageBody extends GetView<DashboardBuyerController> {
  const SearchStoreDashboardPageBody({super.key});
  
  
  @override
  Widget build(BuildContext context) {

    return Obx(() => 
    controller.lsFilterStore.isNotEmpty || controller.wordTextField.value != '' ? 
      ListView.builder(
        shrinkWrap: true,
        itemCount: controller.lsFilterStore.length,
        itemBuilder: (context, index){
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: AppThemes().veryExtraSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppThemes().veryExtraSpacing),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.selectedStore, arguments: {
                        'store': controller.lsFilterStore[index]
                    });
                  },
                  child: StoreExpandCard(data: controller.lsFilterStore[index]),
                )
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
