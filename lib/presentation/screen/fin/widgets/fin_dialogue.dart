import 'package:flutter/material.dart';
import '../../../../domain/models/fin.dart';
import '../../../../utilities/app_routes/app_routes.dart';

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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        ElevatedButton(
          onPressed: () => navigateBack(context),
          child: Text("Concel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              //? save fin here
              navigateBack(context);
            }
          },
          child: Text("Save"),
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
