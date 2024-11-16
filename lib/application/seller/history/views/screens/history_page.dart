import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:projek_skripsi/application/seller/history/views/screens/history_page_body.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/application/seller/history/controllers/history_seller_controller.dart';

class SellerHistoryPage extends StatelessWidget {
  const SellerHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HistorySellerController());
    return Scaffold(
      backgroundColor: AppThemes.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppThemes.white
        ),
        centerTitle: true,
        backgroundColor: AppThemes.blue,
        title: Text('Riwayat',
            style: AppThemes().text3Bold(color: AppThemes.white)),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.grey.shade500, blurRadius: 1.0)],
                color: AppThemes.white,
                borderRadius: BorderRadius.circular(8.0)),
            child:
            TabBar(
              unselectedLabelColor: Colors.grey.shade400,
              labelColor: AppThemes.blue,
              indicator: const BoxDecoration(
                border: Border(
                    bottom:
                    BorderSide(width: 3, color: AppThemes.blue)),
              ),
              tabs: controller.tabs,
              controller: controller.tabsController,
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              controller: controller.tabsController,
              children: [
                HistoryPageBody(lsData: controller.lsHistory,),
                HistoryPageBody(lsData: controller.lsHistoryWithCoupon),
                HistoryPageBody(lsData: controller.lsHistoryWithoutCoupon),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
