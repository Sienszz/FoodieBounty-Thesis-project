import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/dashboard_buyer_controller.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/widgets/card_category_expand_store_widget.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/models/m_storeMembership.dart';
import 'package:projek_skripsi/utils/routes.dart';

class CategoryStorePageBody extends GetView<DashboardBuyerController> {
  const CategoryStorePageBody({super.key});

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
                  child: CategoryExpandStoreCard(data: controller.lsFilterStore[index]),
                )
              ],
            ),
          );
        },
      )
      :
      const Center(
        child: Text("Tidak Ditemukan")
      ),
    );
  }
}
