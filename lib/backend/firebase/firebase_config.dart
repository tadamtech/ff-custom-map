import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCCaQgJe_ABgOVSGO4x29xpPon38SZ4ZQU",
            authDomain: "custommap-1eef6.firebaseapp.com",
            projectId: "custommap-1eef6",
            storageBucket: "custommap-1eef6.appspot.com",
            messagingSenderId: "77111442362",
            appId: "1:77111442362:web:b82f4c7091b9bb97d8fb83"));
  } else {
    await Firebase.initializeApp();
  }
}
