

import 'package:egu_industry/app/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotification {

  LocalNotification._();

  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static initialize() async{
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings("mipmap/ic_launcher");

    DarwinInitializationSettings initializationSettingsIOS =
    const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void requestPermission(){
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert:true,
      badge:true,
      sound:true,
    );
  }
  static Future<void> notify(String title, String body) async{
    const AndroidNotificationDetails androidPlatformChannelSpecifics=
    AndroidNotificationDetails('channelId - octosys', 'channelName - octosys',
        channelDescription: 'channel description',
        importance: Importance.max,
        priority: Priority.max,
        showWhen: true
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android : androidPlatformChannelSpecifics,
        iOS : DarwinNotificationDetails( badgeNumber: 5,)
    );

    await _flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: 'item x'
    );
  }
}

