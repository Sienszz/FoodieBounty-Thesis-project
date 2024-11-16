import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/dashboard/controllers/dashboard_seller_controller.dart';
import 'package:projek_skripsi/application/seller/dashboard/views/widgets/card_widget.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class PublicCouponPage extends GetView<DashboardSellerController> {
  const PublicCouponPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var flag = 0;
    return Obx(() => 
      controller.isLoadingCoupon.isTrue ?
      const Center(
        child: CircularProgressIndicator(
          color: AppThemes.blue,
          strokeWidth: 5.0,
        ),
      ) :
      controller.lsVoucher.isEmpty ? Center(child: Text("Tidak Ada Data Voucer")) :
      ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.lsVoucher.length,
          itemBuilder: (context, index) {
            if(controller.lsVoucher[index].type! == 'public') {
              flag = 1;
              return GestureDetector(
                  onTap: () => DialogComponent().onShowDetailVoucher(
                      data: controller.lsVoucher[index]),
                  child: CouponCard(data: controller.lsVoucher[index])
              );
            }
            if(controller.lsVoucher.length-1 == index && flag == 0) {
              return Center(child: Text("Tidak Ada Data Voucer"));
            }
            return const SizedBox();
          }
      )
    );
  }
}
