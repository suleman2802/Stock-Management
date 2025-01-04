import 'package:flutter/material.dart';
import 'package:stock_management_application/presentation/widgets/spaces/space.dart';

import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';

class CarScreen extends StatelessWidget {
  CarScreen({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      label: "Car",
      action: IconButton(
        icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
        onPressed: () {
          // Implement add functionality here
        },
      ),
      body: Column(
        children: [
          SearchBar(
            controller: searchController,
            onChanged: (text) {
              // Implement search functionality here
            },
          ),
          mediumHeightSpace(),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
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
                trailing: Icon(Icons.edit),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
