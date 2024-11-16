import 'package:flutter/material.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class BiggestLevel extends StatelessWidget {
  const BiggestLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text('3',
              style: AppThemes().text3Bold(color: AppThemes.black),
            ),
            SizedBox(width: AppThemes().minSpacing,),
            Text('Level',
              style: AppThemes().text5(color: AppThemes.black),
            ),
          ],
        ),
        SizedBox(width: AppThemes().biggerSpacing,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text('Soto Sapi Seteran Semarang',
                style: AppThemes().text3Bold(color: AppThemes.black),
                maxLines: 3,
                softWrap: true,
                // overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: AppThemes().minSpacing,),
            Text('Level terbesar pada suatu toko',
              style: AppThemes().text5(color: AppThemes.black),
              softWrap: true,
            )
          ],
        )
      ],
    );
  }
}