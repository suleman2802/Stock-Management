import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/app_themes.dart';
import 'firebase_options.dart';
import 'presentation/screen/authentication/authentication_screen.dart';
import 'presentation/screen/car/car_screen.dart';
import 'presentation/screen/fin/fin_screen.dart';
import 'presentation/screen/home/home_screen.dart';
import 'presentation/screen/purchase/purchase_screen.dart';
import 'presentation/screen/reports/reports_screen.dart';
import 'presentation/screen/rows/rows_screen.dart';
import 'presentation/screen/stock/stock_form_screen.dart';
import 'presentation/screen/stock/stock_screen.dart';
import 'utilities/app_routes/app_routes.dart';

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
      //  home: AuthenticationScreen(),
      home: HomeScreen(),
      routes: {
        homeScreen: (context) => HomeScreen(),
        authenticationScreen: (context) => AuthenticationScreen(),
        carScreen: (context) => CarScreen(),
        purchaseScreen: (context) => PurchaseScreen(),
        stockScreen: (context) => StockScreen(),
        rowScreen: (context) => RowScreen(),
        reportsScreen: (context) => ReportsScreen(),
        stockFormScreen: (context) => StockFormScreen(),
        finScreen: (context) => FinScreen(),
      },
    );
  }
}
