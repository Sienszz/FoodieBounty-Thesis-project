import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/all_voucher/controllers/all_voucher_controller.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class DialogWidget {
  onConfirm() {
    return DialogComponent().onShowModalBottomSheet(
      Padding(
        padding: EdgeInsets.only(
            top: AppThemes().defaultSpacing,
            left: AppThemes().veryExtraSpacing,
            right: AppThemes().veryExtraSpacing,
        ),
        child: Center(
          child: Column(
            children: [
              const TopModalBottom(),
              SizedBox(height: AppThemes().veryExtraSpacing),
              Text(
                'Periksa kembali voucer Anda',
                style: AppThemes().text3Bold(color: AppThemes.black),
              ),
              SizedBox(height: AppThemes().extraSpacing),
              Text(
                'Jangan lupa untuk memeriksa kembali pembuatan voucer anda '
                    'untuk memastikannya tidak ada kesalahan sebelum '
                    'menyelesaikannya',
                style: AppThemes().text4(color: AppThemes.black),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: AppThemes().veryExtraSpacing),
              const EditButton(),
              SizedBox(height: AppThemes().defaultSpacing),
              const ConfirmButton(),
              SizedBox(height: AppThemes().veryExtraSpacing)
            ],
          ),
        ),
      ),
    );
  }

  onShowLoading(){
    return const Center(
      child: CircularProgressIndicator(
        color: AppThemes.blue,
        strokeWidth: 5.0,
      ),
    );
  }

  onDeleteConfirm({required var controller, required String voucherId}){
    return Get.defaultDialog(
      title: 'Konfirmasi',
      middleText: 'Apakah Anda yakin ingin menghapus?',
      textConfirm:'Ok',
      textCancel: 'Batal',
      onConfirm: () {
        Get.back();
        controller.onDeleteVoucher(voucherId: voucherId);
      }
    );
  }
}

class TopModalBottom extends StatelessWidget {
  const TopModalBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade400
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.size.width * .5,
      child: ElevatedButton(
        onPressed: () => Get.back(),
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: AppThemes.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),
        ),
        child: Text(
          'Sunting Voucer',
          style: AppThemes().text4Bold(color: AppThemes.white),
        ),
      ),
    );
  }
}

class ConfirmButton extends  GetView<AllVoucherController> {
  const ConfirmButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.size.width * .5,
      child: ElevatedButton(
        onPressed: () async {
          controller.addVoucher();
        },
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: AppThemes.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),
        ),
        child: Text(
          'Konfirmasi',
          style: AppThemes().text4Bold(color: AppThemes.blue),
        ),
      ),
    );
  }
}


