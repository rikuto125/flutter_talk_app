import 'package:firebase_talk_app/firestore/room_firestore.dart';
import 'package:firebase_talk_app/firestore/user_firestore.dart';
import 'package:firebase_talk_app/pages/top_page.dart';
import 'package:firebase_talk_app/utils/shared_prefes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefs().setPrefsInstance();
  String? uid = SharedPrefs.fetchUid();
  if (uid == null) {
    await UserFirestore.createUser();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TopPage(),
    );
  }
}