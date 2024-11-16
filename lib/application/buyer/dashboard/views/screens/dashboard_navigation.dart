import 'dart:developer';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/dashboard_buyer_controller.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/widgets/dialog_widget.dart';

class BuyerDashboardNavigation extends StatelessWidget {
  const BuyerDashboardNavigation({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DashboardBuyerController());
    return Scaffold(
      backgroundColor: AppThemes.white,
      resizeToAvoidBottomInset: false,
      body: Obx(() =>
          controller.isLoadingUser.isTrue ?
          const Center(
            child: CircularProgressIndicator(
              color: AppThemes.blue,
              strokeWidth: 5.0,
            ),
          ) :
          StreamBuilder(
            stream: controller.streamData(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active) {
                if(snapshot.hasData && snapshot.data.docs.isNotEmpty) {
                  var temp = snapshot.data.docs;
                  if(temp[0].data()['transaction_success'] == false &&
                    controller.isOpen.isFalse){
                    var store = controller.lsStore.firstWhereOrNull((element) => element.id == temp[0].data()['store_id']);
                    Future.delayed(const Duration(milliseconds: 200), () {
                      controller.isOpen(true);
                      final player = AudioPlayer();
                      player.play(AssetSource('sfx/transaction.mp3'));
                      // print("temp: ${store!.name!}");
                      DialogComponent().popupTransaction(
                          coin: temp[0].data()['coin'],
                          exp: temp[0].data()['exp'],
                          storeId: temp[0].data()['store_id'],
                          historyId: temp[0].id,
                          storeName: store!.name!,
                      );
                    });
                  }
                }
              }
              return Obx(() => controller.tabsPage[controller.currentIndex.value]);
            }
          )),
      floatingActionButton: Container(
        child: FloatingActionButton(
          onPressed: () => DialogWidget().onShowBarcode(controller.user.value),
          shape: const StadiumBorder(),
          backgroundColor: AppThemes.blue,
          child: const Icon(Icons.qr_code_scanner, color: AppThemes.white,),
        ),
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
                    icon: Icon(Icons.home),
                    label: "Beranda",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.discount),
                    label: "Voucer",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.discount,
                      color: Colors.transparent,
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history),
                    label: "Riwayat",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: "Akun",
                  ),
                ],
            ),
          )
        : BottomAppBar(
            elevation: 0.0,
            padding: EdgeInsets.zero,
            shadowColor: Colors.black,
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
                  icon: Icon(Icons.home),
                  label: "Beranda",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.discount),
                  label: "Voucer",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.discount,
                    color: Colors.transparent,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: "Riwayat",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: "Akun",
                ),
              ],
            ),
          ),
      )
    );
  }
}