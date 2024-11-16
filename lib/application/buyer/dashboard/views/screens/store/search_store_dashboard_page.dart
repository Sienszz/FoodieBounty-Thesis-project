import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/dashboard_buyer_controller.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/screens/store/search_store_dashboard_page_body.dart';
import 'package:projek_skripsi/core/components/search_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/utils/routes.dart';

class SearchStoreDashboardPage extends StatelessWidget {
  const SearchStoreDashboardPage({super.key});

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
        title: Text('Mencari Toko',
            style: AppThemes().text3Bold(color: AppThemes.white),
          )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchingBar(
              dashboardController: controller,
            ),
            SearchStoreDashboardPageBody()
          ],
        ),
      ),
    );
  }
}