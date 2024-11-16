import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projek_skripsi/application/seller/all_voucher/controllers/all_voucher_controller.dart';
import 'package:projek_skripsi/application/seller/all_voucher/views/widgets/card_widget.dart';
import 'package:projek_skripsi/application/seller/all_voucher/views/widgets/dialog_widget.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class ExpiredCouponPage extends GetView<AllVoucherController> {
  const ExpiredCouponPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var flag = 0;
    return Obx(() => controller.isLoading.isTrue ? 
      SizedBox(
        width: Get.size.width * .2,
        height: Get.size.width * .2,
        child: DialogWidget().onShowLoading(),
      ) :
      controller.lsVoucher.isEmpty ? Center(child: Text("Tidak Ada Data Voucer")) :
      ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.lsVoucher.length,
        itemBuilder: (context, index) {
          var expDate = DateFormat('yyyyMMdd').format(controller.lsVoucher[index].expDate!);
          var now = DateFormat('yyyyMMdd').format(DateTime.now());
          if(controller.lsVoucher[index].expDate!.isAfter(DateTime.now()) || expDate == now){
            return index == controller.lsVoucher.length - 1 ? flag == 0 ?
              SizedBox(
                height: AppThemes().defaultFormHeight,
                child: Center(child: Text("Tidak Ada Data Voucer"))
              ) : SizedBox(height: AppThemes().defaultFormHeight) : const SizedBox();
          }
          flag = 1;
          return GestureDetector(
            onTap: () => DialogComponent().onShowDetailVoucher(
                data: controller.lsVoucher[index]),
            child: Column(
              children: [
                CouponCard(
                  data: controller.lsVoucher[index],
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "Kuantitas: ",
                                style: AppThemes().text5(color: Colors.grey),
                                children: [
                                  TextSpan(
                                    text: controller.lsVoucher[index].qty!.toString(),
                                    style: AppThemes().text5Bold(color: AppThemes.black),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: AppThemes().extraSpacing),
                            RichText(
                              text: TextSpan(
                                text: "Terjual: ",
                                style: AppThemes().text5(color: Colors.grey),
                                children: [
                                  TextSpan(
                                    text: "5",
                                    style: AppThemes().text5Bold(color: AppThemes.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            controller.reuseVoucher(controller.lsVoucher[index]),
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: AppThemes.green
                        ),
                        child: Text('Reuse', style: AppThemes().text5(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                index == controller.lsVoucher.length - 1 ?
                  SizedBox(height: AppThemes().defaultFormHeight) : const SizedBox()
              ],
            ),
          );
        })
    );
  }
}

