import 'package:flutter/material.dart';

import '../../../utilities/app_routes/app_routes.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/spaces/space.dart';
import '../../widgets/styling/round_icon_button.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      curentIndex: 1,
      label: "Stock",
      action: RoundIconButton(
        iconData: Icons.add,
        onPress: () {
          navigateToStockFormScreen(context);
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
                onTap: () => navigateToStockFormScreen(context),
                title: Text("Stock"),
                subtitle: Text("model $index"),
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
