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
import 'package:stock_management_application/presentation/widgets/styling/bordered_container.dart';
import 'package:stock_management_application/utilities/app_routes/app_routes.dart';

import '../../../domain/models/car.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Ensures the bottom sheet wraps content
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Select Car"),
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {},
              ),
            ],
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
