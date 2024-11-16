
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:projek_skripsi/application/seller/store/controllers/store_seller_controller.dart';
import 'package:projek_skripsi/utils/routes.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class StorePageBody extends StatelessWidget {
  const StorePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      padding: EdgeInsets.all(
        AppThemes().veryExtraSpacing,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0)
        ),
        color: AppThemes.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 20.0,
            offset: const Offset(1,0)),
        ]
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ContainerMenu(),
          LogoutButton()
        ],
      ),

    );
  }
}

class ContainerMenu extends StatelessWidget {
  const ContainerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => Get.toNamed(AppRoutes.sellereditstore),
          leading: const Icon(Icons.store, color: AppThemes.blue, size: 40),
          title: Text('Edit Informasi Toko',
              style: AppThemes().text5Bold(color: Colors.black)),
          trailing: const Icon(Icons.arrow_right, color: AppThemes.blue,size: 30),
        ),
        const Divider(
          thickness: 1,
          color: AppThemes.darkBlue,
        ),
        ListTile(
          onTap: () => Get.toNamed(AppRoutes.sellerhistory),
          leading: const Icon(Icons.history_outlined, color: AppThemes.blue, size: 40),
          title: Text('Riwayat',
              style: AppThemes().text5Bold(color: Colors.black)),
          trailing: const Icon(Icons.arrow_right, color: AppThemes.blue,size: 30),
        ),
        const Divider(
          thickness: 1,
          color: AppThemes.darkBlue,
        ),
        ListTile(
          onTap: () => Get.toNamed(AppRoutes.sellerleveling),
          leading: const Icon(Icons.auto_graph, color: AppThemes.blue, size: 40),
          title: Text('Sistem Level',
              style: AppThemes().text5Bold(color: Colors.black)),
          trailing: const Icon(Icons.arrow_right, color: AppThemes.blue,size: 30),
        ),
        const Divider(
          thickness: 1,
          color: AppThemes.darkBlue,
        ),
        ListTile(
          onTap: () => Get.toNamed(AppRoutes.sellerallvoucher),
          leading: const Icon(Icons.discount, color: AppThemes.blue, size: 40),
          title: Text('Semua Voucer Toko',
              style: AppThemes().text5Bold(color: Colors.black)),
          trailing: const Icon(Icons.arrow_right, color: AppThemes.blue,size: 30),
        ),
      ],
    );
  }
}

class LogoutButton extends GetView<StoreSellerController> {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.size.width,
      child: ElevatedButton(
        onPressed: () => controller.logout(),
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: AppThemes.red,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),
        ),
        child: Text(
          'Keluar',
          style: AppThemes().text4Bold(color: AppThemes.white),
        ),
      ),
    );
  }
}


