import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/app_themes.dart';
import 'firebase_options.dart';
import 'presentation/screen/authentication/authentication_screen.dart';
import 'utilities/app_routes/app_router.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppRouter.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Stock Management',
      theme: AppThemes.lightTheme,
        home: AuthenticationScreen(),

      // home: RepositoryProvider<FinRepository>(
      //     create: (context) => FinRepositoryImplementation(),
      //     child: AuthenticationScreen()),
      // routes: {
      //   homeScreen: (context) => HomeScreen(),
      //   authenticationScreen: (context) => AuthenticationScreen(),
      //   carScreen: (context) => CarScreen(),
      //   saleScreen: (context) => SaleScreen(),
      //   stockScreen: (context) => StockScreen(),
      //   rowScreen: (context) => RowScreen(),
      //   reportsScreen: (context) => ReportsScreen(),
      //   stockFormScreen: (context) => StockFormScreen(),
      //   finScreen: (context) => FinScreen(),
      //   radiatorScreen: (context) => RadiatorScreen(),
      //   radiatorFormScreen: (context) => RadiatorFormScreen(),
      //   saleFormScreen: (context) => SaleFormScreen(),
      // },
    );
  }
}
