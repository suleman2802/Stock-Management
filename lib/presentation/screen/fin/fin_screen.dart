import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/select_type_drop_down/select_type_drop_down.dart';
import '../../widgets/state_indicators/error_text/error_text.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/state_indicators/general_alert/general_alert.dart';
import '../../widgets/state_indicators/loading_indicator/loading_indicator.dart';
import '../../widgets/state_indicators/no_data_avaliable_text/no_data_avaliable_text.dart';
import '../../widgets/styling/round_icon_button.dart';
import 'cubit/fin_cubit.dart';
import 'widgets/fin_dialogue.dart';

class FinScreen extends StatefulWidget {
  const FinScreen({super.key});

  @override
  State<FinScreen> createState() => _FinScreenState();
}

class _FinScreenState extends State<FinScreen> {
  bool isAluminium = true;

  selectedType(bool isAluminiumSelected) {
    setState(() {
      isAluminium = isAluminiumSelected;
    });
    context.read<FinCubit>().fetchAllFinSizes(isAluminiumSelected);
  }

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      label: "Fin Screen",
      // curentIndex: 0,
      action: Row(
        children: [
          RoundIconButton(
            iconData: Icons.add,
            onPress: () {
              showDialog(
                context: context,
                builder: (ctx) => BlocProvider.value(
                  value: context.read<FinCubit>(),
                  child: FinDialogue(
                    isAluminium: isAluminium,
                  ),
                ),
              );
            },
          ),
          SelectTypeDropDown(
            isAluminium: isAluminium,
            selectedTypeFunction: selectedType,
          ),
        ],
      ),
      body: BlocBuilder<FinCubit, FinState>(
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
                        onTap: () => showDialog(
                          context: context,
                          builder: (ctx) => BlocProvider.value(
                            value: context.read<FinCubit>(),
                            child: FinDialogue(
                              isAluminium: isAluminium,
                              fin: state.finList[index],
                            ),
                          ),
                        ),
                        title: Text("${state.finList[index].finSize} mm"),
                        trailing: IconButton(
                          onPressed: () async {
                            final bool isDeletedSuccessfully = await context
                                .read<FinCubit>()
                                .deleteFinSize(
                                    state.finList[index].id, isAluminium);

                            generalAlert(
                              context: context,
                              isSuccessful: isDeletedSuccessfully,
                              tile: "Fin Size",
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
