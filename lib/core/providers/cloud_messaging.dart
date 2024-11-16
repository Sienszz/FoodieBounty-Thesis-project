import 'dart:io';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:developer' as devtools show log;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:projek_skripsi/utils/routes.dart';

Future<void> backgroundhandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification?.title ?? "");
}

class FirebaseMessagingAPI{ 
  static String fcmToken = "";

  Future<void> initialized() async {
    if (Platform.isAndroid) {
      NotificationHelper.initialized();
    } else if (Platform.isIOS) {
    }
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(backgroundhandler);
    // getDeviceTokenToSendNotification();

    //If App is Terminated state & used click notification
    FirebaseMessaging.instance.getInitialMessage().then((message){
      print("FirebaseMessaging.instance.getIntialMessage");
      if(message != null) {
        print("New Notification");
      }
    });
    if (Platform.isAndroid) {
      FirebaseMessaging.onMessage.listen((message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print(message.data);

          NotificationHelper.displayNotification(message);
        }
      });
    } else if (Platform.isIOS) {
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        String? route = message.data['route'];

        // Navigate to the desired screen based on the route information
        if (route != null) {
          // Navigate to the specified route
          Get.toNamed(route);
        }
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          // print(message.data);
        }
      });
    }



    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );

  }

  Future<bool> sendPushMessage({
    required String recipientToken,
    required String title,
    required String body,
    required String route,
  }) async {
    final jsonCredentials = await rootBundle
        .loadString('assets/data/9bfc6-1dc8c61afe93.json');
    final creds = auth.ServiceAccountCredentials.fromJson(jsonCredentials);
    
    final client = await auth.clientViaServiceAccount(
      creds,
      ['https://www.googleapis.com/auth/cloud-platform'],
    );
    
    final notificationData = {
      'message': {
        'token': recipientToken,
        'notification': {
          'title': title,
          'body': body,
        },
        'data': {
          'route': route, // Additional data to specify the route
        },           
      },
    };

  //   final notificationData = {
  //   'message': {
  //     'token': recipientToken,
  //     'notification': {
  //       'title': title,
  //       'body': body,
  //       'sound': 'default', // Use a default sound if none specified
  //     },
  //     'android': {
  //       'notification': {
  //         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //       },
  //     },
  //     'apns': {
  //       'payload': {
  //         'aps': {
  //           'category': 'FLUTTER_NOTIFICATION_CLICK',
  //           // 'sound': sound ?? 'default',
  //           'sound': 'default',
  //         },
  //       },
  //     },
  //     'data': {
  //       // Add any specific data you want to process within your app upon notification click
  //       'navigate_to': AppRoutes.sellerdashboard,
  //     },
  //   },
  // };
    
    const String senderId = '693044577668';
    final response = await client.post(
      Uri.parse('https://fcm.googleapis.com/v1/projects/$senderId/messages:send'),
      headers: {
        'content-type': 'application/json',
      },
      body: jsonEncode(notificationData),
    );
    
    client.close();
    if (response.statusCode == 200) {
      return true; // Success!
    }

    devtools.log(
        'Notification Sending Error Response status: ${response.statusCode}');
    devtools.log('Notification Response body: ${response.body}');
    return false;
  }

  static Future<String> getDeviceTokenToSendNotification() async {
    fcmToken = (await FirebaseMessaging.instance.getToken()).toString();
    print("Fcm token: $fcmToken");

    return fcmToken;
  }

}

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialized() {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: initializationSettingsAndroid),
      onDidReceiveNotificationResponse: (details) {
        Get.toNamed(AppRoutes.sellerdashboard);
      },
      onDidReceiveBackgroundNotificationResponse: localBackgroundHandler
    );
  }

  static void displayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "push_notification_demo",
          "push_notification_demo_channel",
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        )
      );

      await flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      print(e);
    }
  }


}


Future<void> localBackgroundHandler(NotificationResponse data) async {
  print(data.toString());
}