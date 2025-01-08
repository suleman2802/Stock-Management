import 'package:flutter/material.dart';
import 'package:stock_management_application/presentation/widgets/spaces/space.dart';
import 'package:stock_management_application/utilities/app_routes/app_routes.dart';

import '../../../domain/models/car.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/styling/bordered_container.dart';

class CarFormScreen extends StatefulWidget {
  const CarFormScreen({super.key});

  @override
  State<CarFormScreen> createState() => _CarFormScreenState();
}

class _CarFormScreenState extends State<CarFormScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CarFuelType _selectedFuelType = CarFuelType.petrol;
  CarAutomation _selectedCarAutomationType = CarAutomation.automatic;

  final TextEditingController carNameController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController carCompanyController = TextEditingController();
  final TextEditingController fromYearController = TextEditingController();
  final TextEditingController toYearController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    carNameController.dispose();
    carModelController.dispose();
    carCompanyController.dispose();
    fromYearController.dispose();
    toYearController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      curentIndex: 0,
      label: "Add Car",
      action: IconButton(
        icon: Icon(Icons.save, color: Theme.of(context).primaryColor),
        onPressed: () {
          //? validate form

          //? navigate to car screen
          navigateToCarScreen(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BorderedContainer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: carNameController,
                    decoration: InputDecoration(
                      labelText: "Enter Car Name",
                    ),
                  ),
                  TextFormField(
                    controller: carModelController,
                    decoration: InputDecoration(
                      labelText: "Enter Car Model",
                    ),
                  ),
                  TextFormField(
                    controller: carCompanyController,
                    decoration: InputDecoration(
                      labelText: "Enter Car Company",
                    ),
                  ),
                  TextFormField(
                    controller: fromYearController,
                    decoration: InputDecoration(
                      labelText: "Enter From Year",
                    ),
                  ),
                  TextFormField(
                    controller: toYearController,
                    decoration: InputDecoration(
                      labelText: "Enter To Year",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Fuel Type",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                          child: DropdownButton<CarFuelType>(
                            hint: Text('Select Fuel Type'),
                            value: _selectedFuelType,
                            onChanged: (CarFuelType? newValue) {
                              setState(() {
                                _selectedFuelType = newValue!;
                              });
                            },
                            items:
                                CarFuelType.values.map((CarFuelType fuelType) {
                              return DropdownMenuItem<CarFuelType>(
                                value: fuelType,
                                child: Text(
                                  fuelType.toString().split('.').last,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Automation Type",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      smallWidthSpace(),
                      Expanded(
                        child: DropdownButton<CarAutomation>(
                          hint: Text('Select Car Automation Type'),
                          value: _selectedCarAutomationType,

                          isExpanded:
                              true, // This ensures the dropdown takes up the full width of its container
                          onChanged: (CarAutomation? newValue) {
                            setState(() {
                              _selectedCarAutomationType = newValue!;
                            });
                          },
                          items: CarAutomation.values
                              .map((CarAutomation carAutomationType) {
                            return DropdownMenuItem<CarAutomation>(
                              value: carAutomationType,
                              child: Text(
                                carAutomationType.toString().split('.').last,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
