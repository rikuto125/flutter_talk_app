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
    apiKey: 'AIzaSyC1Rc47snDN1M0IY2zmissBdIady-uyzXc',
    appId: '1:31764871501:web:4786b510b96f96b5745f04',
    messagingSenderId: '31764871501',
    projectId: 'flutter-talk-app-facd8',
    authDomain: 'flutter-talk-app-facd8.firebaseapp.com',
    storageBucket: 'flutter-talk-app-facd8.appspot.com',
    measurementId: 'G-HKRFK34DNC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWgPUmPZfNnti4lVwKi7gwMhXJskDCEto',
    appId: '1:31764871501:android:84618605e2778b8b745f04',
    messagingSenderId: '31764871501',
    projectId: 'flutter-talk-app-facd8',
    storageBucket: 'flutter-talk-app-facd8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJJyD1pm-vJkDHC9ZaTl3M_XJVfB5pXs0',
    appId: '1:31764871501:ios:0a07418ff801f1d8745f04',
    messagingSenderId: '31764871501',
    projectId: 'flutter-talk-app-facd8',
    storageBucket: 'flutter-talk-app-facd8.appspot.com',
    iosClientId: '31764871501-ssa62a7hjkj3htoojp576l08bs8m4dgs.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseTalkApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJJyD1pm-vJkDHC9ZaTl3M_XJVfB5pXs0',
    appId: '1:31764871501:ios:0a07418ff801f1d8745f04',
    messagingSenderId: '31764871501',
    projectId: 'flutter-talk-app-facd8',
    storageBucket: 'flutter-talk-app-facd8.appspot.com',
    iosClientId: '31764871501-ssa62a7hjkj3htoojp576l08bs8m4dgs.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseTalkApp',
  );
}
