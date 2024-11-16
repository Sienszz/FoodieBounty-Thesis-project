import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/dashboard_buyer_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({super.key});
  
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DashboardBuyerController());
    final CarouselController controller0 = CarouselController();
    return Stack(
      children: [
        SizedBox(
          width: Get.size.width,
          height: Get.size.height,
          child: CarouselSlider(
            items: controller.images,
            options: CarouselOptions(
              height: Get.size.height, // Customize the height of the carousel
              autoPlay: true, // Enable auto-play
              enableInfiniteScroll: true, // Enable infinite scroll
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                controller.activePage.value = index;
              },
            ),
        )),
        Positioned.fill(
          top: Get.size.height * .20,
          child: Align(
            alignment: Alignment.center,
            child: Obx(() => 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: controller.images.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => controller0.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppThemes.darkBlue, width: 2.0),
                        color: (controller.activePage.value != entry.key
                                ? Colors.transparent
                                : AppThemes.darkBlue)
                        ),
                  ),
                );
              }).toList(),
            ),)
        ))
      ],
    );
  }
}