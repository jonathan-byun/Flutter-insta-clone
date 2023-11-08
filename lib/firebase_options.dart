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
    apiKey: 'AIzaSyBHPiDHmnhT8SddB1_9UW_UUI2ysskLBEU',
    appId: '1:65364089060:web:f61ccb467a98447a26f4f1',
    messagingSenderId: '65364089060',
    projectId: 'instaclone-1fad2',
    authDomain: 'instaclone-1fad2.firebaseapp.com',
    storageBucket: 'instaclone-1fad2.appspot.com',
    measurementId: 'G-B0DNM8FLRJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFJjk8TJS7WGM1Wz7ouBxdNHGK-dntcas',
    appId: '1:65364089060:android:6d0104e671dfce4826f4f1',
    messagingSenderId: '65364089060',
    projectId: 'instaclone-1fad2',
    storageBucket: 'instaclone-1fad2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADB8ZTv_j-ATm3Pg70BefVyq1kLXgAf-s',
    appId: '1:65364089060:ios:ebc106a9f2d3cf1a26f4f1',
    messagingSenderId: '65364089060',
    projectId: 'instaclone-1fad2',
    storageBucket: 'instaclone-1fad2.appspot.com',
    iosBundleId: 'com.example.flutter1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyADB8ZTv_j-ATm3Pg70BefVyq1kLXgAf-s',
    appId: '1:65364089060:ios:a83e6b75f7ee5f9726f4f1',
    messagingSenderId: '65364089060',
    projectId: 'instaclone-1fad2',
    storageBucket: 'instaclone-1fad2.appspot.com',
    iosBundleId: 'com.example.flutter1.RunnerTests',
  );
}
