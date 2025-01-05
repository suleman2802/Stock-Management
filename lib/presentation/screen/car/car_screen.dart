import 'package:flutter/material.dart';
import 'package:stock_management_application/presentation/widgets/spaces/space.dart';
import 'package:stock_management_application/utilities/app_routes/app_routes.dart';

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
          navigateToCarFormScreen(context);
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
