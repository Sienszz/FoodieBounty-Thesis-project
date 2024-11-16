import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/dashboard_buyer_controller.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/widgets/card_category_widget.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/screens/store/nearby_store_page.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/models/m_storeMembership.dart';
import 'package:projek_skripsi/utils/routes.dart';

class BuyserDashboardBody extends GetView<DashboardBuyerController> {
  const BuyserDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => controller.refreshData(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: Get.size.width * .2,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppThemes().extraSpacing),
                  child: Text(
                    'Kategori',
                    style: AppThemes().text3Bold(color: AppThemes.lightBlue),
                  ),
                ),
              ),
              SizedBox(
                height: AppThemes().biggerSpacing,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Category(title: 'Nasi', assetImg: controller.imagePaths[0], list: controller.lsStoreRice,),
                      Category(title: 'Sayuran', assetImg: controller.imagePaths[1], list: controller.lsStoreVegetables),
                      Category(title: 'Kacang', assetImg: controller.imagePaths[2], list: controller.lsStoreNuts),
                    ],
                  ),
                  SizedBox(width: AppThemes().extraSpacing),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Category(title: 'Mie', assetImg: controller.imagePaths[3], list: controller.lsStoreNoodles),
                      Category(title: 'Cepat Saji', assetImg: controller.imagePaths[4], list: controller.lsStoreFastFood),
                      Category(title: 'Cemilan', assetImg: controller.imagePaths[5], list: controller.lsStoreSnacks),
                    ],
                  ),
                  SizedBox(width: AppThemes().extraSpacing),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Category(title: 'Makanan Laut', assetImg: controller.imagePaths[6], list: controller.lsStoreSeaFood),
                      Category(title: 'Kue', assetImg: controller.imagePaths[7], list: controller.lsStorePastry),
                      Category(title: 'Kopi', assetImg: controller.imagePaths[8], list: controller.lsStoreCoffee),
                    ],
                  ),
                  SizedBox(width: AppThemes().extraSpacing),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Category(title: 'Daging', assetImg: controller.imagePaths[9], list: controller.lsStoreMeat),
                      Category(title: 'Manis', assetImg: controller.imagePaths[10], list: controller.lsStoreSweets),
                      Category(title: 'Minuman', assetImg: controller.imagePaths[11], list: controller.lsStoreBeverages),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: AppThemes().biggerSpacing,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppThemes().extraSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Terdekat',
                      style: AppThemes().text3Bold(color: AppThemes.lightBlue),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.ExpandMoreStoreTitle.value = 'TERDEKAT';
                        Get.toNamed(AppRoutes.expandMoreStore);
                      },
                      child: Text('Lebih Lanjut >',
                          style: AppThemes().text5(color: AppThemes.lightBlue)
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppThemes().biggerSpacing,
              ),
              SizedBox(
                height: Get.size.height * .35,
                child: const NearbyStorePage()
              ),
            ],
          ),
    ));
  }
}

class Category extends GetView<DashboardBuyerController> {
  final String title;
  final String assetImg;
  final List<StoreMembershipModel> list;

  const Category({Key? key, required this.title, required this.assetImg,
    required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppThemes().extraSpacing),
      child: GestureDetector(
          onTap: () {
            controller.lsFilter = list;
            controller.lsFilterStore.value = controller.lsFilter;
            controller.wordTextField.value = '';
            controller.ExpandMoreStoreTitle.value = title;
            Get.toNamed(AppRoutes.expandCategoryStore);
          },
          child: CategoryCard(name: title, image: assetImg)
      ),
    );
  }
}
