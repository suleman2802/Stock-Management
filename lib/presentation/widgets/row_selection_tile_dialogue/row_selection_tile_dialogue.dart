import 'package:flutter/material.dart';

import '../../../config/dimensions.dart';
import '../../../domain/models/rows.dart';
import '../../../utilities/app_routes/app_routes.dart';
import '../styling/bordered_container.dart';
import '../styling/bottom_sheet_header.dart';
import '../styling/round_icon_button.dart';

class RowSelectionTileDialogue extends StatefulWidget {
  const RowSelectionTileDialogue({super.key, this.rows});
  final Rows? rows;

  @override
  State<RowSelectionTileDialogue> createState() =>
      _RowSelectionTileDialogueState();
}

class _RowSelectionTileDialogueState extends State<RowSelectionTileDialogue> {
  @override
  Widget build(BuildContext context) {
    return widget.rows != null
        ? ListTile(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => RowListBottomSheet(),
              );
            },
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                widget.rows!.noOfRows.toString(),
              ),
            ),
            title: Text(widget.rows!.noOfRows.toString()),
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
                    builder: (context) => RowListBottomSheet(),
                  );
                },
                child: Text("Select Fin"),
              ),
            ),
          );
  }
}

class RowListBottomSheet extends StatelessWidget {
  const RowListBottomSheet({super.key});

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
                    "Select Number of Rows",
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
                title: Text("rows $index"),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    "3",
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
