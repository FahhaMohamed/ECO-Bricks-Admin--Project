
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_bricks/all_screens/orders_screen/order_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class NotifyService {

  static void getPermission () async {

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(

      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,

    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {

      print('User granted permission');

    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {

      print('User granted provisional permission');

    } else {
      print('User has not accepted permission');
    }
  }

  static void getToken () async {

    await FirebaseMessaging.instance.getToken().then((token) {

      print('My token : $token');

      saveToken(token!);

    });
  }

  static void saveToken (String token) async {

    await FirebaseFirestore.instance.collection('Users').doc('user').set({
      'token' : token,
    });
  }

  static info (BuildContext context) {

    var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialize = const IOSInitializationSettings();

    var initializationSetting = InitializationSettings(
      android: androidInitialize,
      iOS: iosInitialize,
    );

    flutterLocalNotificationsPlugin.initialize(

      initializationSetting,
      onSelectNotification: (String? payload) async {

        try{

          if(payload != null && payload.isNotEmpty) {

            print(payload);

            Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderScreen()));

          }
        } catch (e) {
          print(e);
        }
        return;
      }
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {

      print('........onMessage........');
      print('onMessage : ${message.notification?.title} / ${message.notification?.body}');

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(

        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,

      );

      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(

        'ecobricks',
        'ecobricks',
        'New message',
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        playSound: true,
        priority: Priority.high,

      );

      NotificationDetails plateformChannelSpecific = NotificationDetails(
        android: androidNotificationDetails,
        iOS: const IOSNotificationDetails(),
      );

      await flutterLocalNotificationsPlugin.show(

        0,
        message.notification?.title,
        message.notification?.body,
        plateformChannelSpecific,
        payload: message.data['title'],

      );


    });

  }
}