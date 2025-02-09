import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/state_indicators/error_text/error_text.dart';
import '../../widgets/state_indicators/general_alert/general_alert.dart';
import '../../widgets/state_indicators/loading_indicator/loading_indicator.dart';
import '../../widgets/state_indicators/no_data_avaliable_text/no_data_avaliable_text.dart';
import '../../widgets/styling/round_icon_button.dart';
import 'cubit/car_cubit.dart';
import 'widgets/car_dialogue.dart';

class CarScreen extends StatelessWidget {
  CarScreen({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      // curentIndex: 0,
      label: "Car",
      action: RoundIconButton(
        iconData: Icons.add,
        onPress: () {
          showDialog(
            context: context,
            builder: (ctx) => BlocProvider.value(
              value: context.read<CarCubit>(),
              child: CarDialogue(),
            ),
          );
        },
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
                hintText: "Search by car name",
                onChanged: (value) async {
                  if (value.isNotEmpty) {
                    await context
                        .read<CarCubit>()
                        .fetchAllCarsByName(value.trim());
                  } else {
                    await context.read<CarCubit>().fetchAllCars();
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
                                showDialog(
                                  context: context,
                                  builder: (ctx) => BlocProvider.value(
                                    value: context.read<CarCubit>(),
                                    child: CarDialogue(
                                      car: state.carList[index],
                                    ),
                                  ),
                                );
                              },
                              title: Text(
                                state.carList[index].carName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(state.carList[index].carModel),
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  state.carList[index].carCompany
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  final bool isDeletedSuccessfully =
                                      await context
                                          .read<CarCubit>()
                                          .deleteCar(state.carList[index].id);

                                  generalAlert(
                                    context: context,
                                    isSuccessful: isDeletedSuccessfully,
                                    tile: "Car",
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
