import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rahnegar/common/client/client.dart';
import 'package:rahnegar/features/setting/presentation/manager/bloc/blocs/locale_cubit.dart';
import 'package:rahnegar/features/setting/presentation/manager/getx/pages/setting_page/controller/setting_controller.dart';
import 'package:rahnegar/firebase_options.dart';
import 'package:rahnegar/locator.dart';

import 'package:rahnegar/main_binding/main_binding.dart';
import 'package:rahnegar/routes/RouteGenerator.dart';

import 'package:rahnegar/routes/app_routes.dart';
import 'package:rahnegar/routes/route_names.dart';
import 'package:rahnegar/theme/app_themes.dart';
import 'package:rahnegar/theme/bloc/theme_cubit.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:rahnegar/utils/messages/messages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'common/base_data_sources/base_local_data_source.dart';

void main() async {
  // Bloc.observer = AppBlocObserver();
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // FlutterNativeSplash.remove();
  initLocator();
  await ScreenUtil.ensureScreenSize();
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
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
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print(e);
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  setUpFcm();
  // MainBinding().dependencies();
  Client().init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
        MultiBlocProvider(providers: [
          BlocProvider.value(
            value: locator<ThemeCubit>(),
          ),
          BlocProvider.value(
            value: locator<LocaleCubit>(),
          ),

        ], child: ScreenUtilInit(
          minTextAdapt: true,
          child: MyApp(),)
          // BlocProvider.value(
          //   value:  locator<ThemeCubit>(),
          //   child: ScreenUtilInit(
          //     minTextAdapt: true,
          //     child: MyApp(),
          //   ),
          // )
        ));
  });
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("-------------------background--------------------------");
  String title = '',
      content = '';
  print(message.data);
  print(message.notification);
  // if(message.notification!=null){
  //   print(message.notification!.title!);
  //   title = message.notification!.title!;
  //   content = message.notification!.body!;
  // }
  // else{
  //   Map<String, dynamic> decodedJson = jsonDecode(message.data['t1']);
  //   title = decodedJson['title'] ?? '';
  //   content = decodedJson['content'] ?? '';
  // }
  // AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: 10,
  //       channelKey: 'basic_channel',
  //       actionType: ActionType.Default,
  //       title: title,
  //       body: content,
  //     )
  // );oauth
  // Decode the JSON string

}

setUpFcm() {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  print(Firebase.apps.first.name + '------------------');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // print('On Message title: ${message.notification!.title}');
    // print('On Message body: ${message.notification!.body}');
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
    print('FCM Tokenszsz: $token');
    if (token != null) {
      BaseLocalDataSourceImpl baseLocalDataSourceImpl = BaseLocalDataSourceImpl();
      baseLocalDataSourceImpl.saveFcmToken(token);
    }
  });
}


class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, localeState) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (BuildContext context, ThemeState themeState) {
              return
                MaterialApp(
                  title: 'RahNegar',
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  // locale: const Locale("fa", "IR"),
                  supportedLocales: const [
                    Locale("fa", "IR"),
                    Locale("en", "US"),
                  ],
                  locale: localeState.locale,
                  darkTheme: AppThemes.dark(localeState.locale.languageCode),
                  theme: AppThemes.light(localeState.locale.languageCode),
                  themeMode: themeState.themeMode,
                  onGenerateRoute: RouteGenerator.generateRoute,
                );
            },

          );
        },
      );
  }

}

// class MyApp extends StatelessWidget {
//   MyApp({super.key});
//   SettingController settingController = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return
//       Obx(()=>GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         getPages: App.pages,
//         // translations: Messages(),
//         localizationsDelegates: const [
//           AppLocalizations.delegate,
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate
//         ],
//         supportedLocales: const [
//           Locale('fa'),
//           Locale('en')
//         ],
//         initialRoute: RouteNames.splashPage,
//         // initialRoute: RouteNames.userInfoPage,
//         // initialBinding: MainBinding(),
//         locale: settingController.selectedLocale.value,
//         title: 'Flutter Demo',
//         theme: AppThemes.light,  // Use your custom light theme
//         darkTheme: AppThemes.dark,  // Use your custom dark theme
//         themeMode: settingController.themeMode.value,  // Get the current theme mode
//       ));
//   }
//
// }


