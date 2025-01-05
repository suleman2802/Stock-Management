import 'package:flutter/material.dart';
import '../../../../domain/models/size.dart';
import '../../../../utilities/app_routes/app_routes.dart';

class SizeDialogue extends StatefulWidget {
  const SizeDialogue({super.key, this.size});
  final Size? size;

  @override
  State<SizeDialogue> createState() => _SizeDialogueState();
}

class _SizeDialogueState extends State<SizeDialogue> {
  final TextEditingController sizeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    widget.size != null
        ? sizeController.text = widget.size!.width.toString()
        : sizeController.text = "";
  }

  @override
  void dispose() {
    super.dispose();
    sizeController.dispose();
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
              //? save size here
              navigateBack(context);
            }
          },
          child: Text("Save"),
        ),
      ],
      title: Text(
        "Size (width)",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Enter Size in mm",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Size is required";
              }
              if (int.parse(value) <= 0) {
                return "Size must be greater than 0";
              }
              return null;
            },
            keyboardType: TextInputType.number,
            controller: sizeController,
          ),
        ),
      ),
    );
  }
}
