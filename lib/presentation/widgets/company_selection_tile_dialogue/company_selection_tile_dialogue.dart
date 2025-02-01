import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/dimensions.dart';
import '../../../domain/models/company.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../screen/company/cubit/company_cubit.dart';
import '../../screen/company/widgets/company_dialogue.dart';
import '../spaces/space.dart';
import '../state_indicators/error_text/error_text.dart';
import '../state_indicators/loading_indicator/loading_indicator.dart';
import '../state_indicators/no_data_avaliable_text/no_data_avaliable_text.dart';
import '../styling/bordered_container.dart';
import '../styling/bottom_sheet_header.dart';
import '../styling/round_icon_button.dart';

class CompanySelectionTileDialogue extends StatefulWidget {
  CompanySelectionTileDialogue(
      {super.key,
      this.selectedCompany,
      required this.assignSelectedCompanyFunciton});
  Company? selectedCompany;
  final Function assignSelectedCompanyFunciton;

  @override
  State<CompanySelectionTileDialogue> createState() =>
      _CompanySelectionTileDialogueState();
}

class _CompanySelectionTileDialogueState
    extends State<CompanySelectionTileDialogue> {
  void selectCompany(Company selectedCompany) {
    setState(() {
      widget.selectedCompany = selectedCompany;
    });
    widget.assignSelectedCompanyFunciton(selectedCompany);
  }

  @override
  Widget build(BuildContext context) {
    return widget.selectedCompany != null
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
                    value: context.read<CompanyCubit>(),
                    child: CompanyListBottomSheet(
                      selectcompanyFunction: selectCompany,
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  widget.selectedCompany!.name.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                widget.selectedCompany!.name,
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
                          value: context.read<CompanyCubit>(),
                          child: CompanyListBottomSheet(
                            selectcompanyFunction: selectCompany,
                          )),
                    );
                  },
                  child: Text("Select company"),
                ),
              ),
            ),
          );
  }
}

class CompanyListBottomSheet extends StatelessWidget {
  const CompanyListBottomSheet({super.key, required this.selectcompanyFunction});
  final Function selectcompanyFunction;
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
                    "Select Name of company",
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
                            value: context.read<CompanyCubit>(),
                            child: CompanyDialogue(),
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
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  state.companyList[index].name
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              onTap: () {
                                selectcompanyFunction(state.companyList[index]);
                                AppRouter.pop();
                              },
                              title: Text(state.companyList[index].name),
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
