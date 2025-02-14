import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/dimensions.dart';
import '../../../domain/models/car.dart';
import '../../../domain/models/radiator_stock.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../screen/stock/cubit/stock_cubit.dart';
import '../state_indicators/error_text/error_text.dart';
import '../state_indicators/loading_indicator/loading_indicator.dart';
import '../state_indicators/no_data_avaliable_text/no_data_avaliable_text.dart';
import '../styling/bordered_container.dart';
import '../styling/bottom_sheet_header.dart';
import '../styling/round_icon_button.dart';

class RadiatorStockSelectionTileDialogue extends StatefulWidget {
  RadiatorStockSelectionTileDialogue({
    super.key,
    this.radiator,
    this.car,
    required this.assignSelectedRadiatorFunciton,
    required this.isAluminium,
  });
  final RadiatorStock? radiator;
  Car? car;
  final Function assignSelectedRadiatorFunciton;
  bool isAluminium;

  @override
  State<RadiatorStockSelectionTileDialogue> createState() =>
      _RadiatorStockSelectionTileDialogueState();
}

class _RadiatorStockSelectionTileDialogueState
    extends State<RadiatorStockSelectionTileDialogue> {
  void selectRadiator(RadiatorStock selectedRadiator) {
    widget.assignSelectedRadiatorFunciton(selectedRadiator);
  }

  @override
  Widget build(BuildContext context) {
    return widget.radiator != null
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
                  builder: (ctx) => BlocProvider.value(
                    value: context.read<StockCubit>(),
                    child: RadiatorStockListBottomSheet(
                      isAluminium: widget.isAluminium,
                      car: widget.car,
                      selectRadiatorFunction: selectRadiator,
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  widget.radiator!.radiator!.car.carName
                      .substring(0, 1)
                      .toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(widget.radiator!.company!.name),
              subtitle: Text(widget.radiator!.radiator!.size),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Rows : ${widget.radiator!.radiator!.rows!.noOfRows}"),
                  Text("Fin : ${widget.radiator!.radiator!.fin!.finSize}"),
                ],
              ),
            ),
          )
        : BorderedContainer(
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
                      value: context.read<StockCubit>(),
                      child: RadiatorStockListBottomSheet(
                        isAluminium: widget.isAluminium,
                        selectRadiatorFunction: selectRadiator,
                        car: widget.car,
                      ),
                    ),
                  );
                },
                child: Text("Select Radiator"),
              ),
            ),
          );
  }
}

class RadiatorStockListBottomSheet extends StatefulWidget {
  RadiatorStockListBottomSheet(
      {super.key,
      this.car,
      required this.selectRadiatorFunction,
      required this.isAluminium});
  Car? car;
  final Function selectRadiatorFunction;
  bool isAluminium;

  @override
  State<RadiatorStockListBottomSheet> createState() =>
      _RadiatorStockListBottomSheetState();
}

class _RadiatorStockListBottomSheetState
    extends State<RadiatorStockListBottomSheet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.car != null) {
      context
          .read<StockCubit>()
          .fetchAllStocksByCarId(widget.car!.id, widget.isAluminium);
    } else {
      context.read<StockCubit>().fetchAllStocks(widget.isAluminium);
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
                  RoundIconButton(
                    iconData: Icons.close,
                    onPress: () => AppRouter.pop(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<StockCubit, StockState>(
              builder: (context, state) {
                if (state is StockLoadingState) {
                  return LoadingIndicator();
                } else if (state is StockErrorState) {
                  return ErrorText(
                    errorMessage: state.errorMessage,
                  );
                } else if (state is StockLoadedState) {
                  List<RadiatorStock> list = [];
                  for (var singleStock in state.stockList) {
                    for (var radiatorStocks in singleStock.radiatorStock) {
                      list.add(radiatorStocks);
                    }
                  }
                  return state.stockList.isEmpty
                      ? NoDataAvaliableText()
                      : ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) => Card(
                            child: ListTile(
                              onTap: () {
                                widget.selectRadiatorFunction(list[index]);
                                AppRouter.pop();
                              },
                              title: Text(
                                list[index].company!.name,
                                // list[index].radiator!.car.carName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      "Rows : ${list[index].radiator!.rows!.noOfRows}"),
                                  Text(
                                      "Fin : ${list[index].radiator!.fin!.finSize}"),
                                ],
                              ),
                              subtitle: Text(
                                  list[index].radiator!.size),
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  list[index].quantity.toString(),
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
