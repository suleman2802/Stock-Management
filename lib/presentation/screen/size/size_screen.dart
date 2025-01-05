import 'package:flutter/material.dart';
import '../../../domain/models/size.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import 'widgets/size_dialogue.dart';

class SizeScreen extends StatelessWidget {
  const SizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      label: "Size",
      action: IconButton(
        icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
        onPressed: () {
          showDialog(
                  context: context,
                  builder: (context) => SizeDialogue(),
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
                  builder: (context) => SizeDialogue(size: Size(width: index),),
                );
              },
              icon: Icon(Icons.edit)),
        ),
      ),
    );
  }
}
