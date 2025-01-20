import 'package:flutter/material.dart';

import '../../../config/dimensions.dart';
import '../../../domain/models/car.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../screen/car/widgets/car_dialogue.dart';
import '../spaces/space.dart';
import '../styling/bordered_container.dart';
import '../styling/bottom_sheet_header.dart';
import '../styling/round_icon_button.dart';

class CarSelectionTileDialogue extends StatefulWidget {
  const CarSelectionTileDialogue({super.key, this.car});
  final Car? car;

  @override
  State<CarSelectionTileDialogue> createState() =>
      _CarSelectionTileDialogueState();
}

class _CarSelectionTileDialogueState extends State<CarSelectionTileDialogue> {
  @override
  Widget build(BuildContext context) {
    return widget.car != null
        ? ListTile(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => CarListBottomSheet(),
              );
            },
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                widget.car!.carCompany[0].toUpperCase(),
              ),
            ),
            title: Text(widget.car!.carName),
            subtitle: Text(widget.car!.carModel),
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
                    builder: (context) => CarListBottomSheet(),
                  );
                },
                child: Text("Select Car"),
              ),
            ),
          );
  }
}

class CarListBottomSheet extends StatelessWidget {
  const CarListBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions(context);
    return SizedBox(
      height: dimensions.height50,
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
                    "Select Car",
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
                          builder: (context) => CarDialogue(),
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
                title: Text(
                  "Tesla",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Model $index"),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    "A",
                    style: TextStyle(color: Colors.white),
                  ),
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
