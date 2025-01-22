import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/models/car.dart';
import '../../../../domain/models/fin.dart';
import '../../../../domain/models/radiator.dart';
import '../../../../domain/models/rows.dart';
import '../../../../domain/repositories/car/abstract_car_repository/abstract_car_repository.dart';
import '../../../../domain/repositories/fin/abstract_fin_repository/abstract_fin_repository.dart';
import '../../../../domain/repositories/rows/abstract_rows_repository/abstract_rows_repository.dart';
import '../../../../utilities/app_alerts/app_alerts.dart';
import '../../../../utilities/app_routes/app_router.dart';
import '../../../widgets/car_selection_tile_dialogue/car_selection_tile_dialogue.dart';
import '../../../widgets/fin_selection_tile_dialogue/fin_selection_tile_dialogue.dart';
import '../../../widgets/input_feilds/number_input_field.dart';
import '../../../widgets/input_feilds/text_input_field.dart';
import '../../../widgets/row_selection_tile_dialogue/row_selection_tile_dialogue.dart';
import '../../../widgets/spaces/space.dart';
import '../../../widgets/state_indicators/general_alert/general_alert.dart';
import '../../car/cubit/car_cubit.dart';
import '../../fin/cubit/fin_cubit.dart';
import '../../rows/cubit/rows_cubit.dart';
import '../cubit/radiator_cubit.dart';

class RadiatorDialogue extends StatefulWidget {
  const RadiatorDialogue({super.key, this.radiator});
  final Radiator? radiator;

  @override
  State<RadiatorDialogue> createState() => _RadiatorDialogueState();
}

class _RadiatorDialogueState extends State<RadiatorDialogue> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CarFuelType _selectedFuelType = CarFuelType.petrol;
  CarAutomation _selectedCarAutomationType = CarAutomation.automatic;

  final TextEditingController sizeController = TextEditingController();
  final TextEditingController fromYearController = TextEditingController();
  final TextEditingController toYearController = TextEditingController();
  Rows? _selectedRows;
  Fin? _selectedFin;
  Car? _selectedCar;

  @override
  void initState() {
    super.initState();
    if (widget.radiator != null) {
      sizeController.text = widget.radiator!.size;
      fromYearController.text = widget.radiator!.fromYear.toString();
      toYearController.text = widget.radiator!.toYear.toString();
      _selectedFuelType = widget.radiator!.carFuelType;
      _selectedCarAutomationType = widget.radiator!.carAutomation;
      _selectedCar = widget.radiator!.car;
      _selectedRows = widget.radiator!.rows;
      _selectedFin = widget.radiator!.fin;
    }
  }

  @override
  void dispose() {
    super.dispose();
    sizeController.dispose();
    fromYearController.dispose();
    toYearController.dispose();
  }

  assignSelectedCar(Car car) {
    // setState(() {
    _selectedCar = car;
    // });
  }

  assignSelectedRows(Rows rows) {
    // setState(() {
    _selectedRows = rows;
    // });
  }

  assignSelectedFin(Fin fin) {
    // setState(() {
    _selectedFin = fin;
    // });
  }

  Future<void> submitRadiatorForm() async {
    try {
      if (formKey.currentState?.validate() ??
          false ||
              (_selectedCar != null &&
                  _selectedRows != null &&
                  _selectedFin != null)) {
        // Save functionality here
        if (widget.radiator == null) {
          //? save car here
          final isAddedSuccessfully =
              await context.read<RadiatorCubit>().addNewRadiator(
                    Radiator(
                        size: sizeController.text.trim(),
                        carFuelType: _selectedFuelType,
                        carAutomation: _selectedCarAutomationType,
                        fromYear: int.parse(fromYearController.text.trim()),
                        toYear: int.parse(toYearController.text.trim()),
                        rows: _selectedRows!,
                        car: _selectedCar!,
                        fin: _selectedFin!),
                  );

          if (mounted) {
            generalAlert(
              context: context,
              isSuccessful: isAddedSuccessfully,
              tile: "Radiator",
              type: AlertType.added,
            );
          }
        } else {
          //? edit car
          final isUpdatedSuccessfully =
              await context.read<RadiatorCubit>().updateRadiator(
                    Radiator(
                        id: widget.radiator!.id,
                        size: sizeController.text.trim(),
                        carFuelType: _selectedFuelType,
                        carAutomation: _selectedCarAutomationType,
                        fromYear: int.parse(fromYearController.text.trim()),
                        toYear: int.parse(toYearController.text.trim()),
                        rows: _selectedRows!,
                        car: _selectedCar!,
                        fin: _selectedFin!),
                  );
          if (mounted) {
            generalAlert(
              context: context,
              isSuccessful: isUpdatedSuccessfully,
              tile: "Radiator",
              type: AlertType.updated,
            );
          }
        }
        AppRouter.pop();
      } else {
        //? all feilds are not provided
        AppAlertUtil.showError(context, "All Feilds are required");
      }
    } catch (error) {
      log("Unable to add Radiator : $error");

      AppAlertUtil.showError(context, "Error : $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        ElevatedButton(
          onPressed: () => AppRouter.pop(),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: submitRadiatorForm,
          child: Text(widget.radiator != null ? "Edit" : "Save"),
        ),
      ],
      title: Text(
        "Radiator Details",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                BlocProvider(
                  create: (context) => CarCubit(
                    carRepository: context.read<CarRepository>(),
                  ),
                  child: CarSelectionTileDialogue(
                    selectedCar: _selectedCar,
                    assignSelectedCarFunction: assignSelectedCar,
                  ),
                ),
                BlocProvider(
                  create: (context) => RowsCubit(
                    rowsRepository: context.read<RowsRepository>(),
                  ),
                  child: RowSelectionTileDialogue(
                    selectedRows: _selectedRows,
                    assignSelectedRowsFunciton: assignSelectedRows,
                  ),
                ),
                BlocProvider(
                  create: (context) =>
                      FinCubit(finRepository: context.read<FinRepository>()),
                  child: FinSelectionTileDialogue(
                    selectedFin: _selectedFin,
                    assignSelectedFinFunction: assignSelectedFin,
                  ),
                ),
                smallestHeightSpace(),
                TextInputField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter radiator size';
                    }
                    return null;
                  },
                  controller: sizeController,
                  label: "Enter Radiator Size",
                ),
                NumberInputField(
                  controller: fromYearController,
                  label: "Enter From Year",
                ),
                NumberInputField(
                  controller: toYearController,
                  label: "Enter To Year",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Fuel Type",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    smallWidthSpace(),
                    Expanded(
                      child: DropdownButton<CarFuelType>(
                        hint: Text('Select Fuel Type'),
                        value: _selectedFuelType,
                        isExpanded: true,
                        onChanged: (CarFuelType? newValue) {
                          setState(() {
                            _selectedFuelType = newValue!;
                          });
                        },
                        items: CarFuelType.values.map((CarFuelType fuelType) {
                          return DropdownMenuItem<CarFuelType>(
                            value: fuelType,
                            child: Text(
                              fuelType.toString().split('.').last,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Automation Type",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    smallWidthSpace(),
                    Expanded(
                      child: DropdownButton<CarAutomation>(
                        hint: Text('Select Car Automation Type'),
                        value: _selectedCarAutomationType,

                        isExpanded:
                            true, // This ensures the dropdown takes up the full width of its container
                        onChanged: (CarAutomation? newValue) {
                          setState(() {
                            _selectedCarAutomationType = newValue!;
                          });
                        },
                        items: CarAutomation.values
                            .map((CarAutomation carAutomationType) {
                          return DropdownMenuItem<CarAutomation>(
                            value: carAutomationType,
                            child: Text(
                              carAutomationType.toString().split('.').last,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
