import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/account/controllers/account_controller.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/dashboard_buyer_controller.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/utils/routes.dart';

class AccountPageBody extends StatelessWidget {
  const AccountPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      padding: EdgeInsets.all(
        AppThemes().veryExtraSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ContainerMenu(),
          SizedBox(height: AppThemes().biggerSpacing,),
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
    var controller = Get.put(DashboardBuyerController());
    return Column(
      children: [
        SizedBox(
          height: AppThemes().veryExtraSpacing,
        ),
        ListTile(
          onTap: () => Get.toNamed(AppRoutes.buyerEditStore),
          leading: const Icon(Icons.account_box_outlined, color: AppThemes.blue, size: 40),
          title: Text('Sunting Akun',
              style: AppThemes().text5Bold(color: Colors.black)),
          trailing: const Icon(Icons.arrow_right, color: AppThemes.blue,size: 30),
        ),
        const Divider(
          thickness: 1,
          color: AppThemes.darkBlue,
        ),
        ListTile(
          onTap: () => Get.toNamed(AppRoutes.appInfo),
          leading: const Icon(Icons.info, color: AppThemes.blue, size: 40),
          title: Text('Informasi Aplikasi',
              style: AppThemes().text5Bold(color: Colors.black)),
          trailing: const Icon(Icons.arrow_right, color: AppThemes.blue,size: 30),
        ),
        const Divider(
          thickness: 1,
          color: AppThemes.darkBlue,
        ),
        ListTile(
          onTap: () => Get.toNamed(AppRoutes.voucherBuyer),
          leading: const Icon(Icons.discount, color: AppThemes.blue, size: 40),
          title: Text('Voucer',
              style: AppThemes().text5Bold(color: Colors.black)),
          trailing: const Icon(Icons.arrow_right, color: AppThemes.blue,size: 30),
        ),
      ],
    );
  }
}

class LogoutButton extends GetView<BuyerAccountController> {
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