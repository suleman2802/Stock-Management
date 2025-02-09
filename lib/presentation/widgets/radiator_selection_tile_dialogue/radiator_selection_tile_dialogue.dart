import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management_application/domain/repositories/radiator/abstract_radiator_repository/abstract_radiator_repository.dart';
import 'package:stock_management_application/presentation/screen/radiator/cubit/radiator_cubit.dart';

import '../../../config/dimensions.dart';
import '../../../domain/models/car.dart';
import '../../../domain/models/radiator.dart';
import '../../../domain/repositories/car/abstract_car_repository/abstract_car_repository.dart';
import '../../../domain/repositories/fin/abstract_fin_repository/abstract_fin_repository.dart';
import '../../../domain/repositories/rows/abstract_rows_repository/abstract_rows_repository.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../screen/radiator/widgets/radiator_dialogue.dart';
import '../spaces/space.dart';
import '../state_indicators/error_text/error_text.dart';
import '../state_indicators/loading_indicator/loading_indicator.dart';
import '../state_indicators/no_data_avaliable_text/no_data_avaliable_text.dart';
import '../styling/bordered_container.dart';
import '../styling/bottom_sheet_header.dart';
import '../styling/round_icon_button.dart';

class RadiatorSelectionTileDialogue extends StatefulWidget {
  RadiatorSelectionTileDialogue({
    super.key,
    this.selectedRadiator,
    required this.assignSelectedRadiatorFunciton,
    this.selectedCar,
    required this.isAluminium,
  });
  Radiator? selectedRadiator;
  Car? selectedCar;
  final Function assignSelectedRadiatorFunciton;
  bool isAluminium;

  @override
  State<RadiatorSelectionTileDialogue> createState() =>
      _RadiatorSelectionTileDialogueState();
}

class _RadiatorSelectionTileDialogueState
    extends State<RadiatorSelectionTileDialogue> {
  void selectRadiator(Radiator selectedRadiator) {
    widget.assignSelectedRadiatorFunciton(selectedRadiator);
  }

  @override
  Widget build(BuildContext context) {
    return widget.selectedRadiator != null
        ? Card(
            child: ListTile(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (ctx) => MultiRepositoryProvider(
                    providers: [
                      RepositoryProvider.value(
                        value: context.read<RadiatorRepository>(),
                      ),
                      RepositoryProvider.value(
                        value: context.read<CarRepository>(),
                      ),
                      RepositoryProvider.value(
                        value: context.read<FinRepository>(),
                      ),
                      RepositoryProvider.value(
                        value: context.read<RowsRepository>(),
                      ),
                    ],
                    child: BlocProvider.value(
                      value: context.read<RadiatorCubit>(),
                      child: RadiatorListBottomSheet(
                        isAluminium: widget.isAluminium,
                        selectedCar: widget.selectedCar,
                        selectRadiatorFunction: selectRadiator,
                      ),
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  widget.selectedRadiator!.car.carCompany
                      .substring(0, 1)
                      .toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(widget.selectedRadiator!.car.carName),
              subtitle: Text(widget.selectedRadiator!.size),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Rows : ${widget.selectedRadiator!.rows!.noOfRows}"),
                  Text("Fin : ${widget.selectedRadiator!.fin!.finSize}"),
                ],
              ),
            ),
          )
        : Container(
            margin: EdgeInsets.only(bottom: 3),
            child: BorderedContainer(
              child: Center(
                child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (ctx) => MultiRepositoryProvider(
                        providers: [
                          RepositoryProvider.value(
                            value: context.read<RadiatorRepository>(),
                          ),
                          RepositoryProvider.value(
                            value: context.read<CarRepository>(),
                          ),
                          RepositoryProvider.value(
                            value: context.read<FinRepository>(),
                          ),
                          RepositoryProvider.value(
                            value: context.read<RowsRepository>(),
                          ),
                        ],
                        child: BlocProvider.value(
                          value: context.read<RadiatorCubit>(),
                          child: RadiatorListBottomSheet(
                            isAluminium: widget.isAluminium,
                            selectRadiatorFunction: selectRadiator,
                            selectedCar: widget.selectedCar,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text("Select Radiator"),
                ),
              ),
            ),
          );
  }
}

class RadiatorListBottomSheet extends StatefulWidget {
  RadiatorListBottomSheet(
      {super.key,
      required this.selectRadiatorFunction,
      this.selectedCar,
      required this.isAluminium});
  final Function selectRadiatorFunction;
  Car? selectedCar;
  bool isAluminium;

  @override
  State<RadiatorListBottomSheet> createState() =>
      _RadiatorListBottomSheetState();
}

class _RadiatorListBottomSheetState extends State<RadiatorListBottomSheet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.selectedCar != null) {
      context
          .read<RadiatorCubit>()
          .fetchAllRadiatorsByCarId(widget.selectedCar!.id, widget.isAluminium);
    } else {
      context.read<RadiatorCubit>().fetchAllRadiators(widget.isAluminium);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions(context);
    return SizedBox(
      height: dimensions.height80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHeader(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Radiator",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  Row(
                    children: [
                      RoundIconButton(
                        iconData: Icons.add,
                        onPress: () => showDialog(
                          context: context,
                          builder: (ctx) => MultiRepositoryProvider(
                            providers: [
                              RepositoryProvider.value(
                                value: context.read<RadiatorRepository>(),
                              ),
                              RepositoryProvider.value(
                                value: context.read<CarRepository>(),
                              ),
                              RepositoryProvider.value(
                                value: context.read<FinRepository>(),
                              ),
                              RepositoryProvider.value(
                                value: context.read<RowsRepository>(),
                              ),
                            ],
                            child: BlocProvider.value(
                              value: context.read<RadiatorCubit>(),
                              child: RadiatorDialogue(
                                isAluminium: widget.isAluminium,
                                canEdit: widget.selectedCar == null,
                                radiator: Radiator(
                                    size: "",
                                    carFuelType: CarFuelType.petrol,
                                    carAutomation: CarAutomation.manual,
                                    fromYear: DateTime.now().year,
                                    toYear: DateTime.now().year,
                                    rows: null,
                                    car: widget.selectedCar!,
                                    fin: null),
                              ),
                            ),
                          ),
                        ),
                      ),
                      smallWidthSpace(),
                      RoundIconButton(
                        iconData: Icons.close,
                        onPress: () => AppRouter.pop(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<RadiatorCubit, RadiatorState>(
              builder: (context, state) {
                if (state is RadiatorLoadingState) {
                  return LoadingIndicator();
                } else if (state is RadiatorErrorState) {
                  return ErrorText(
                    errorMessage: state.errorMessage,
                  );
                } else if (state is RadiatorLoadedState) {
                  return state.radiatorList.isEmpty
                      ? NoDataAvaliableText()
                      : ListView.builder(
                          itemCount: state.radiatorList.length,
                          itemBuilder: (context, index) => Card(
                            child: ListTile(
                              onTap: () {
                                widget.selectRadiatorFunction(
                                    state.radiatorList[index]);
                                AppRouter.pop();
                              },
                              title: Text(
                                state.radiatorList[index].car.carName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(state.radiatorList[index].size),
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  state.radiatorList[index].carAutomation.name
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                } else {
                  return NoDataAvaliableText();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
