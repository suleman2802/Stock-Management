import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/state_indicators/error_text/error_text.dart';
import '../../widgets/state_indicators/general_alert/general_alert.dart';
import '../../widgets/state_indicators/loading_indicator/loading_indicator.dart';
import '../../widgets/state_indicators/no_data_avaliable_text/no_data_avaliable_text.dart';
import '../../widgets/styling/round_icon_button.dart';
import 'cubit/rows_cubit.dart';
import 'widgets/rows_dialogue.dart';

class RowsScreen extends StatelessWidget {
  const RowsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      label: "Row",
      curentIndex: 0,
      action: RoundIconButton(
        iconData: Icons.add,
        onPress: () {
          showDialog(
            context: context,
            builder: (ctx) => BlocProvider.value(
              value: context.read<RowsCubit>(),
              child: RowsDialogue(),
            ),
          );
        },
      ),
      body: BlocBuilder<RowsCubit, RowsState>(
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
                        onTap: () => showDialog(
                          context: context,
                          builder: (ctx) => BlocProvider.value(
                            value: context.read<RowsCubit>(),
                            child: RowsDialogue(
                              rows: state.rowsList[index],
                            ),
                          ),
                        ),
                        title: Text("${state.rowsList[index].noOfRows} mm"),
                        trailing: IconButton(
                          onPressed: () async {
                            final bool isDeletedSuccessfully = await context
                                .read<RowsCubit>()
                                .deleteRows(state.rowsList[index].id);
                      
                            generalAlert(
                              context: context,
                              isSuccessful: isDeletedSuccessfully,
                              tile: "Row",
                              type: AlertType.deleted,
                            );
                          },
                          icon: Icon(Icons.delete_forever, color: Colors.red),
                        ),
                      ),
                    ),
                  );
          } else {
            return NoDataAvaliableText();
          }
        },
      ),
    );
  }
}
