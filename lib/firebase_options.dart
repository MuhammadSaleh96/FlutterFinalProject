// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBq2zC2uHt35X7qChN097cERW4z6fVDELM',
    appId: '1:83924779633:web:2ab242b4c1fcb7b19ed1d0',
    messagingSenderId: '83924779633',
    projectId: 'tap-and-trip',
    authDomain: 'tap-and-trip.firebaseapp.com',
    databaseURL: 'https://tap-and-trip-default-rtdb.firebaseio.com',
    storageBucket: 'tap-and-trip.appspot.com',
    measurementId: 'G-JKP40JFJ4Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDsELNm4aIsSOj54HnPgkX6C2D4e2DQmFE',
    appId: '1:83924779633:android:0e99ed4cacf521e99ed1d0',
    messagingSenderId: '83924779633',
    projectId: 'tap-and-trip',
    databaseURL: 'https://tap-and-trip-default-rtdb.firebaseio.com',
    storageBucket: 'tap-and-trip.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAy5xiNqn12zP_kYGmhAZ_Eq7RfpV0FLes',
    appId: '1:83924779633:ios:3d231a31115a05289ed1d0',
    messagingSenderId: '83924779633',
    projectId: 'tap-and-trip',
    databaseURL: 'https://tap-and-trip-default-rtdb.firebaseio.com',
    storageBucket: 'tap-and-trip.appspot.com',
    iosBundleId: 'com.example.tapAndTrip',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAy5xiNqn12zP_kYGmhAZ_Eq7RfpV0FLes',
    appId: '1:83924779633:ios:3a1ec2a4da09f3529ed1d0',
    messagingSenderId: '83924779633',
    projectId: 'tap-and-trip',
    databaseURL: 'https://tap-and-trip-default-rtdb.firebaseio.com',
    storageBucket: 'tap-and-trip.appspot.com',
    iosBundleId: 'com.example.tapAndTrip.RunnerTests',
  );
}
