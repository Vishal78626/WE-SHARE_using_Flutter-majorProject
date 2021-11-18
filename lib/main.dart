import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:major_project/screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email And Password Login',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primaryColor: Colors.orange, primarySwatch: Colors.orange),
      home: LoginScreen(),
    );
  }
}
