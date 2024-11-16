import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/core/components/image_component.dart';
import 'package:projek_skripsi/core/components/map/views/maps_page.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/components/form_component.dart';
import 'package:projek_skripsi/application/seller/edit_store/controllers/edit_store_controller.dart';

class EditStorePageBody extends GetView<EditStoreController> {
  const EditStorePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          FormInputText(
            title: 'Nama Toko',
            txtcontroller: controller.fieldName,
            textInputType: TextInputType.text,
            txtLine: 1,
            txtEnable: true,
            txtReadonly: false,
            mandatory: true,
            validatorMsg: 'Nama Toko wajib diisi',
          ),
          FormInputEmail(
            title: 'Email',
            txtcontroller: controller.fieldEmail,
            textInputType: TextInputType.emailAddress,
            txtLine: 1,
            txtEnable: false,
            txtReadonly: true,
            mandatory: true,
            validatorMsg: 'Email wajib diisi',
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
            validatorMsg: 'Nomor Telepon wajib diisi',
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: AppThemes().defaultSpacing
            ),
            width: Get.size.width,
            height: Get.size.height * .4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: const MapsPage()
          ),
          FormInputAddress(
            title: 'Alamat',
            txtcontroller: controller.fieldAddress,
            textInputType: TextInputType.text,
            txtLine: 5,
            txtEnable: true,
            txtReadonly: false,
            mandatory: true,
            validatorMsg: 'Alamat wajib diisi',
            controller: controller,
          ),
          const ImageForm(),
          SizedBox(height: AppThemes().extraSpacing),
          const TagForm(),
          SizedBox(height: AppThemes().extraSpacing),
          const SubmitButton()
        ],
      ),
    );
  }
}

class ImageForm extends GetView<EditStoreController> {
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
                  'Select',
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

class Photo extends GetView<EditStoreController> {
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

class TagForm extends GetView<EditStoreController> {
  const TagForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            text: 'Tag (max. 4)',
            style: TextStyle(color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: '*',
                  style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        SizedBox(height: AppThemes().extraSpacing),
        Obx(() => Container(
            width: Get.size.width,
            padding: EdgeInsets.all(AppThemes().extraSpacing),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: AppThemes.darkBlue)
            ),
            child: Wrap(
              spacing: 15,
              runSpacing: 15,
              children: [
                for(var e in controller.lsTag)
                  InkWell(
                      onTap: () {
                        if (!e['isClick'] && controller.countTag.value < 4) {
                         controller.countTag.value += 1;
                         e['isClick'] = true;
                        } else if (e['isClick']){
                          controller.countTag.value -= 1;
                          e['isClick'] = false;
                        }
                        controller.lsTag.refresh();
                      },
                      child: TagItem(title: e['name'], isClick: e['isClick'])
                  )
              ],
            )
        )),
        Obx(() => controller.errorMsg.value != '' ?
        Text(controller.errorMsg.value,
            style: AppThemes().text5(color: Colors.red)) : const SizedBox())
      ],
    );
  }
}

class TagItem extends StatelessWidget {
  final String title;
  final bool isClick;
  const TagItem({Key? key, required this.title, required this.isClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppThemes().defaultSpacing),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: AppThemes.darkBlue),
          color: isClick ? AppThemes.blue : AppThemes.white
      ),
      child: Text(title, style: AppThemes().text5(
          color: isClick ? AppThemes.white : AppThemes.blue)),
    );
  }
}

class SubmitButton extends GetView<EditStoreController> {
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
