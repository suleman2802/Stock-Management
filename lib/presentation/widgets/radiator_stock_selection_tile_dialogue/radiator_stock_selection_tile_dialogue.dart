import 'package:flutter/material.dart';

import '../../../config/dimensions.dart';
import '../../../domain/models/radiator_stock.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../screen/radiator/widgets/radiator_dialogue.dart';
import '../spaces/space.dart';
import '../styling/bordered_container.dart';
import '../styling/bottom_sheet_header.dart';
import '../styling/round_icon_button.dart';

class RadiatorStockSelectionTileDialogue extends StatefulWidget {
  const RadiatorStockSelectionTileDialogue({super.key, this.radiator});
  final RadiatorStock? radiator;

  @override
  State<RadiatorStockSelectionTileDialogue> createState() =>
      _RadiatorStockSelectionTileDialogueState();
}

class _RadiatorStockSelectionTileDialogueState
    extends State<RadiatorStockSelectionTileDialogue> {
  @override
  Widget build(BuildContext context) {
    return widget.radiator != null
        ? ListTile(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => RadiatorStockListBottomSheet(),
              );
            },
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                widget.radiator!.radiator.car.carCompany
                    .substring(1)
                    .toUpperCase(),
              ),
            ),
            title: Text(widget.radiator!.radiator.car.carName),
            subtitle: Text(widget.radiator!.radiator.size),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Rows : 5"),
                Text("Fin : 8 mm"),
              ],
            ),
          )
        : BorderedContainer(
            child: Center(
              child: TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) => RadiatorStockListBottomSheet(),
                  );
                },
                child: Text("Select Radiator"),
              ),
            ),
          );
  }
}

class RadiatorStockListBottomSheet extends StatelessWidget {
  const RadiatorStockListBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions(context);
    return SizedBox(
      height: dimensions.height80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHeader(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Radiator",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  Row(
                    children: [
                      RoundIconButton(
                        iconData: Icons.add,
                        onPress: () => showDialog(
                          context: context,
                          builder: (context) => RadiatorDialogue(),
                        ),
                      ),
                      smallWidthSpace(),
                      RoundIconButton(
                        iconData: Icons.close,
                        onPress: () => AppRouter.pop(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4, // Replace with the actual number of cars
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    "H",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  "car name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("37 x 8 x 9"),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Rows : 5"),
                    Text("Fin : 8 mm"),
                  ],
                ),
                onTap: () {
                  AppRouter.pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
