import 'package:flutter/material.dart';

import '../../../config/dimensions.dart';
import '../../../domain/models/rows.dart';
import '../../../utilities/app_routes/app_routes.dart';
import '../../screen/rows/widgets/rows_dialogue.dart';
import '../spaces/space.dart';
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
                child: Text("Select Rows"),
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
                  Row(
                    children: [
                      RoundIconButton(
                        iconData: Icons.add,
                        onPress: () => showDialog(
                          context: context,
                          builder: (context) => RowDialogue(),
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
                  "rows $index",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    "3",
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
