import 'package:flutter/material.dart';
import '../../../domain/models/rows.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import 'widgets/rows_dialogue.dart';

class RowScreen extends StatelessWidget {
  const RowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      label: "Row",
      curentIndex: 0,
      action: IconButton(
        icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => RowDialogue(),
          );
        },
      ),
      body: ListView.builder(
        itemCount: 11,
        itemBuilder: (context, index) => ListTile(
          onTap: () => showDialog(
            context: context,
            builder: (context) => RowDialogue(
              rows: Rows(noOfRows: index),
            ),
          ),
          title: Text("$index mm"),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
