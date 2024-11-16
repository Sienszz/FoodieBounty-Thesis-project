import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/history/views/screen/history_buyer_body.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/application/buyer/history/controllers/history_buyer_controller.dart';


class HistoryBuyerPage extends StatelessWidget {
  const HistoryBuyerPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HistoryBuyerController());
    return Obx(() =>
      controller.isLoadingHistory.isTrue ?
      const Center(
        child: CircularProgressIndicator(
          color: AppThemes.blue,
          strokeWidth: 5.0,
        ),
      ) :
      Scaffold(
        backgroundColor: AppThemes.white,
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: AppThemes.white
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: AppThemes.blue,
            title: Text('Riwayat',
              style: AppThemes().text3Bold(color: AppThemes.white),
            )
        ),
        body: const HistoryBuyerBody(),
      )
    );
  }
}
