import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/leveling/controllers/create_level_controller.dart';
import 'package:projek_skripsi/application/seller/leveling/views/widgets/dialog_widget.dart';
import 'package:projek_skripsi/core/components/form_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class CreateLevelPage extends StatelessWidget {
  const CreateLevelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateLevelController(Get.arguments));
    return Scaffold(
      backgroundColor: AppThemes.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppThemes.white
        ),
        centerTitle: true,
        backgroundColor: AppThemes.blue,
        title: Text(controller.title,
            style: AppThemes().text3Bold(color: AppThemes.white)),
      ),
      body: Obx(() => controller.isLoading.isTrue ?
      const Center(
        child: CircularProgressIndicator(
          color: AppThemes.blue,
          strokeWidth: 5.0,
        ),
      ) : 
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppThemes().veryExtraSpacing),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormInputText(
                    title: 'Exp dibutuhkan',
                    txtcontroller: controller.fieldExp,
                    textInputType: TextInputType.number,
                    txtLine: 1,
                    txtEnable: true,
                    txtReadonly: false,
                    mandatory: true,
                    validatorMsg: 'Exp wajib diisi',
                ),
                SizedBox(height: AppThemes().extraSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Hadiah', style: AppThemes().text4(color: Colors.black)),
                    GestureDetector(
                        onTap: () => DialogWidget().onChooseReward(
                            controller: controller
                        ),
                        child: const Icon(Icons.add_circle,
                            color: AppThemes.blue, size: 30)
                    )
                  ],
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.lsRewardWidget.length,
                    itemBuilder: (context, index){
                      return controller.lsRewardWidget[index];
                    }
                ),
                SizedBox(height: AppThemes().veryExtraSpacing),
                SizedBox(height: AppThemes().veryExtraSpacing),
                Text(controller.errorMsg.value,
                    style: AppThemes().text5(color: Colors.red)),
                SizedBox(height: AppThemes().defaultSpacing),
                Text('Catatan: EXP dan koin diperoleh setiap melakukan transaksi dengan'
                    ' konversi Rp 1000 = 1 XP dan 1 koin',
                    style: AppThemes().text5(color: Colors.grey)),
                SizedBox(height: AppThemes().veryExtraSpacing),
                const SaveButton()
              ],
            ))
        ),
      ),
    ));
  }
}

class SaveButton extends GetView<CreateLevelController> {
  const SaveButton({Key? key}) : super(key: key);

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
          'Simpan',
          style: AppThemes().text4Bold(color: AppThemes.white),
        ),
      ),
    );
  }
}