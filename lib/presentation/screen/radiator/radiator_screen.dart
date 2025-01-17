import 'package:flutter/material.dart';

import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/spaces/space.dart';
import '../../widgets/styling/round_icon_button.dart';
import 'widgets/radiator_dialogue.dart';

class RadiatorScreen extends StatelessWidget {
  RadiatorScreen({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      curentIndex: 0,
      label: "Radiators",
      action: RoundIconButton(
        iconData: Icons.add,
        onPress: () {
          // add new radiator
          showDialog(
            context: context,
            builder: (context) => RadiatorDialogue(),
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
                hintText: "Search by size",
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
                  // view & edit radiator
                  showDialog(
                    context: context,
                    builder: (context) => RadiatorDialogue(),
                  );
                },
                title: Text("Car.name"),
                subtitle: Text("size $index"),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    "A",
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
