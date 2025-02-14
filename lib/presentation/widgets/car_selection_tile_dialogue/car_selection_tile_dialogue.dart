import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management_application/utilities/app_alerts/app_alerts.dart';
import '../../../config/dimensions.dart';
import '../../../domain/models/car.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../screen/car/cubit/car_cubit.dart';
import '../../screen/car/widgets/car_dialogue.dart';
import '../spaces/space.dart';
import '../state_indicators/error_text/error_text.dart';
import '../state_indicators/loading_indicator/loading_indicator.dart';
import '../state_indicators/no_data_avaliable_text/no_data_avaliable_text.dart';
import '../styling/bordered_container.dart';
import '../styling/bottom_sheet_header.dart';
import '../styling/round_icon_button.dart';

class CarSelectionTileDialogue extends StatefulWidget {
  CarSelectionTileDialogue(
      {super.key,
      this.selectedCar,
      required this.assignSelectedCarFunction,
      this.canEdit = true,
      required this.isAluminium});
  Car? selectedCar;
  final Function assignSelectedCarFunction;
  final bool canEdit;
  bool isAluminium;
  @override
  State<CarSelectionTileDialogue> createState() =>
      _CarSelectionTileDialogueState();
}

class _CarSelectionTileDialogueState extends State<CarSelectionTileDialogue> {
  void selectCar(Car selectedCar) {
    widget.selectedCar = selectedCar;
    widget.assignSelectedCarFunction(selectedCar);
  }

  @override
  Widget build(BuildContext context) {
    return widget.selectedCar != null
        ? Card(
            child: ListTile(
              onTap: () {
                widget.canEdit
                    ? showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (ctx) => BlocProvider.value(
                          value: context.read<CarCubit>(),
                          child: CarListBottomSheet(
                            isAluminium: widget.isAluminium,
                            selectCarFunction: selectCar,
                          ),
                        ),
                      )
                    : AppAlertUtil.showError(context, "Unable to change car");
              },
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  widget.selectedCar!.carCompany[0].toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                widget.selectedCar!.carName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(widget.selectedCar!.carModel),
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
                      builder: (ctx) => BlocProvider.value(
                        value: context.read<CarCubit>(),
                        child: CarListBottomSheet(
                          isAluminium: widget.isAluminium,
                          selectCarFunction: selectCar,
                        ),
                      ),
                    );
                  },
                  child: Text("Select Car"),
                ),
              ),
            ),
          );
  }
}

class CarListBottomSheet extends StatefulWidget {
  CarListBottomSheet(
      {super.key, required this.selectCarFunction, required this.isAluminium});
  final Function selectCarFunction;
  bool isAluminium;

  @override
  State<CarListBottomSheet> createState() => _CarListBottomSheetState();
}

class _CarListBottomSheetState extends State<CarListBottomSheet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CarCubit>().fetchAllCars(widget.isAluminium);
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions(context);
    return SizedBox(
      height: dimensions.height50,
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
                    "Select Car",
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
                          builder: (ctx) => BlocProvider.value(
                            value: context.read<CarCubit>(),
                            child: CarDialogue(
                              isAluminium: widget.isAluminium,
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
            child: BlocBuilder<CarCubit, CarState>(
              builder: (context, state) {
                if (state is CarLoadingState) {
                  return LoadingIndicator();
                } else if (state is CarErrorState) {
                  return ErrorText(
                    errorMessage: state.errorMessage,
                  );
                } else if (state is CarLoadedState) {
                  return state.carList.isEmpty
                      ? NoDataAvaliableText()
                      : ListView.builder(
                          itemCount: state.carList.length,
                          itemBuilder: (context, index) => Card(
                            child: ListTile(
                              onTap: () {
                                widget.selectCarFunction(state.carList[index]);
                                AppRouter.pop();
                              },
                              title: Text(
                                state.carList[index].carName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: state.carList[index].carModel.isNotEmpty
                                  ? Text(state.carList[index].carModel)
                                  : null,
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  state.carList[index].carCompany
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
