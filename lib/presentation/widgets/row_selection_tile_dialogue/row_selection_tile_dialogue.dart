import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/dimensions.dart';
import '../../../domain/models/rows.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../screen/rows/cubit/rows_cubit.dart';
import '../../screen/rows/widgets/rows_dialogue.dart';
import '../spaces/space.dart';
import '../state_indicators/error_text/error_text.dart';
import '../state_indicators/loading_indicator/loading_indicator.dart';
import '../state_indicators/no_data_avaliable_text/no_data_avaliable_text.dart';
import '../styling/bordered_container.dart';
import '../styling/bottom_sheet_header.dart';
import '../styling/round_icon_button.dart';

class RowSelectionTileDialogue extends StatefulWidget {
  RowSelectionTileDialogue({super.key, this.selectedRows,required this.assignSelectedRowsFunciton});
  Rows? selectedRows;
  final Function assignSelectedRowsFunciton;

  @override
  State<RowSelectionTileDialogue> createState() =>
      _RowSelectionTileDialogueState();
}

class _RowSelectionTileDialogueState extends State<RowSelectionTileDialogue> {
  void selectRow(Rows selectedRow) {
    setState(() {
      widget.selectedRows = selectedRow;
    });
    widget.assignSelectedRowsFunciton(selectedRow);
  }

  @override
  Widget build(BuildContext context) {
    return widget.selectedRows != null
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
                    value: context.read<RowsCubit>(),
                    child: RowListBottomSheet(
                      selectRowsFunction: selectRow,
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  widget.selectedRows!.noOfRows.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                "${widget.selectedRows!.noOfRows} mm",
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
                      builder: (ctx) => BlocProvider.value(
                          value: context.read<RowsCubit>(),
                          child: RowListBottomSheet(
                            selectRowsFunction: selectRow,
                          )),
                    );
                  },
                  child: Text("Select Rows"),
                ),
              ),
            ),
          );
  }
}

class RowListBottomSheet extends StatelessWidget {
  const RowListBottomSheet({super.key, required this.selectRowsFunction});
  final Function selectRowsFunction;
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
                    "Select Number of Rows",
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
                            value: context.read<RowsCubit>(),
                            child: RowsDialogue(),
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
            child: BlocBuilder<RowsCubit, RowsState>(
              builder: (context, state) {
                if (state is RowsLoadingState) {
                  return LoadingIndicator();
                } else if (state is RowsErrorState) {
                  return ErrorText(
                    errorMessage: state.errorMessage,
                  );
                } else if (state is RowsLoadedState) {
                  return state.rowsList.isEmpty
                      ? NoDataAvaliableText()
                      : ListView.builder(
                          itemCount: state.rowsList.length,
                          itemBuilder: (context, index) => Card(
                            child: ListTile(
                              onTap: () {
                                selectRowsFunction(state.rowsList[index]);
                                AppRouter.pop();
                              },
                              title:
                                  Text("${state.rowsList[index].noOfRows} mm"),
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
