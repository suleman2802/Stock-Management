import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/dimensions.dart';
import '../../../domain/models/fin.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../screen/fin/cubit/fin_cubit.dart';
import '../../screen/fin/widgets/fin_dialogue.dart';
import '../spaces/space.dart';
import '../state_indicators/error_text/error_text.dart';
import '../state_indicators/loading_indicator/loading_indicator.dart';
import '../state_indicators/no_data_avaliable_text/no_data_avaliable_text.dart';
import '../styling/bordered_container.dart';
import '../styling/bottom_sheet_header.dart';
import '../styling/round_icon_button.dart';

class FinSelectionTileDialogue extends StatefulWidget {
  FinSelectionTileDialogue(
      {super.key,
      this.selectedFin,
      required this.assignSelectedFinFunction,
      required this.isAluminium});
  Fin? selectedFin;
  final Function assignSelectedFinFunction;
  bool isAluminium;
  @override
  State<FinSelectionTileDialogue> createState() =>
      _FinSelectionTileDialogueState();
}

class _FinSelectionTileDialogueState extends State<FinSelectionTileDialogue> {
  void selectFin(Fin selectedFin) {
    setState(() {
      widget.selectedFin = selectedFin;
    });
    widget.assignSelectedFinFunction(selectedFin);
  }

  @override
  Widget build(BuildContext context) {
    return widget.selectedFin != null
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
                    value: context.read<FinCubit>(),
                    child: FinListBottomSheet(
                      isAluminium: widget.isAluminium,
                      selectFinFunction: selectFin,
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  widget.selectedFin!.finSize.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text("${widget.selectedFin!.finSize} mm"),
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
                        value: context.read<FinCubit>(),
                        child: FinListBottomSheet(
                          isAluminium: widget.isAluminium,
                          selectFinFunction: selectFin,
                        ),
                      ),
                    );
                  },
                  child: Text("Select Fin"),
                ),
              ),
            ),
          );
  }
}

class FinListBottomSheet extends StatefulWidget {
  FinListBottomSheet(
      {super.key, required this.selectFinFunction, required this.isAluminium});
  final Function selectFinFunction;
  bool isAluminium;

  @override
  State<FinListBottomSheet> createState() => _FinListBottomSheetState();
}

class _FinListBottomSheetState extends State<FinListBottomSheet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FinCubit>().fetchAllFinSizes(widget.isAluminium);
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
                    "Select Fin size",
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
                            value: context.read<FinCubit>(),
                            child: FinDialogue(
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
            child: BlocBuilder<FinCubit, FinState>(
              builder: (context, state) {
                if (state is FinLoadingState) {
                  return LoadingIndicator();
                } else if (state is FinErrorState) {
                  return ErrorText(
                    errorMessage: state.errorMessage,
                  );
                } else if (state is FinLoadedState) {
                  return state.finList.isEmpty
                      ? NoDataAvaliableText()
                      : ListView.builder(
                          itemCount: state.finList.length,
                          itemBuilder: (context, index) => Card(
                            child: ListTile(
                              onTap: () {
                                widget.selectFinFunction(state.finList[index]);
                                AppRouter.pop();
                              },
                              title: Text("${state.finList[index].finSize} mm"),
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
