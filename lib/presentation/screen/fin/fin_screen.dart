import 'package:flutter/material.dart';
import '../../../domain/models/fin.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/styling/round_icon_button.dart';
import 'widgets/fin_dialogue.dart';

class FinScreen extends StatelessWidget {
  const FinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      label: "Fin Screen",
      curentIndex: 0,
      action: RoundIconButton(
        iconData: Icons.add,
        onPress: () {
          showDialog(
            context: context,
            builder: (context) => FinDialogue(),
          );
        },
      ),
      body: ListView.builder(
        itemCount: 11,
        itemBuilder: (context, index) => ListTile(
          onTap: () => showDialog(
            context: context,
            builder: (context) => FinDialogue(
              fin: Fin(finSize: index),
            ),
          ),
          title: Text("$index mm"),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete_forever, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
