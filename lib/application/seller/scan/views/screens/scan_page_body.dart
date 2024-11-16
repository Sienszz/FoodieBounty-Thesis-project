import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projek_skripsi/application/seller/scan/controllers/scan_seller_controller.dart';
import 'package:projek_skripsi/application/seller/scan/views/widgets/components.dart';
import 'package:projek_skripsi/core/components/form_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class ScanPageBody extends GetView<ScanSellerController> {
  const ScanPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppThemes().veryExtraSpacing),
        child: Form(
          key: controller.formKey,
          child: Column(
          children: [
            Text('Nama Pelanggan', style: AppThemes().text4(color: AppThemes.blue)),
            SizedBox(height: AppThemes().defaultSpacing),
            Text(controller.customer.value.name ?? "", style: AppThemes().text4Bold(color: AppThemes.black)),
            SizedBox(height: AppThemes().veryExtraSpacing),
            FormInputText(
              title: 'Total transaksi',
              txtcontroller: controller.fieldTotal,
              textInputType: TextInputType.number,
              txtLine: 1,
              txtEnable: true,
              txtReadonly: false,
              mandatory: true,
              validatorMsg: 'Total transaksi wajib diisi',
            ),
            SizedBox(height: AppThemes().veryExtraSpacing),
            SizedBox(
              width: Get.size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: Get.size.width * .7,
                    child: FormInputText(
                      title: 'ID Voucer',
                      txtcontroller: controller.fieldVoucherId,
                      textInputType: TextInputType.text,
                      txtLine: 1,
                      txtEnable: true,
                      txtReadonly: false,
                      mandatory: false,
                    ),
                  ),
                  SizedBox(width: AppThemes().defaultSpacing),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: const BoxDecoration(
                        color: AppThemes.blue,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        )
                      ),
                      child: IconButton(
                        onPressed: () => controller.scanBarcode(),
                        icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: AppThemes().extraSpacing),
            Obx(() => controller.isLoadingDetailVoucher.isTrue ? 
              const Center(child: CircularProgressIndicator(
                color: AppThemes.blue,
                strokeWidth: 5.0,
              )) :
              Container(
                width: Get.size.width,
                padding: EdgeInsets.all(AppThemes().extraSpacing),
                decoration: BoxDecoration(
                  color: AppThemes.white,
                  border: Border.all(color: AppThemes.blue),
                  borderRadius: BorderRadius.circular(8.0)
                ),
                child: Column(
                  children: [
                    DescText(title: 'Nama Voucer', subtitle: controller.voucher.value.name ?? "-"),
                    SizedBox(height: AppThemes().extraSpacing),
                    DescText(title: 'Kuantitas', subtitle: controller.voucher.value.qty != null ?
                      controller.voucher.value.qty.toString() : "-"),
                    SizedBox(height: AppThemes().extraSpacing),
                    DescText(title: 'Tanggal kadaluarsa', subtitle: controller.voucher.value.expDate != null ?
                      DateFormat("dd MMM yyyy").format(controller.voucher.value.expDate!) : "-"),
                    SizedBox(height: AppThemes().extraSpacing),
                    DescText(title: 'Min. Transaksi', subtitle: controller.voucher.value.minTransaction != null ?
                      'Rp ${controller.voucher.value.minTransaction!}' : "-"),
                    SizedBox(height: AppThemes().extraSpacing),
                    DescText(title: 'Deskripsi', subtitle: controller.voucher.value.description ?? "-"),
                    controller.voucher.value.typeDiscount != null && controller.voucher.value.typeDiscount == "percentage" ?
                        const Percentage() : const Nominal()
                  ],
                )
              ),
            ),
            SizedBox(height: AppThemes().veryExtraSpacing),
            Obx(() => Text(controller.errorMsg.value,
                    style: AppThemes().text5(color: Colors.red))
            ),
            SizedBox(height: AppThemes().defaultSpacing),
            const ConfirmButton()

          ],
        ),
        )
      ),
    );
  }
}

class Percentage extends GetView<ScanSellerController> {
  const Percentage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppThemes().extraSpacing),
        DescText(title: 'Persentase', subtitle: controller.voucher.value.percentage != null ?
        '${controller.voucher.value.percentage!} %' : "-"),
        SizedBox(height: AppThemes().extraSpacing),
        DescText(title: 'Max. Nominal Diskon', subtitle: controller.voucher.value.maxNominal != null ?
        'Rp ${controller.voucher.value.maxNominal!}' : "-"),
      ],
    );
  }
}

class Nominal extends GetView<ScanSellerController> {
  const Nominal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppThemes().extraSpacing),
        DescText(title: 'Nominal Diskon', subtitle: controller.voucher.value.nominal != null ?
        'Rp ${controller.voucher.value.nominal!}' : "-"),
      ],
    );
  }
}

class ConfirmButton extends GetView<ScanSellerController> {
  const ConfirmButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.size.width,
      child: ElevatedButton(
        onPressed: () => controller.onConfirm(),
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: AppThemes.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),
        ),
        child: Text(
          'Konfirmasi Transaksi',
          style: AppThemes().text4Bold(color: AppThemes.white),
        ),
      ),
    );
  }
}
