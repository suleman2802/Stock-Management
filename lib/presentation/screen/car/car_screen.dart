import 'package:flutter/material.dart';

import '../../../domain/models/car.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/spaces/space.dart';
import 'widgets/car_dialogue.dart';

class CarScreen extends StatelessWidget {
  CarScreen({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      curentIndex: 0,
      label: "Car",
      action: IconButton(
        icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => CarDialogue(),
          );
        },
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: SearchBar(
                onTap: () {},
                controller: searchController,
                hintText: "Search by car name",
                onChanged: (value) {},
                leading: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          mediumHeightSpace(),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CarDialogue(
                      car: Car(
                        id: "-4",
                        carCompany: "test",
                        carModel: "test",
                        carName: "test",
                      ),
                    ),
                  );
                },
                title: Text("Car"),
                subtitle: Text("model $index"),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    "H",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                trailing: Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
