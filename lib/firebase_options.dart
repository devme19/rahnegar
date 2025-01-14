// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDIiQENo2TbULu8e68oPzxbq32rldK1ZX0',
    appId: '1:566372018642:web:137d41b8589212ec44c00b',
    messagingSenderId: '566372018642',
    projectId: 'gadget-negarkhodro',
    authDomain: 'gadget-negarkhodro.firebaseapp.com',
    storageBucket: 'gadget-negarkhodro.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDHnmcwgJ9dAl_hzFoYCxRg0gm2VvgvHxA',
    appId: '1:566372018642:android:049254af16b1111a44c00b',
    messagingSenderId: '566372018642',
    projectId: 'gadget-negarkhodro',
    storageBucket: 'gadget-negarkhodro.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1rW_LroOymeledopttAraT6kyeYqkLfA',
    appId: '1:566372018642:ios:d8b4685a01058f3d44c00b',
    messagingSenderId: '566372018642',
    projectId: 'gadget-negarkhodro',
    storageBucket: 'gadget-negarkhodro.appspot.com',
    iosBundleId: 'com.negarkhodro.rahnegar',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB1rW_LroOymeledopttAraT6kyeYqkLfA',
    appId: '1:566372018642:ios:d8b4685a01058f3d44c00b',
    messagingSenderId: '566372018642',
    projectId: 'gadget-negarkhodro',
    storageBucket: 'gadget-negarkhodro.appspot.com',
    iosBundleId: 'com.negarkhodro.rahnegar',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDIiQENo2TbULu8e68oPzxbq32rldK1ZX0',
    appId: '1:566372018642:web:3887dcf42bd5de7844c00b',
    messagingSenderId: '566372018642',
    projectId: 'gadget-negarkhodro',
    authDomain: 'gadget-negarkhodro.firebaseapp.com',
    storageBucket: 'gadget-negarkhodro.appspot.com',
  );
}
