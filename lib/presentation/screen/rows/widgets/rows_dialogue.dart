import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/models/rows.dart';
import '../../../../utilities/app_routes/app_router.dart';
import '../../../widgets/input_feilds/number_input_field.dart';
import '../../../widgets/state_indicators/general_alert/general_alert.dart';
import '../../../widgets/state_indicators/loading_indicator/loading_indicator.dart';
import '../cubit/rows_cubit.dart';

class RowsDialogue extends StatefulWidget {
  RowsDialogue({super.key, this.rows, required this.isAluminium});
  final Rows? rows;
  bool isAluminium;

  @override
  State<RowsDialogue> createState() => _RowsDialogueState();
}

class _RowsDialogueState extends State<RowsDialogue> {
  final TextEditingController rowsController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showLoading = false;
  @override
  void initState() {
    super.initState();
    widget.rows != null
        ? rowsController.text = widget.rows!.noOfRows.toString()
        : rowsController.text = "";
  }

  @override
  void dispose() {
    super.dispose();
    rowsController.dispose();
  }

  Future<void> submitRowForm() async {
    setState(() {
      showLoading = true;
    });
    if (formKey.currentState?.validate() ?? false) {
      if (widget.rows == null) {
        //? save fin here
        final bool isAddedSuccessfully = await context
            .read<RowsCubit>()
            .addNewRows(Rows(noOfRows: int.parse(rowsController.text.trim())),
                widget.isAluminium);

        if (mounted) {
          generalAlert(
            context: context,
            isSuccessful: isAddedSuccessfully,
            tile: "Row",
            type: AlertType.added,
          );
        }
      } else {
        //? edit fin
        final isUpdatedSuccessfully = await context
            .read<RowsCubit>()
            .updateRows(
                Rows(
                    id: widget.rows!.id,
                    noOfRows: int.parse(rowsController.text.trim())),
                widget.isAluminium);
        if (mounted) {
          generalAlert(
            context: context,
            isSuccessful: isUpdatedSuccessfully,
            tile: "Row",
            type: AlertType.updated,
          );
        }
      }
      AppRouter.pop();
    }
    setState(() {
      showLoading = false;
    });
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
          child: Text(widget.rows == null ? "Save" : "Edit"),
        ),
      ],
      title: Text(
        "Rows",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: showLoading
          ? FittedBox(fit: BoxFit.scaleDown, child: LoadingIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: NumberInputField(
                  label:
                      "Enter Rows in ${widget.isAluminium ? "mm" : "number"}",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Number of Rows is required";
                    }
                    if (int.parse(value) <= 0) {
                      return "Number of Rows must be greater than 0";
                    }
                    return null;
                  },
                  controller: rowsController,
                ),
              ),
            ),
    );
  }
}
