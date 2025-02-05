import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/car/abstract_car_repository/abstract_car_repository.dart';
import '../../../domain/repositories/car/car_repository_implementation/car_respository_implementation.dart';
import '../../../domain/repositories/company/abstract_company_repository/abstract_company_repository.dart';
import '../../../domain/repositories/company/company_repository_implementation/company_repository_implementation.dart';
import '../../../domain/repositories/fin/abstract_fin_repository/abstract_fin_repository.dart';
import '../../../domain/repositories/fin/fin_repository_implementation/fin_repository_implementation.dart';
import '../../../domain/repositories/radiator/abstract_radiator_repository/abstract_radiator_repository.dart';
import '../../../domain/repositories/radiator/radiator_repository_implementation/radiator_repository_implementation.dart';
import '../../../domain/repositories/rows/abstract_rows_repository/abstract_rows_repository.dart';
import '../../../domain/repositories/rows/rows_repository_implementation/rows_repository_implementation.dart';
import '../../../domain/repositories/sale/abstract_sale_repository/abstract_sale_repository.dart';
import '../../../domain/repositories/sale/sale_repository_implementation/sale_repository_implementation.dart';
import '../../../domain/repositories/stock/abstract_stock_repository/abstract_stock_repository.dart';
import '../../../domain/repositories/stock/stock_repository_implementation/stock_repository_implementation.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../widgets/spaces/space.dart';
import '../home/home_screen.dart';
import 'widgets/single_input_pin.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController pinController1 = TextEditingController();
  final TextEditingController pinController2 = TextEditingController();
  final TextEditingController pinController3 = TextEditingController();
  final TextEditingController pinController4 = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;
  @override
  void dispose() {
    super.dispose();
    pinController1.dispose();
    pinController2.dispose();
    pinController3.dispose();
    pinController4.dispose();
  }

  validatePin() {
    // if (pinController1.text.trim() +
    //         pinController2.text.trim() +
    //         pinController3.text.trim() +
    //         pinController4.text.trim() ==
    //     "0202") {
    AppRouter.push(
      MultiRepositoryProvider(providers: [
        RepositoryProvider<FinRepository>(
          create: (context) => FinRepositoryImplementation(firestoreInstance),
        ),
        RepositoryProvider<CarRepository>(
          create: (context) => CarRepositoryImplementation(firestoreInstance),
        ),
        RepositoryProvider<RowsRepository>(
          create: (context) => RowsRepositoryImplementation(firestoreInstance),
        ),
        RepositoryProvider<RadiatorRepository>(
          create: (context) =>
              RadiatorRepositoryImplementation(firestoreInstance),
        ),
        RepositoryProvider<CompanyRepository>(
          create: (context) =>
              CompanyRepositoryImplementation(firestoreInstance),
        ),
        RepositoryProvider<StockRepository>(
          create: (context) => StockRepositoryImplementation(firestoreInstance),
        ),
        RepositoryProvider<SaleRepository>(
          create: (context) => SaleRepositoryImplementation(firestoreInstance),
        ),
      ], child: HomeScreen()),
    );
    // } else {
    //   AppAlertUtil.showError(context, "Invalid pin");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Good To have you back",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          largeHeightSpace(),
          const Text("Please Authenticate yourself"),
          mediumHeightSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SingleInputPin(
                pinKey: Key("pin1"),
                pinController: pinController1,
              ),
              SingleInputPin(
                pinKey: Key("pin2"),
                pinController: pinController2,
              ),
              SingleInputPin(
                pinKey: Key("pin3"),
                pinController: pinController3,
              ),
              SingleInputPin(
                pinKey: Key("pin4"),
                pinController: pinController4,
              ),
            ],
          ),
          mediumHeightSpace(),
          ElevatedButton(
            onPressed: validatePin,
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
