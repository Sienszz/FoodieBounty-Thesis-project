import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/dashboard/controllers/dashboard_seller_controller.dart';
import 'package:projek_skripsi/application/seller/dashboard/views/screens/dashboard_page_header.dart';
import 'package:projek_skripsi/application/seller/dashboard/views/screens/dashboard_page_body.dart';

class SellerDashboardPage extends GetView<DashboardSellerController> {
  const SellerDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DashboardSellerController());
    return Stack(
      children: [
        Obx(() => controller.isLoadingUser.isFalse ?
          Container(
            width: Get.size.width,
            height: Get.size.height * .3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        controller.user.value.imgUrl!
                    ),
                    fit: BoxFit.cover
                )
            ),
          ) : const SizedBox()
        ),
        Container(
          margin: EdgeInsets.only(
            top: Get.size.height * .27,
          ),
          child: const DashboardPageHeader()
        ),
        Container(
            margin: EdgeInsets.only(
              top: Get.size.height * .35,
            ),
            // height: Get.size.height * .65,
            child: const DashboardPageBody()
        )
      ],
    );
  }
}
