import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pages/homepage.dart';
import 'states/cardState.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
  loadFirebase();
}

loadFirebase() async {
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("internet connection problem");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CardState()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ));
  }
}
