import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/dashboard_buyer_controller.dart';
import 'package:projek_skripsi/application/buyer/voucher/controllers/voucher_buyer_controller.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/models/m_storeMembership.dart';
import 'package:projek_skripsi/utils/routes.dart';

class SearchingBar extends StatelessWidget {
  final DashboardBuyerController? dashboardController;
  final VoucherBuyerController? voucherController;
  const SearchingBar({super.key, this.dashboardController, this.voucherController});

  void filterSearch() {
    if (dashboardController != null) {
      if (dashboardController!.wordTextField.value != '') {
        dashboardController!.lsFilterStore.value = dashboardController!.lsFilter.where((store) => store.name!.toLowerCase().contains(dashboardController!.wordTextField.value.toLowerCase())).toList();
      } else {
        dashboardController!.lsFilterStore.value = dashboardController!.lsFilter;
      }
    } else {
      if (voucherController!.wordTextField.value != '') {
        // print("voucher: ${voucherController!.lsFilter}")
        voucherController!.lsFilterFinalStore.value = voucherController!.lsFilter
            .where((store) => store['StoreName'].toLowerCase().contains(voucherController!.wordTextField.value.toLowerCase()))
            .toList();
      } else {
        voucherController!.lsFilterFinalStore.value = voucherController!.lsFilter;
      }
    }
    
    // dashboardController.lsFilterStore = dashboardController.lsStoreMembership.where((store) => store.contains(wordSearched.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(
              color: AppThemes.blue,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(50.0)
          ),
          child: SearchBar(
            // dashboardController: dashboardController,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)
            ),
            onTap: () {

            },
            onChanged: (value) async {
              print("value changed: ${value}");
              if (dashboardController != null) {
                dashboardController!.wordTextField.value = value;
              } else {
                voucherController!.wordTextField.value = value;
              }
              
              filterSearch();
              // print(dashboardController!.lsFilterStore);
              // dashboardController.openView();
            }, 
            leading: const Icon(
                Icons.search,
                size: 30,
                color: AppThemes.blue,
              ), 
            hintText: "Cari Toko...",
            backgroundColor: const MaterialStatePropertyAll<Color>(AppThemes.white),
          ),
        ),
      );
  }
}