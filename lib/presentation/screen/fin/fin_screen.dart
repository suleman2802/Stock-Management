import 'package:flutter/material.dart';
import '../../../domain/models/fin.dart';
import '../../../domain/models/size.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import 'widgets/fin_dialogue.dart';

class FinScreen extends StatelessWidget {
  const FinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      label: "Fin Screen",
      curentIndex: 0,
      action: IconButton(
        icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => FinDialogue(),
          );
        },
      ),
      body: ListView.builder(
        itemCount: 11,
        itemBuilder: (context, index) => ListTile(
          title: Text("$index mm"),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => FinDialogue(
                  fin: Fin(finSize: index),
                ),
              );
            },
            icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
