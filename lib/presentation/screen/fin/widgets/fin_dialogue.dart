import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/models/fin.dart';
import '../../../../domain/repositories/fin/abstract_fin_repository/abstract_fin_repository.dart';
import '../../../../utilities/app_routes/app_router.dart';
import '../../../widgets/state_indicators/general_alert/general_alert.dart';

class FinDialogue extends StatefulWidget {
  const FinDialogue({super.key, this.fin});
  final Fin? fin;

  @override
  State<FinDialogue> createState() => _FinDialogueState();
}

class _FinDialogueState extends State<FinDialogue> {
  final TextEditingController finController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    widget.fin != null
        ? finController.text = widget.fin!.finSize.toString()
        : finController.text = "";
  }

  @override
  void dispose() {
    super.dispose();
    finController.dispose();
  }

  submitFinForm() async {
    if (formKey.currentState?.validate() ?? false) {
      if (widget.fin == null) {
        //? save fin here
        final isAddedSuccessfully =
            await RepositoryProvider.of<FinRepository>(context).addNewFinSize(
                Fin(finSize: int.parse(finController.text.trim())));

        if (mounted) {
          generalAlert(
            context: context,
            isSuccessful: isAddedSuccessfully,
            tile: "Fin Size",
            type: AlertType.added,
          );
        }
      } else {
        //? edit fin
        final isUpdatedSuccessfully =
            await RepositoryProvider.of<FinRepository>(context).updateFinSize(
                Fin(
                    id: widget.fin!.id,
                    finSize: int.parse(finController.text.trim())));
        if (mounted) {
          generalAlert(
            context: context,
            isSuccessful: isUpdatedSuccessfully,
            tile: "Fin Size",
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
          onPressed: submitFinForm,
          child: Text(widget.fin == null ? "Save" : "Edit"),
        ),
      ],
      title: Text(
        "Fin (size)",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Enter Fin size in mm",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Fin is required";
              }
              if (int.parse(value) <= 0) {
                return "Fin must be greater than 0";
              }
              return null;
            },
            keyboardType: TextInputType.number,
            controller: finController,
          ),
        ),
      ),
    );
  }
}
