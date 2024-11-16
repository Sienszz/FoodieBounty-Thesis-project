import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/dashboard_buyer_controller.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/screens/store/category_store_page_body.dart';
import 'package:projek_skripsi/core/components/search_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class CategoryStorePage extends StatelessWidget {
  const CategoryStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DashboardBuyerController());
    return Scaffold(
      backgroundColor: AppThemes.white,
      appBar:  AppBar(
        iconTheme: const IconThemeData(
          color: AppThemes.white
        ),
        centerTitle: true,
        backgroundColor: AppThemes.blue,
        title: Obx(() => 
          Text(controller.ExpandMoreStoreTitle.value,
            style: AppThemes().text3Bold(color: AppThemes.white),
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchingBar(
              dashboardController: controller,
            ),
            CategoryStorePageBody()
          ],
        ),
      ),
    );
  }
}