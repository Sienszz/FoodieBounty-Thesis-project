import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/dashboard_buyer_controller.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/store_detail_controller.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/models/m_level.dart';
import 'package:projek_skripsi/core/models/m_storeMembership.dart';
import 'package:projek_skripsi/core/models/m_storeVoucher.dart';
import 'package:projek_skripsi/utils/routes.dart';

class DialogComponent {
  onShowLoading(){
    return Center(
        child: SizedBox(
          height: Get.size.height * 0.2,
          child: Lottie.asset(
              'assets/lottie/loading.json',
              repeat: true
          ),
        )
    );
  }

  onLoadingDismissible(){
    return Get.dialog(
      Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: AppThemes.blue,
            strokeWidth: 10,
            backgroundColor: Colors.grey.shade300,
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  popupTransaction({required int coin, required int exp, required String storeId,
    required String historyId, required String storeName, bool? storeDetail}){
    var dashboardController = Get.find<DashboardBuyerController>();
    return Get.dialog(
      GestureDetector(
        onTap: () async {
          Get.back();
          await dashboardController.refreshData();
          if(Get.find<DashboardBuyerController>().isLevelUp(storeId: storeId)){
            final player = AudioPlayer();
            player.play(AssetSource('sfx/level-up.mp3'));
            final level = Get.find<DashboardBuyerController>().getLevel(storeId: storeId);
            DialogComponent().popupLevelUp(historyId, storeId, storeName, level);
          } else {
            dashboardController.isOpen(false);
            dashboardController.updateTransactionSuccessfull(historyId);
            if(Get.currentRoute == AppRoutes.selectedStore){
              Get.until((route) => Get.currentRoute == AppRoutes.buyerDashboard);
            }
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.7),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/vector/header_transaction.png'),
                SizedBox(
                  width: Get.size.width *.5,
                  child: Lottie.asset(
                    'assets/lottie/treasure_new.json',
                    repeat: true,
                    frameRate: FrameRate.max,
                  )
                ),
                SizedBox(height: AppThemes().extraSpacing),
                Text('${storeName}', textAlign: TextAlign.center,
                  style: AppThemes().text3Bold(color: const Color(0xffF5D38E))),
                Text('Hadiah yang anda terima', textAlign: TextAlign.center,
                  style: AppThemes().text3(color: const Color(0xffF5D38E))),  
                SizedBox(height: AppThemes().veryExtraSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.size.width * .2,
                      height: Get.size.width * .2,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/vector/star.png'),
                          fit: BoxFit.cover
                        )
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(exp.toString(), style: AppThemes().text6Bold(color: Colors.white)),
                            Text('EXP', style: AppThemes().text6Bold(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: AppThemes().veryExtraSpacing),
                    Container(
                      width: Get.size.width * .17,
                      height: Get.size.width * .17,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/vector/coin.png'),
                              fit: BoxFit.cover
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(coin.toString(), style: AppThemes().text6Bold(color: Colors.white)),
                          Text('Koin', style: AppThemes().text6Bold(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppThemes().veryExtraSpacing),
                Text('Tekan layar untuk keluar',
                    style: AppThemes().text6Bold(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      useSafeArea: false
    );
  }

  popupLevelUp(String historyId, String storeId, String storeName, int level){
    return Get.dialog(
      GestureDetector(
        onTap: () {
          Get.back();
          Get.find<DashboardBuyerController>().isOpen(false);
          Get.find<DashboardBuyerController>().updateTransactionSuccessfull(historyId);
          if(Get.currentRoute == AppRoutes.selectedStore){
            Get.until((route) => Get.currentRoute == AppRoutes.buyerDashboard);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.7),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/vector/header_level_up.png'),
                SizedBox(height: AppThemes().veryExtraSpacing),
                Text(
                  'Level ${level} >> ${level < 5 ? level+1 : 'Max'}',
                  style: AppThemes().text3Bold(color: const Color(0xffBBF3FF))
                ),
                Text('${storeName}', textAlign: TextAlign.center,
                    style: AppThemes().text3Bold(color: const Color(0xffBBF3FF))),
                SizedBox(
                    width: Get.size.width *.5,
                    child: Lottie.asset(
                      'assets/lottie/level.json',
                      repeat: true,
                      frameRate: FrameRate.max,
                    )
                ),
                SizedBox(height: AppThemes().extraSpacing),
                // Text('Level ${level} >> ${level < 5 ? level : 'Max'}', textAlign: TextAlign.center,
                //     style: AppThemes().text3Bold(color: const Color(0xffBBF3FF))),
                // Text('${storeName}', textAlign: TextAlign.center,
                //     style: AppThemes().text3Bold(color: const Color(0xffBBF3FF))),
                Text('Buka Toko dan dapatkan hadiah Anda', textAlign: TextAlign.center,
                    style: AppThemes().text3(color: const Color(0xffBBF3FF))),
                SizedBox(height: AppThemes().veryExtraSpacing),
                ElevatedButton(
                  onPressed: () => {
                    Get.toNamed(AppRoutes.selectedStore, arguments: {
                        'store': Get.find<DashboardBuyerController>().getStoreleveledUp(storeId)
                    })
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    backgroundColor: AppThemes.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                  ),
                  child: Text(
                    'Buka Toko',
                    style: AppThemes().text4Bold(color: AppThemes.white),
                  ),
                ),
                SizedBox(height: AppThemes().veryExtraSpacing),
                Text('Tekan layar untuk keluar',
                    style: AppThemes().text6Bold(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      useSafeArea: false
    );
  }

  popupReward(int? coin, int? totalVoucher){
    return Get.dialog(
        GestureDetector(
          onTap: () async {
            Get.back();
          },
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.7),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/vector/header_reward.png'),
                  SizedBox(
                      width: Get.size.width *.5,
                      child: Lottie.asset(
                        'assets/lottie/reward.json',
                        repeat: true,
                        frameRate: FrameRate.max,
                      )
                  ),
                  SizedBox(height: AppThemes().extraSpacing),
                  Text('Hadiah telah diambil',
                      style: AppThemes().text3Bold(color: const Color(0xffF5D38E))),
                  SizedBox(height: AppThemes().veryExtraSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(totalVoucher != -1)
                        Container(
                          width: Get.size.width * .2,
                          height: Get.size.width * .2,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/vector/voucher_reward.png'),
                                  fit: BoxFit.cover
                              )
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(totalVoucher.toString() + 'x',
                                    style: AppThemes().text5Bold(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      if(totalVoucher != -1)
                        SizedBox(width: AppThemes().veryExtraSpacing),
                      if(coin != -1)
                        Container(
                          width: Get.size.width * .17,
                          height: Get.size.width * .17,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/vector/coin.png'),
                                  fit: BoxFit.cover
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(coin.toString(), style: AppThemes().text6Bold(color: Colors.white)),
                              Text('Koin', style: AppThemes().text6Bold(color: Colors.white)),
                            ],
                          ),
                        )
                    ],
                  ),
                  SizedBox(height: AppThemes().veryExtraSpacing),
                  Text('Tekan layar untuk keluar',
                      style: AppThemes().text6Bold(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false,
        useSafeArea: false
    );
  }

  popUpInfoLevelUp(List<LevelModel> selectedStore) {
    final CarouselController controller = CarouselController();
    var activePage = 0.obs;
    return Get.dialog(
        GestureDetector(
          onTap: () => Get.back(),
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.7),
            body: Center(
              child: Container(
                  width: Get.size.width * .8,
                  height: Get.size.height * .4,
                  decoration: BoxDecoration(
                    color: AppThemes.white,
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            CarouselSlider.builder(
                              carouselController: controller,
                              options: CarouselOptions(
                                height: Get.size.height * .3,
                                enableInfiniteScroll: false,
                                initialPage: 0,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  activePage.value = index;
                                },
                              ),
                              itemCount: selectedStore.length,
                              itemBuilder: (context, index, realIndex) {
                                return Container(
                                  width: Get.size.width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Keuntungan Level',
                                          style: AppThemes().text3Bold(color: AppThemes.blue),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Level ${index+1}',
                                          style: AppThemes().text4Bold(color: AppThemes.blue),
                                        ),
                                      ),
                                      SizedBox(
                                        height: AppThemes().biggerSpacing,
                                      ),
                                      Text(
                                        'Voucer: ${selectedStore[index].voucherReward?.length ?? '-'}',
                                        style: AppThemes().text3Bold(color: AppThemes.blue),
                                      ),
                                      SizedBox(
                                        height: AppThemes().biggerSpacing,
                                      ),
                                      if(selectedStore[index].voucherReward?.length != null)
                                        for(var item in selectedStore[index].voucherReward!)
                                          Text(
                                            '    - ' + item['name'],
                                            style: AppThemes().text4Bold(color: AppThemes.darkBlue),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        SizedBox(
                                          height: AppThemes().biggerSpacing,
                                        ),
                                      Text(
                                        'Koin: ${selectedStore[index].coinReward ?? '-'}',
                                        style: AppThemes().text3Bold(color: AppThemes.blue),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            // SizedBox(
                            //   width: AppThemes().defaultSpacing,
                            // ),
                            Obx(() => Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    activePage.value == 0 ? null : controller.previousPage(duration: Duration(milliseconds: 500));
                                  },
                                  child: Icon(Icons.arrow_back_ios_new,
                                    color: activePage.value == 0 ? Colors.grey : AppThemes.blue,
                                    size: 15,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: selectedStore.asMap().entries.map((entry) {
                                    return GestureDetector(
                                      onTap: () => controller.animateToPage(entry.key),
                                      child: Container(
                                        width: 12.0,
                                        height: 12.0,
                                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: AppThemes.darkBlue, width: 2.0),
                                            color: (activePage.value != entry.key
                                                    ? Colors.transparent
                                                    : AppThemes.darkBlue)
                                            ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    activePage.value == 4 ? null : controller.nextPage(duration: Duration(milliseconds: 500));
                                  },
                                  child: Icon(Icons.arrow_forward_ios,
                                    color: activePage.value == 4 ? Colors.grey : AppThemes.blue,
                                    size: 15,
                                  ),
                                ),
                              ],)
                            ),
                        ],
                      ),
                  ),
                ),
            ),
          ),
        ),
        barrierDismissible: false,
        useSafeArea: false
    );
  }

  onShowModalBottomSheet(Widget widget){
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8.0),
          ),
        ),
        isScrollControlled: true,
        context: Get.context!,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(
              children: [
                widget,
              ],
            ),
          );
        }
    );
  }

  onShowDetailVoucher({required StoreVoucherModel data, int? qty}) {
    return Get.dialog(
        AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding: EdgeInsets.all(
                AppThemes().extraSpacing,
              ),
              width: Get.size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DescText(title: 'Nama Voucer', subtitle: data.name ?? "-"),
                    DescText(title: 'Deskripsi', subtitle: data.description ?? "-"),
                    DescText(title: 'Kuantitas', subtitle: data.qty == null ?
                      "-" : qty == null ? data.qty.toString() : qty.toString()),
                    DescText(title: 'Min. Transaksi', subtitle: data.minTransaction == null ?
                      "-" : 'Rp ${data.minTransaction}'),
                    DescText(title: 'Koin', subtitle: data.coin == null ?
                      "-" : data.coin.toString()),
                    data.percentage == null ? const SizedBox() :
                    DescText(title: 'Persentase Diskon', subtitle: '${data.percentage} %'),
                    data.maxNominal == null ? const SizedBox() :
                    DescText(title: 'Max. Nominal Diskon', subtitle: 'Rp ${data.maxNominal}'),
                    data.nominal == null ? const SizedBox() :
                    DescText(title: 'Nominal Diskon', subtitle: 'Rp ${data.nominal}'),
                    DescText(title: 'Tanggal Kadaluarsa', subtitle: DateFormat('dd MMMM yyyy').format(data.expDate!)),
                    SizedBox(height: AppThemes().veryExtraSpacing),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppThemes.blue),
                        child: Text("Ok",
                          style: AppThemes().text5(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        barrierDismissible: false);
  }
}

class DescText extends StatelessWidget {
  final String title;
  final String subtitle;
  const DescText({Key? key,
    required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppThemes().extraSpacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.size.width * .3,
            child: Text(title, style: AppThemes().text5Bold(color: AppThemes.blue)),
          ),
          SizedBox(
            width: Get.size.width * .05,
            child: Text(':', style: AppThemes().text5Bold(color: AppThemes.blue)),
          ),
          Expanded(child: Text(subtitle,
              style: AppThemes().text5(color: AppThemes.black)))
        ],
      ),
    );
  }
}