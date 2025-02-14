import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/car/abstract_car_repository/abstract_car_repository.dart';
import '../../../domain/repositories/fin/abstract_fin_repository/abstract_fin_repository.dart';
import '../../../domain/repositories/radiator/abstract_radiator_repository/abstract_radiator_repository.dart';
import '../../../domain/repositories/rows/abstract_rows_repository/abstract_rows_repository.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/select_type_drop_down/select_type_drop_down.dart';
import '../../widgets/state_indicators/error_text/error_text.dart';
import '../../widgets/state_indicators/general_alert/general_alert.dart';
import '../../widgets/state_indicators/loading_indicator/loading_indicator.dart';
import '../../widgets/state_indicators/no_data_avaliable_text/no_data_avaliable_text.dart';
import '../../widgets/styling/round_icon_button.dart';
import 'cubit/radiator_cubit.dart';
import 'widgets/radiator_dialogue.dart';

class RadiatorScreen extends StatefulWidget {
  RadiatorScreen({super.key});

  @override
  State<RadiatorScreen> createState() => _RadiatorScreenState();
}

class _RadiatorScreenState extends State<RadiatorScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isAluminium = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RadiatorCubit>().fetchAllRadiators(isAluminium);
  }

  selectedType(bool isAluminiumSelected) {
    setState(() {
      isAluminium = isAluminiumSelected;
    });
    context.read<RadiatorCubit>().fetchAllRadiators(isAluminiumSelected);
  }

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      // curentIndex: 0,
      label: "Radiators",
      action: Row(
        children: [
          RoundIconButton(
            iconData: Icons.add,
            onPress: () {
              // add new radiator
              showDialog(
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
                      isNew: true,
                      isAluminium: isAluminium,
                    ),
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
      body: Column(
        children: [
          Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: SearchBar(
                onTap: () {},
                controller: searchController,
                hintText: "Search by size",
                onChanged: (value) async {
                  if (value.isNotEmpty) {
                    await context
                        .read<RadiatorCubit>()
                        .fetchAllRadiatorsBySize(value.trim(), isAluminium);
                  } else {
                    await context
                        .read<RadiatorCubit>()
                        .fetchAllRadiators(isAluminium);
                  }
                },
                leading: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
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
                                showDialog(
                                  context: context,
                                  builder: (ctx) => MultiRepositoryProvider(
                                    providers: [
                                      RepositoryProvider.value(
                                        value:
                                            context.read<RadiatorRepository>(),
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
                                        isNew: false,
                                        isAluminium: isAluminium,
                                        radiator: state.radiatorList[index],
                                      ),
                                    ),
                                  ),
                                );
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
                              trailing: IconButton(
                                onPressed: () async {
                                  final bool isDeletedSuccessfully =
                                      await context
                                          .read<RadiatorCubit>()
                                          .deleteRadiator(
                                              state.radiatorList[index].id,
                                              isAluminium);

                                  generalAlert(
                                    context: context,
                                    isSuccessful: isDeletedSuccessfully,
                                    tile: "Radiator",
                                    type: AlertType.deleted,
                                  );
                                },
                                icon: Icon(Icons.delete_forever,
                                    color: Colors.red),
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
