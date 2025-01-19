import 'package:flutter/material.dart';
import '../../../../domain/models/car.dart';
import '../../../../utilities/app_routes/app_routes.dart';
import '../../../widgets/input_feilds/text_input_field.dart';

class CarDialogue extends StatefulWidget {
  const CarDialogue({super.key, this.car});
  final Car? car;

  @override
  State<CarDialogue> createState() => _CarDialogueState();
}

class _CarDialogueState extends State<CarDialogue> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (widget.car != null) {
      carNameController.text = widget.car!.carName;
      carModelController.text = widget.car!.carModel;
      carCompanyController.text = widget.car!.carCompany;
    }
  }

  @override
  void dispose() {
    super.dispose();
    carNameController.dispose();
    carModelController.dispose();
    carCompanyController.dispose();
  }

  final TextEditingController carNameController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController carCompanyController = TextEditingController();
@override
Widget build(BuildContext context) {
  return AlertDialog(
    actions: [
      ElevatedButton(
        onPressed: () => AppRouter.pop(),
        child: Text("Cancel"),
      ),
      ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            // Save functionality here
            AppRouter.pop();
          }
        },
        child: Text("Save"),
      ),
    ],
    title: Text(
      "Car Details",
      style: Theme.of(context).textTheme.titleMedium,
    ),
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntrinsicHeight(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextInputField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Car name';
                  } else if (value.length <= 2) {
                    return 'Car name must be more than 2 characters';
                  }
                  return null;
                },
                controller: carNameController,
                label: "Enter Car Name",
              ),
              TextInputField(
                controller: carModelController,
                label: "Enter Car Model",
              ),
              TextInputField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Car company name';
                  } else if (value.length <= 2) {
                    return 'Company name must be more than 2 characters';
                  }
                  return null;
                },
                controller: carCompanyController,
                label: "Enter Car Company",
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}
