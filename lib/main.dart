import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stock_management_application/config/app_themes.dart';
import 'firebase_options.dart';
import 'presentation/screen/authentication/authentication_screen.dart';
import 'presentation/screen/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock Management',
      theme: AppThemes.lightTheme,
      home: HomeScreen(),
    );
  }
}
