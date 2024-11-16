import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/edit_account/controllers/edit_account_controller.dart';
import 'package:projek_skripsi/core/components/form_component.dart';
import 'package:projek_skripsi/core/components/image_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class EditBuyerPageBody extends GetView<EditAccountController> {
  const EditBuyerPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key : controller.formKey,
      child: Column(
        children: [
          FormInputText(
            title: 'Nama',
            txtcontroller: controller.fieldName,
            textInputType: TextInputType.text,
            txtLine: 1,
            txtEnable: true,
            txtReadonly: false,
            mandatory: true,
            validatorMsg: 'Nama pengguna wajib di isi',
          ),
          FormInputEmail(
            title: 'Email',
            txtcontroller: controller.fieldEmail,
            textInputType: TextInputType.emailAddress,
            txtLine: 1,
            txtEnable: false,
            txtReadonly: true,
            mandatory: true,
            validatorMsg: 'Email wajib di isi',
          ),
          // FormInputPassword(
          //   title: 'Password',
          //   txtcontroller: controller.fieldPassword,
          //   textInputType: TextInputType.visiblePassword,
          //   txtLine: 1,
          //   txtEnable: true,
          //   txtReadonly: false,
          //   mandatory: true,
          //   validatorMsg: 'Password is required',
          //   controller: controller,
          // ),
          // FormInputConfirmPassword(
          //   title: 'Confirm Password',
          //   txtcontroller: controller.fieldConfirmPassword,
          //   textInputType: TextInputType.visiblePassword,
          //   txtLine: 1,
          //   txtEnable: true,
          //   txtReadonly: false,
          //   mandatory: true,
          //   validatorMsg: 'Confirm Password is required',
          //   controller: controller,
          // ),
          FormInputText(
              title: 'Nomor Telepon',
              txtcontroller: controller.fieldPhoneNumber,
              textInputType: TextInputType.phone,
              txtLine: 1,
              txtEnable: true,
              txtReadonly: false,
              mandatory: true,
              validatorMsg: 'Nomor Telepon wajib di isi',
          ),
          const ImageForm(),
          SizedBox(height: AppThemes().extraSpacing),
          const SubmitButton()
        ],
      ),
    );
  }
}

class ImageForm extends GetView<EditAccountController> {
  const ImageForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Foto Profil",
                        style: AppThemes().text5Bold(color: AppThemes.blue)
                      ),
                      TextSpan(
                        text: "*",
                        style: AppThemes().text5(color: AppThemes.red)
                      ),
                    ]
                  )
                ),
              ),
              ElevatedButton(
                onPressed: () => ImageComponent().onShowImagePicker(
                  controller: controller.attController
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppThemes.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)
                    )
                ),
                child: Text(
                  'Pilih',
                  style: AppThemes().text5Bold(color: AppThemes.white),
                ),
              )
            ],
          ),
          SizedBox(height: AppThemes().extraSpacing),
          const Photo()
        ],
      ),
    );
  }
}

class Photo extends GetView<EditAccountController> {
  const Photo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppThemes.darkBlue),
      ),
      child: Obx(
        () => controller.attController.isUpload.isTrue
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppThemes.blue,
                  strokeWidth: 5.0,
                ),
              )
            : controller.attController.imgUrl.value != ''
                ? Image.network(controller.attController.imgUrl.value)
                : Image.file(File(controller.attController.imgPath.value))
      ),
    );
  }
}

class SubmitButton extends GetView<EditAccountController> {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.size.width,
      child: ElevatedButton(
        onPressed: () => controller.onSave(),
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: AppThemes.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),
        ),
        child: Text(
          'Kirim',
          style: AppThemes().text4Bold(color: AppThemes.white),
        ),
      ),
    );
  }
}