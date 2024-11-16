import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/dashboard_buyer_controller.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/widgets/dialog_widget.dart';
import 'package:projek_skripsi/authorization/modules/login/controllers/auth_controller.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/core/providers/cloud_messaging.dart';
import 'package:projek_skripsi/utils/pages.dart';
import 'package:projek_skripsi/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dcdg/dcdg.dart';

import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/utils/lang/localization.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseMessagingAPI().requestPermission();
  // FirebaseMessagingAPI().getToken();
  FirebaseMessagingAPI().initialized();
  // await FirebaseMessaging.instance.in();
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final authController = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authController.streamAuthStatus,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.active){
          log("apakek isinya ${snapshot.data}");
          if (snapshot.data != null && snapshot.data!.emailVerified) {
            return FutureBuilder<bool>(
              future: authController.getUserRole(snapshot.data!.email!),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator while waiting for the future to complete
                  return DialogWidget().onShowLoading();
                } else if (roleSnapshot.connectionState == ConnectionState.done) {
                  if (roleSnapshot.hasError) {
                    // Handle any error that occurred during fetching the data
                    return DialogWidget().onShowLoading();
                  } else {
                    // Future completed successfully, handle the data
                    bool? userRole = roleSnapshot.data;
                    return GetMaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Flutter Demo',
                      theme: ThemeData(
                        primaryColor: AppThemes.blue,
                        appBarTheme: const AppBarTheme(color: AppThemes.blue),
                        iconTheme: const IconThemeData(
                          color: AppThemes.white, //change your color here
                        ),
                        colorScheme: ColorScheme.fromSwatch().copyWith( // Use colorScheme
                          background: AppThemes.white, // Set the background color
                        ),
                      ),
                      initialRoute: (userRole != null && userRole ? AppRoutes.buyerDashboard : AppRoutes.sellerdashboard),
                      getPages: AppPages.pages,
                      translations: Localization(),
                      locale: const Locale('id', 'ID'),
                      fallbackLocale: const Locale('en', 'US'),
                    );
                  }
                } else {
                  // Handle other connection states if necessary
                  return Scaffold(
                    body: Center(
                      child: Text('Connection State: ${roleSnapshot.connectionState}'),
                    ),
                  );
                }
              },


            );
          } else {
            // User is not authenticated or email is not verified
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                primaryColor: AppThemes.blue,
                appBarTheme: const AppBarTheme(color: AppThemes.blue),
                  iconTheme: const IconThemeData(
                    color: AppThemes.white, //change your color here
                  ),
                  colorScheme: ColorScheme.fromSwatch().copyWith( // Use colorScheme
                    background: AppThemes.white, // Set the background color
                  ),
                ),
                initialRoute: AppRoutes.onBoarding,
                getPages: AppPages.pages,
                translations: Localization(),
                // get depends device -> locale: Get.deviceLocale,
                locale: const Locale('id','ID'),
                fallbackLocale: const Locale('en','US'),
                // fallbackLocale : use if the selected locale is not supported.
              );
          }
        }
        return MaterialApp(
          home: DialogComponent().onShowLoading(),
        );
      }
    );
  }
}