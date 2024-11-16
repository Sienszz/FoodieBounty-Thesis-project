import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/all_voucher/controllers/all_voucher_controller.dart';
import 'package:projek_skripsi/application/seller/all_voucher/views/screens/all_voucher_page_body.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/utils/routes.dart';

class AllVoucherPage extends StatelessWidget {
  const AllVoucherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AllVoucherController());
    return Scaffold(
      backgroundColor: AppThemes.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppThemes.white
        ),
        centerTitle: true,
        backgroundColor: AppThemes.blue,
        title: Text('Semua Voucer',
            style: AppThemes().text3Bold(color: AppThemes.white)),
      ),
      body: const AllVoucherPageBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.sellercreatevoucher),
        backgroundColor: AppThemes.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
