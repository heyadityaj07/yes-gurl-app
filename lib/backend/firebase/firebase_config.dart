import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCF-lNHH8raQZHWgzuHmYt49cS-9z2CAWE",
            authDomain: "yes-gurl-app.firebaseapp.com",
            projectId: "yes-gurl-app",
            storageBucket: "yes-gurl-app.appspot.com",
            messagingSenderId: "192336393032",
            appId: "1:192336393032:web:1c311196390dc84b8f797d",
            measurementId: "G-BV3E3TJDJQ"));
  } else {
    await Firebase.initializeApp();
  }
}
