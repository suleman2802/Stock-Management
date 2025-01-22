import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/models/car.dart';
import '../../../../utilities/app_routes/app_router.dart';
import '../../../widgets/input_feilds/text_input_field.dart';
import '../../../widgets/state_indicators/general_alert/general_alert.dart';
import '../cubit/car_cubit.dart';

class CarDialogue extends StatefulWidget {
  const CarDialogue({super.key, this.car});
  final Car? car;

  @override
  State<CarDialogue> createState() => _CarDialogueState();
}

class _CarDialogueState extends State<CarDialogue> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController carNameController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController carCompanyController = TextEditingController();

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

  submitCarForm() async {
    if (formKey.currentState?.validate() ?? false) {
      if (widget.car == null) {
        //? save car here
        final isAddedSuccessfully = await context.read<CarCubit>().addNewCar(
            Car(
                carCompany: carCompanyController.text.trim(),
                carModel: carModelController.text.trim(),
                carName: carNameController.text.trim()));

        if (mounted) {
          generalAlert(
            context: context,
            isSuccessful: isAddedSuccessfully,
            tile: "Car",
            type: AlertType.added,
          );
        }
      } else {
        //? edit car
        final isUpdatedSuccessfully = await context.read<CarCubit>().updateCar(
            Car(
                id: widget.car!.id,
                carCompany: carCompanyController.text.trim(),
                carModel: carModelController.text.trim(),
                carName: carNameController.text.trim()));
        if (mounted) {
          generalAlert(
            context: context,
            isSuccessful: isUpdatedSuccessfully,
            tile: "Car",
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
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: submitCarForm,
          child: Text(widget.car == null ? "Save" : "Edit"),
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
