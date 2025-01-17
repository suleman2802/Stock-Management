// import 'package:flutter/material.dart';
// import 'package:stock_management_application/presentation/widgets/styling/bordered_container.dart';

// import '../../../domain/models/car.dart';
// import '../../../utilities/app_routes/app_routes.dart';

// class CarSelectionTileDialogue extends StatefulWidget {
//   const CarSelectionTileDialogue({super.key, this.car});
//   final Car? car;

//   @override
//   State<CarSelectionTileDialogue> createState() =>
//       _CarSelectionTileDialogueState();
// }

// class _CarSelectionTileDialogueState extends State<CarSelectionTileDialogue> {
//   @override
//   Widget build(BuildContext context) {
//     return widget.car != null
//         ? ListTile(
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => CarListDialogue(),
//               );
//             },
//             leading: CircleAvatar(
//               backgroundColor: Theme.of(context).primaryColor,
//               child: Text(
//                 widget.car!.carCompany[0].toUpperCase(),
//               ),
//             ),
//             title: Text(
//               widget.car!.carName,
//             ),
//             subtitle: Text(
//               widget.car!.carModel,
//             ),
//           )
//         : BorderedContainer(
//             child: Center(
//               child: TextButton(
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => CarListDialogue(),
//                   );
//                 },
//                 child: Text("Select Car"),
//               ),
//             ),
//           );
//   }
// }

// class CarListDialogue extends StatelessWidget {
//   const CarListDialogue({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       actions: [
//         ElevatedButton(
//           onPressed: () => navigateBack(context),
//           child: Text("Concel"),
//         ),
//         ElevatedButton(
//           onPressed: () {},
//           child: Text("Save"),
//         ),
//       ],
//       title: Text("Select Car"),
//       content: ListView.builder(
//         itemCount: 4,
//         itemBuilder: (context, index) => ListTile(
//           title: Text("Car"),
//           subtitle: Text("model $index"),
//           leading: CircleAvatar(
//             backgroundColor: Theme.of(context).primaryColor,
//             child: Text(
//               "A",
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:stock_management_application/presentation/widgets/styling/bottom_sheet_header.dart';
import 'package:stock_management_application/presentation/widgets/styling/round_icon_button.dart';

import '../../../config/dimensions.dart';
import '../../../domain/models/car.dart';
import '../../../utilities/app_routes/app_routes.dart';
import '../styling/bordered_container.dart';

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
      height: dimensions.height80,
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Ensures the bottom sheet wraps content
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
                  RoundIconButton(
                    iconData: Icons.check,
                    onPress: () {},
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4, // Replace with the actual number of cars
              itemBuilder: (context, index) => ListTile(
                title: Text("Car $index"),
                subtitle: Text("Model $index"),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    "A",
                    style: TextStyle(color: Colors.white),
                  ),
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
