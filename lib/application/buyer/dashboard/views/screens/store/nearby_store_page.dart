import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/dashboard_buyer_controller.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/widgets/card_nearby_store_widget.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/utils/routes.dart';

class NearbyStorePage extends GetView<DashboardBuyerController> {
  const NearbyStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => 
      controller.isLoadingUser.isTrue ? 
      const Center(
        child: CircularProgressIndicator(
          color: AppThemes.blue,
          strokeWidth: 5.0,
        ),
      ) : 
      controller.lsStoreMembership.isEmpty ? Text("Tidak ada Data Toko") :
      Align(
        alignment: Alignment.centerLeft,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.lsStoreMembership.length > 5 ? 5 : controller.lsStoreMembership.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.selectedStore, arguments: {
                    'store': controller.lsStoreMembership[index]
                  });
                },
                child: NearbyStoreCard(data: controller.lsStoreMembership[index]),
              );
            }
        ),
      )
    );
  }
}