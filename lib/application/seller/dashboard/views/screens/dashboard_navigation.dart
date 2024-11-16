import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:projek_skripsi/application/seller/dashboard/controllers/dashboard_seller_controller.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class SellerDashboardNavigation extends StatelessWidget {
  const SellerDashboardNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DashboardSellerController());
    return Scaffold(
      backgroundColor: AppThemes.white,
      body: Obx(() => controller.tabsPage[controller.currentIndex.value]),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.onScan(),
        shape: const StadiumBorder(),
        backgroundColor: AppThemes.blue,
        child: const Icon(Icons.qr_code_scanner, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() => Platform.isIOS
          ? Container(
              decoration: const BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: controller.currentIndex.value,
                onTap: controller.onItemTapped,
                backgroundColor: AppThemes.white,
                selectedItemColor: AppThemes.blue,
                selectedFontSize: 14,
                unselectedFontSize: 14,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Beranda'),
                  BottomNavigationBarItem(
                    icon:
                        Icon(Icons.qr_code_scanner, color: Colors.transparent),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.store), label: 'Toko')
                ],
              ),
            )
          : BottomAppBar(
              elevation: 10.0,
              padding: EdgeInsets.zero,
              shadowColor: Colors.grey,
              shape: const CircularNotchedRectangle(),
              notchMargin: 4,
              clipBehavior: Clip.antiAlias,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: controller.currentIndex.value,
                onTap: controller.onItemTapped,
                backgroundColor: AppThemes.white,
                selectedItemColor: AppThemes.blue,
                selectedFontSize: 14,
                unselectedFontSize: 14,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Beranda'),
                  BottomNavigationBarItem(
                    icon:
                        Icon(Icons.qr_code_scanner, color: Colors.transparent),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.store), label: 'Toko')
                ],
              ),
            ))
    );
  }
}
