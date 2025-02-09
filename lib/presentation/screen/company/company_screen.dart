import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/select_type_drop_down/select_type_drop_down.dart';
import '../../widgets/spaces/space.dart';
import '../../widgets/state_indicators/error_text/error_text.dart';
import '../../widgets/state_indicators/general_alert/general_alert.dart';
import '../../widgets/state_indicators/loading_indicator/loading_indicator.dart';
import '../../widgets/state_indicators/no_data_avaliable_text/no_data_avaliable_text.dart';
import '../../widgets/styling/round_icon_button.dart';
import 'cubit/company_cubit.dart';
import 'widgets/company_dialogue.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  bool isAluminium = true;

  selectedType(bool isAluminiumSelected) {
    setState(() {
      isAluminium = isAluminiumSelected;
    });
    context.read<CompanyCubit>().fetchAllCompany(isAluminiumSelected);
  }

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      label: "Companies",
      // curentIndex: 0,
      action: Row(
        children: [
          RoundIconButton(
            iconData: Icons.add,
            onPress: () {
              showDialog(
                context: context,
                builder: (ctx) => BlocProvider.value(
                  value: context.read<CompanyCubit>(),
                  child: CompanyDialogue(
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
      body: Column(
        children: [
          Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: SearchBar(
                onTap: () {},
                controller: searchController,
                hintText: "Search by Company name",
                onChanged: (value) async {
                  if (value.isNotEmpty) {
                    await context
                        .read<CompanyCubit>()
                        .fetchAllCompaniesByName(value.trim(), isAluminium);
                  } else {
                    await context
                        .read<CompanyCubit>()
                        .fetchAllCompany(isAluminium);
                  }
                },
                leading: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          mediumHeightSpace(),
          Expanded(
            child: BlocBuilder<CompanyCubit, CompanyState>(
              builder: (context, state) {
                if (state is CompanyLoadingState) {
                  return LoadingIndicator();
                } else if (state is CompanyErrorState) {
                  return ErrorText(
                    errorMessage: state.errorMessage,
                  );
                } else if (state is CompanyLoadedState) {
                  return state.companyList.isEmpty
                      ? NoDataAvaliableText()
                      : ListView.builder(
                          itemCount: state.companyList.length,
                          itemBuilder: (context, index) => Card(
                            child: ListTile(
                              onTap: () => showDialog(
                                context: context,
                                builder: (ctx) => BlocProvider.value(
                                  value: context.read<CompanyCubit>(),
                                  child: CompanyDialogue(
                                    isAluminium: isAluminium,
                                    company: state.companyList[index],
                                  ),
                                ),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  state.companyList[index].name
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(state.companyList[index].name),
                              trailing: IconButton(
                                onPressed: () async {
                                  final bool isDeletedSuccessfully =
                                      await context
                                          .read<CompanyCubit>()
                                          .deleteCompany(
                                              state.companyList[index].id,
                                              isAluminium);

                                  generalAlert(
                                    context: context,
                                    isSuccessful: isDeletedSuccessfully,
                                    tile: "Company",
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
