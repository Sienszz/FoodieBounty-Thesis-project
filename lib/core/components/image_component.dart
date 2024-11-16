import 'package:flutter/material.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class ImageComponent {
  onShowImagePicker({required var controller}) {
    return DialogComponent().onShowModalBottomSheet(
      Padding(
        padding: EdgeInsets.only(
            top: AppThemes().defaultSpacing,
            left: AppThemes().veryExtraSpacing,
            right: AppThemes().veryExtraSpacing,
            bottom: AppThemes().veryExtraSpacing,
        ),
        child: Center(
          child: Column(
            children: [
              const TopModalBottom(),
              SizedBox(height: AppThemes().veryExtraSpacing),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => controller.getPhotoFromCamera(),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            backgroundColor: AppThemes.blue,
                            radius: 30,
                            child: Icon(
                              Icons.camera_alt,
                              color: AppThemes.white,
                            ),
                          ),
                          SizedBox(height: AppThemes().defaultSpacing),
                          Text('Kamera', style: AppThemes().text5Bold(color: Colors.black))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => controller.getPhotoFromGalery(),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            backgroundColor: AppThemes.blue,
                            radius: 30,
                            child: Icon(
                              Icons.photo,
                              color: AppThemes.white,
                            ),
                          ),
                          SizedBox(height: AppThemes().defaultSpacing),
                          Text('Galeri', style: AppThemes().text5Bold(color: Colors.black))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
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
