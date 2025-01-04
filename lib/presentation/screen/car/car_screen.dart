import 'package:flutter/material.dart';

import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';

class CarScreen extends StatelessWidget {
  const CarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      label: "Car",
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) => ListTile(
          title: Text("Car (automatic)"),
          subtitle: Text("model $index"),
          leading: Icon(Icons.car_rental),
          trailing: Icon(Icons.edit),
        ),
      ),
    );
  }
}
