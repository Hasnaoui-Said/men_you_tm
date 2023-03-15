import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:men_you_tm/src/HomeAppState.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[50],
          primaryColor: Colors.deepOrange,
          primarySwatch: Colors.orange,
        ),
        home: const HomeAppState()
    );
  }
}