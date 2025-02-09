import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stock_management_application/presentation/widgets/state_indicators/loading_indicator/loading_indicator.dart';
import '../../../domain/models/car.dart';
import '../../../domain/models/radiator_stock.dart';
import '../../../domain/models/sale.dart';
import '../../../domain/repositories/car/abstract_car_repository/abstract_car_repository.dart';
import '../../../domain/repositories/stock/abstract_stock_repository/abstract_stock_repository.dart';
import '../../../utilities/app_alerts/app_alerts.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../widgets/car_selection_tile_dialogue/car_selection_tile_dialogue.dart';
import '../../widgets/radiator_stock_selection_tile_dialogue/radiator_stock_selection_tile_dialogue.dart';
import '../car/cubit/car_cubit.dart';
import '../stock/cubit/stock_cubit.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTime? startDate;
  DateTime? endDate;
  Car? car;
  RadiatorStock? radiatorStock;
  bool showLoading = false;

  Future<List<Sale>> getSalesReport(DateTime? startDate, DateTime? endDate,
      String carId, String radiatorStockId) async {
    final firestoreInstance = FirebaseFirestore.instance;

    // Fetch all sales data (since Firestore doesn't support string date filtering)
    QuerySnapshot snapshot = await firestoreInstance.collection('sales').get();

    // Convert documents to Sale objects
    List<Sale> sales = snapshot.docs.map((doc) {
      return Sale.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
    if (startDate != null && endDate != null) {
      // Filter sales by date range locally
      sales = sales.where((sale) {
        final saleDate = sale.date; // Sale date as DateTime
        return saleDate.isAfter(startDate!.subtract(Duration(days: 1))) &&
            saleDate.isBefore(endDate!.add(Duration(days: 1)));
      }).toList();
    }
    // Further filter by car ID and radiator stock ID
    sales = sales.where((sale) {
      return sale.saleItems.any((item) =>
          item.car?.id == carId && item.radiator?.id == radiatorStockId);
    }).toList();

    return sales;
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != startDate)
      setState(() {
        startDate = picked;
      });
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != endDate)
      setState(() {
        endDate = picked;
      });
  }

  void _generateReport() async {
    setState(() {
      showLoading = true;
    });
    if (car == null) {
      AppAlertUtil.showError(context, "Please Select Car");
      // Show error message
      return;
    } else if (radiatorStock == null) {
      AppAlertUtil.showError(context, "Please Select Radiator");
      return;
    }

    List<Sale> sales =
        await getSalesReport(startDate, endDate, car!.id, radiatorStock!.id);

    int retailUnits = 0;
    int wholesaleUnits = 0;

    for (var sale in sales) {
      for (var item in sale.saleItems) {
        if (item.isRetail) {
          retailUnits += item.quantity;
        } else {
          wholesaleUnits += item.quantity;
        }
      }
    }

    // Display the results
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Sales Report'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Retail Units Sold: $retailUnits'),
              Text('Wholesale Units Sold: $wholesaleUnits'),
              Text("Currently Avaliable Stock : ${radiatorStock!.quantity}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  showLoading = false;
                });
                AppRouter.pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                    'Start Date:   ${startDate != null ? DateFormat('yyyy-MM-dd').format(startDate!) : 'Not selected'}'),
                IconButton(
                  icon: Icon(Icons.calendar_month),
                  onPressed: () => _selectStartDate(context),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                    'End Date:    ${endDate != null ? DateFormat('yyyy-MM-dd').format(endDate!) : 'Not selected'}'),
                IconButton(
                  icon: Icon(Icons.calendar_month),
                  onPressed: () => _selectEndDate(context),
                ),
              ],
            ),
            BlocProvider(
              create: (context) => CarCubit(
                carRepository: context.read<CarRepository>(),
              ),
              child: CarSelectionTileDialogue(
                selectedCar: car,
                assignSelectedCarFunction: (Car carSelected) {
                  setState(() {
                    car = carSelected;
                  });
                },
              ),
            ),
            BlocProvider(
              create: (context) => StockCubit(
                stockRepository: context.read<StockRepository>(),
              ),
              child: RadiatorStockSelectionTileDialogue(
                radiator: radiatorStock,
                car: car,
                assignSelectedRadiatorFunciton:
                    (RadiatorStock selectedRadiator) {
                  setState(() {
                    radiatorStock = selectedRadiator;
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: _generateReport,
              child: showLoading
                  ? FittedBox(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Text('Generate Report'),
            ),
          ],
        ),
      ),
    );
  }
}
