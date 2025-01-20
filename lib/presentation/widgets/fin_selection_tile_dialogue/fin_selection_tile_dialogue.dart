import 'package:flutter/material.dart';

import '../../../config/dimensions.dart';
import '../../../domain/models/fin.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../screen/fin/widgets/fin_dialogue.dart';
import '../spaces/space.dart';
import '../styling/bordered_container.dart';
import '../styling/bottom_sheet_header.dart';
import '../styling/round_icon_button.dart';

class FinSelectionTileDialogue extends StatefulWidget {
  const FinSelectionTileDialogue({super.key, this.fin});
  final Fin? fin;

  @override
  State<FinSelectionTileDialogue> createState() =>
      _FinSelectionTileDialogueState();
}

class _FinSelectionTileDialogueState extends State<FinSelectionTileDialogue> {
  @override
  Widget build(BuildContext context) {
    return widget.fin != null
        ? ListTile(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => FinListBottomSheet(),
              );
            },
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                widget.fin!.finSize.toString(),
              ),
            ),
            title: Text(widget.fin!.finSize.toString()),
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
                    builder: (context) => FinListBottomSheet(),
                  );
                },
                child: Text("Select Fin"),
              ),
            ),
          );
  }
}

class FinListBottomSheet extends StatelessWidget {
  const FinListBottomSheet({super.key});

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
                    "Select Fin size",
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
                          builder: (context) => FinDialogue(),
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
                  "fin $index",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    "8",
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
