import 'package:flutter/material.dart';
import 'package:stock_management_application/presentation/widgets/spaces/space.dart';

import '../../../config/dimensions.dart';
import '../../../domain/models/radiator.dart';
import '../../../utilities/app_routes/app_routes.dart';
import '../../screen/radiator/widgets/radiator_dialogue.dart';
import '../styling/bordered_container.dart';
import '../styling/bottom_sheet_header.dart';
import '../styling/round_icon_button.dart';

class RadiatorSelectionTileDialogue extends StatefulWidget {
  const RadiatorSelectionTileDialogue({super.key, this.radiator});
  final Radiator? radiator;

  @override
  State<RadiatorSelectionTileDialogue> createState() =>
      _RadiatorSelectionTileDialogueState();
}

class _RadiatorSelectionTileDialogueState
    extends State<RadiatorSelectionTileDialogue> {
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
                builder: (context) => RadiatorListBottomSheet(),
              );
            },
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                widget.radiator!.car.carCompany.substring(1).toUpperCase(),
              ),
            ),
            title: Text(widget.radiator!.car.carName),
            subtitle: Text(widget.radiator!.size),
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
                    builder: (context) => RadiatorListBottomSheet(),
                  );
                },
                child: Text("Select Radiator"),
              ),
            ),
          );
  }
}

class RadiatorListBottomSheet extends StatelessWidget {
  const RadiatorListBottomSheet({super.key});

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
                        onPress: () => navigateBack(context),
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
                  navigateBack(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
