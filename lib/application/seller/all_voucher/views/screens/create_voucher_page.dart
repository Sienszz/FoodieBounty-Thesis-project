import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/all_voucher/controllers/all_voucher_controller.dart';
import 'package:projek_skripsi/application/seller/all_voucher/views/widgets/dialog_widget.dart';
import 'package:projek_skripsi/application/seller/all_voucher/views/widgets/form_component.dart';
import 'package:projek_skripsi/core/components/form_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class CreateVoucherPage extends GetView<AllVoucherController> {
  const CreateVoucherPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppThemes.white
        ),
        centerTitle: true,
        backgroundColor: AppThemes.blue,
        title: Text('Buat Voucer',
            style: AppThemes().text3Bold(color: AppThemes.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppThemes().veryExtraSpacing),
          child: Form(
            key: controller.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormInputText(
                  title: 'Nama Voucer',
                  txtcontroller: controller.fieldName,
                  textInputType: TextInputType.text,
                  txtLine: 1,
                  txtEnable: true,
                  txtReadonly: false,
                  mandatory: true,
                  validatorMsg: 'Nama  voucer wajib diisi',
                ),
                FormInputText(
                  title: 'Deskripsi',
                  txtcontroller: controller.fieldDesc,
                  textInputType: TextInputType.multiline,
                  txtLine: 4,
                  txtEnable: true,
                  txtReadonly: false,
                  mandatory: true,
                  validatorMsg: 'Deskripsi wajib diisi',
                ),
                Obx(() => controller.fieldType.value != "Voucer Spesial" ?
                FormInputText(
                  title: 'Kuantitas',
                  txtcontroller: controller.fieldQty,
                  textInputType: TextInputType.number,
                  txtLine: 1,
                  txtEnable: true,
                  txtReadonly: false,
                  mandatory: true,
                  validatorMsg: 'Kuantitas voucer wajib diisi',
                ) : SizedBox()),
                FormInputText(
                  title: 'Min. Transaksi',
                  txtcontroller: controller.fieldMinTransaction,
                  textInputType: TextInputType.number,
                  txtLine: 1,
                  txtEnable: true,
                  txtReadonly: false,
                  mandatory: true,
                  validatorMsg: 'Min. Transaksi is required',
                ),
                Obx(() => controller.fieldType.value != "Voucer Spesial" ?
                FormInputText(
                  title: 'Koin',
                  txtcontroller: controller.fieldCoin,
                  textInputType: TextInputType.number,
                  txtLine: 1,
                  txtEnable: true,
                  txtReadonly: false,
                  mandatory: true,
                  validatorMsg: 'Harga voucer wajib diisi',
                ) : SizedBox()),
                SizedBox(height: AppThemes().minSpacing),
                Text('*Rp 1000 = 1 koin',
                    style: AppThemes().text6(color: Colors.grey)),
                SizedBox(height: AppThemes().defaultSpacing),
                Obx(() => CheckboxListTile(
                  title: Text('Diskon',
                      style: AppThemes().text5(color: Colors.black)),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: controller.isCheckDiscount.value,
                  onChanged: (newValue) {
                    controller.isCheckDiscount.value = !controller.isCheckDiscount.value;
                  },
                )),
                Obx(() =>  controller.isCheckDiscount.isTrue ?
                  Column(
                    children: [
                      const DropdownTypeDiscount(),
                      SizedBox(height: AppThemes().defaultSpacing),
                      Obx(() => controller.fieldTypeDiscount.value.contains("Persentase") ?
                      const FormPercentage() : const FormNominal()),
                      SizedBox(height: AppThemes().defaultSpacing),
                    ],
                  ) : const SizedBox()),
                FormInputDate(
                  title: 'Tanggal kadaluarsa',
                  txtcontroller: controller.fieldExpDate,
                  textInputType: TextInputType.datetime,
                  txtLine: 1,
                  txtEnable: true,
                  txtReadonly: true,
                  mandatory: true,
                  validatorMsg: 'Tanggal kadaluarsa wajib diisi',
                  controller: controller,
                ),
                SizedBox(height: AppThemes().extraSpacing),
                const DropdownType(),
                SizedBox(height: AppThemes().extraSpacing),
                Text('Catatan:\n1. Voucer Publik: dapat dibeli oleh pelanggan\n' '2. Voucer Khusus: hanya dapat diperoleh dari hadiah level',
                   style: AppThemes().text6(color: Colors.grey),),
                SizedBox(height: AppThemes().veryExtraSpacing),
                const SubmitButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.size.width,
      child: ElevatedButton(
        onPressed: () => DialogWidget().onConfirm(),
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: AppThemes.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),
        ),
        child: Text(
          'Buat Voucer',
          style: AppThemes().text4Bold(color: AppThemes.white),
        ),
      ),
    );
  }
}
