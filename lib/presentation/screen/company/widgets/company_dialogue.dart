import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/models/company.dart';
import '../../../../utilities/app_routes/app_router.dart';
import '../../../widgets/input_feilds/text_input_field.dart';
import '../../../widgets/state_indicators/general_alert/general_alert.dart';
import '../cubit/company_cubit.dart';

class CompanyDialogue extends StatefulWidget {
  CompanyDialogue({super.key, this.company});
  Company? company;

  @override
  State<CompanyDialogue> createState() => _CompanyDialogueState();
}

class _CompanyDialogueState extends State<CompanyDialogue> {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    widget.company != null
        ? nameController.text = widget.company!.name
        : nameController.text = "";
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  Future<void> submitRowForm() async {
    if (formKey.currentState?.validate() ?? false) {
      if (widget.company == null) {
        //? save fin here
        final bool isAddedSuccessfully = await context
            .read<CompanyCubit>()
            .addNewCompany(Company(name: nameController.text.trim()));

        if (mounted) {
          generalAlert(
            context: context,
            isSuccessful: isAddedSuccessfully,
            tile: "Company",
            type: AlertType.added,
          );
        }
      } else {
        //? edit fin
        final isUpdatedSuccessfully = await context
            .read<CompanyCubit>()
            .updateCompany(Company(
                id: widget.company!.id, name: nameController.text.trim()));
        if (mounted) {
          generalAlert(
            context: context,
            isSuccessful: isUpdatedSuccessfully,
            tile: "Company",
            type: AlertType.updated,
          );
        }
      }
      AppRouter.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        ElevatedButton(
          onPressed: () => AppRouter.pop(),
          child: Text("Concel"),
        ),
        ElevatedButton(
          onPressed: submitRowForm,
          child: Text(widget.company == null ? "Save" : "Edit"),
        ),
      ],
      title: Text(
        "Company",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: TextInputField(
            label: "Enter Company Name",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Company Name is required";
              }
              return null;
            },
            controller: nameController,
          ),
        ),
      ),
    );
  }
}
