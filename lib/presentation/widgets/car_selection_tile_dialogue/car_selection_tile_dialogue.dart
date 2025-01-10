import 'package:flutter/material.dart';

import '../../../domain/models/car.dart';
import '../../../utilities/app_routes/app_routes.dart';

class CarSelectionTileDialogue extends StatelessWidget {
  const CarSelectionTileDialogue({super.key, required this.car});
  final Car car;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actions: [
              ElevatedButton(
                onPressed: () => navigateBack(context),
                child: Text("Concel"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Save"),
              ),
            ],
            title: Text("Select Car"),
            content: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) => ListTile(
                title: Text("Car"),
                subtitle: Text("model $index"),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    "A",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                trailing: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text("A"),
                    ),
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text("P"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(
          car.carCompany[0].toUpperCase(),
        ),
      ),
      title: Text(
        car.carName,
      ),
      subtitle: Text(
        car.carModel,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              car.carFuelType.toString().substring(1),
            ),
          ),
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              car.carAutomation.toString().substring(1),
            ),
          )
        ],
      ),
    );
  }
}
