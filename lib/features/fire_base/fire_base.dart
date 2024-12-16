import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rahnegar/common/base_data_sources/base_local_data_source.dart';
import 'package:rahnegar/common/base_data_sources/base_remote_data_source.dart';

import '../../firebase_options.dart';

class FireBase{

  init()async{
    try{
      AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
          null,
          [
            NotificationChannel(
                channelGroupKey: 'basic_channel_group',
                channelKey: 'basic_channel',
                channelName: 'Basic notifications',
                channelDescription: 'Notification channel for basic tests',
                defaultColor: Color(0xFF9D50DD),
                ledColor: Colors.white)
          ],
          // Channel groups are only visual and are not required
          channelGroups: [
            NotificationChannelGroup(
                channelGroupKey: 'basic_channel_group',
                channelGroupName: 'Basic group')
          ],
          debug: true
      );
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      _setUpFcm();
    }catch(e){
      print(e);
    }
  }
  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print("-------------------background--------------------------");
  }
  _setUpFcm(){
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    print(Firebase.apps.first.name+'------------------');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      print(message.notification!.title);
      print("onMessage.listen-------");
      AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            actionType: ActionType.Default,
            title: message.notification!.title!,
            body: message.notification!.body,
          )
      );
      // Handle the message
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('On Message Opened App: ${message.messageId}');
      // Handle the message
    });

    firebaseMessaging.getToken().then((String? token) {
      // if(token!=null){
      //   BaseLocalDataSourceImpl baseLocalDataSourceImpl = BaseLocalDataSourceImpl();
      //   baseLocalDataSourceImpl.saveFcmToken(token);
      // }
    });
  }
}