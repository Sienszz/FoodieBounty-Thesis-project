import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/dashboard_buyer_controller.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/screens/dashboard_page_body.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/widgets/image_carousel_widget.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/utils/routes.dart';

class BuyerDashboardPage extends StatelessWidget {
  const BuyerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DashboardBuyerController());
    return Stack(
      children: [
        SizedBox(
          width: Get.size.width,
          height: Get.size.height * .3,
          child: const ImageCarousel(),
        ),
        Container(
          margin: EdgeInsets.only(
            top: Get.size.height * .25,
          ),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.dashboardSearchStore);
              controller.lsFilter = controller.lsStoreMembership;
              controller.lsFilterStore.value = controller.lsFilter;
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: AppThemes.blue,
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                            color: Colors.black.withOpacity(0.2), // Shadow color
                            spreadRadius: 3, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: Offset(0, 2), // Offset in x and y direction
                          ),
                  ],
                  borderRadius: BorderRadius.circular(50.0)
                ),
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: AppThemes.superLightBlue,
                    borderRadius: BorderRadius.circular(50.0)
                  ),
                  child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      size: 30,
                      color: AppThemes.blue,
                    ),
                    SizedBox(
                      width: AppThemes().extraSpacing,
                    ),
                    Text("Cari Toko...", style: AppThemes().text4(color: AppThemes.black),)
                  ],
                ),
                )
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: Get.size.height * .35,
          ),
          child: const BuyserDashboardBody()
        )
      ],
    );
  }
}