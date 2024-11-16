import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/store_detail_controller.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/screens/store/selected_store_header.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/screens/store/selected_store_body.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class SelectedStorePage extends StatelessWidget {
  const SelectedStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(StoreDetailController(Get.arguments));
    return Scaffold(
      backgroundColor: AppThemes.white,
      body: Obx(() => controller.isLoading.isTrue ?
      const Center(
        child: CircularProgressIndicator(
          color: AppThemes.blue,
          strokeWidth: 5.0,
        ),
      ) : Stack(
        children: [
          controller.storeMembership.value.exp != 0 || controller.storeMembership.value.level != 0 ?
          Stack(
            children: [
              Container(
                width: Get.size.width,
                height: Get.size.height * .3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      // image: AssetImage('assets/photo/photo_1.jpeg'),
                        image: NetworkImage(controller.storeMembership.value.imgUrl!),
                        fit: BoxFit.cover
                    )
                ),
              ),
            ],
          )
              :
          Stack(
            children: [
              Container(
                width: Get.size.width,
                height: Get.size.height * .3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      // image: AssetImage('assets/photo/photo_1.jpeg'),
                        image: NetworkImage(controller.storeMembership.value.imgUrl!),
                        fit: BoxFit.cover
                    )
                ),
              ),
              Container(
                  width: Get.size.width,
                  height: Get.size.height * .3,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)
                    ),
                    color: AppThemes.black.withOpacity(0.6),
                  )
              ),
              Positioned(
                left: (Get.size.width - Get.size.width * 0.14) / 2,
                top: (Get.size.height * 0.3 - Get.size.height * 0.08) / 2,
                child: Container(
                  width: Get.size.width * 0.14,
                  height: Get.size.height * 0.08,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/vector/lock.png'),
                          fit: BoxFit.cover
                      )
                  ),
                ),
              ),
              Positioned(
                left: (Get.size.width - Get.size.width * 0.7) / 2,
                top: (Get.size.height * 0.3 - Get.size.height * 0.08) / 1.1,
                child: SizedBox(
                  width: Get.size.width * 0.7,
                  height: Get.size.height * 0.08,
                  child: Text(
                    'Mulai transaksi pertama anda ditoko ini untuk membuka keanggotaan',
                    style: AppThemes().text5Bold(color: Colors.white),
                    textAlign: TextAlign.center, // Center the text horizontally
                    overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
                    maxLines: 2, // Limit to a single line
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: Get.size.height * .05,
                    left: Get.size.width * .01
                ),
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppThemes.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 3, // Spread radius
                          blurRadius: 5, // Blur radius
                          offset: const Offset(0, 2), // Offset in x and y direction
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back_ios_new,
                      color: AppThemes.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: Get.size.height * .05,
                    right: Get.size.width * .01
                ),
                child: TextButton(
                  onPressed: () {
                    DialogComponent().popUpInfoLevelUp(controller.storeMembership.value.lsLevelStore!);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 3, // Spread radius
                          blurRadius: 5, // Blur radius
                          offset: const Offset(0, 2), // Offset in x and y direction
                        ),
                      ],
                    ),
                    child: Image(
                      image: AssetImage('assets/vector/Info-Lvl.png'),
                      width: Get.size.width * .1,
                      height: Get.size.height * .1,
                    )
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: Get.size.height * .20,
            ),
            child: SelectedStoreHeader(),
          ),
          Container(
            margin: EdgeInsets.only(top: Get.size.height * .33),
            child: SelectedStoreBody(),
          ),
        ],
      ))
    );
  }
}