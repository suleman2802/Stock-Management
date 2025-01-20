import 'package:flutter/material.dart';
import '../../../../domain/models/rows.dart';
import '../../../../utilities/app_routes/app_router.dart';

class RowDialogue extends StatefulWidget {
  const RowDialogue({super.key, this.rows});
  final Rows? rows;

  @override
  State<RowDialogue> createState() => _RowDialogueState();
}

class _RowDialogueState extends State<RowDialogue> {
  final TextEditingController rowsController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        ElevatedButton(
          onPressed: () => AppRouter.pop(),
          child: Text("Concel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              //? save rows here
              AppRouter.pop();
            }
          },
          child: Text("Save"),
        ),
      ],
      title: Text(
        "Rows",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Enter Rows in mm",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Number of Rows is required";
              }
              if (int.parse(value) <= 0) {
                return "Number of Rows must be greater than 0";
              }
              return null;
            },
            keyboardType: TextInputType.number,
            controller: rowsController,
          ),
        ),
      ),
    );
  }
}
