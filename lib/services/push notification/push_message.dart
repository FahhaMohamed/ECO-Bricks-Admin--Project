
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

void pushMessage (String token, String body, String title) async {

  try {

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String> {
        'Content-Type' : 'Application/json',
        'Authorization' : 'key=AAAA-Vup7DE:APA91bEhyW0X8nNFbKqd3DJnpKCiuINhUIgKCwOPX8AwOPAyuCQamaUGQSyJ2YsjdWasGOdpvUhQX_8DXOFDpN0E0Rpfu3Cj5TjM_vM72zZuoWafq1XHaNk7eFpmzrxsRIeUplP9vnfq',
      },
      body: jsonEncode(
          <String, dynamic> {

            'priority' : 'high',

            //this is for view the message on top of mobile and if press ,then move to specific page
            'data' : <String, dynamic> {
              'click_action' : 'FLUTTER_NOTIFICATION_CLICK',
              'status' : 'done',
              'body' : body,
              'title' :title,
            },

            'notification' : <String, dynamic> {
              'title' : title,
              'body' : body,
              'android_channel' : 'ecobricks',
            },

            'to' : token,
          }
      ),
    );
  } catch (e) {
    if (kDebugMode) {
      print('error push notification');
    }
  }
}