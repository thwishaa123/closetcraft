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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD9wz3nbJb0QdbU-ln9wmiuYUQl_5jDWwo',
    appId: '1:719799195731:web:a4f4f715c3653b51780ea6',
    messagingSenderId: '719799195731',
    projectId: 'closetcraft-34c9f',
    authDomain: 'closetcraft-34c9f.firebaseapp.com',
    storageBucket: 'closetcraft-34c9f.firebasestorage.app',
    measurementId: 'G-H559PT385G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7TkE0JtnNJ8b3Z6EB3rnYQpS9shC2iRM',
    appId: '1:719799195731:android:0b9e8519eea5a2da780ea6',
    messagingSenderId: '719799195731',
    projectId: 'closetcraft-34c9f',
    storageBucket: 'closetcraft-34c9f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnfyXyT6YyqjUbAouPvYMS3ObUwTrzYv8',
    appId: '1:719799195731:ios:c698507e4727793f780ea6',
    messagingSenderId: '719799195731',
    projectId: 'closetcraft-34c9f',
    storageBucket: 'closetcraft-34c9f.firebasestorage.app',
    iosBundleId: 'com.revastra.app',
  );

}