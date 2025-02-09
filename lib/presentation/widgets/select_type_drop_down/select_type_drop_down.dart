import 'package:flutter/material.dart';

class SelectTypeDropDown extends StatefulWidget {
  final selectedTypeFunction;
  bool isAluminium;
  SelectTypeDropDown({required this.selectedTypeFunction, required this.isAluminium});
  @override
  _SelectTypeDropDownState createState() => _SelectTypeDropDownState();
}

class _SelectTypeDropDownState extends State<SelectTypeDropDown> {


  selectOption() {
    
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert), // Three-dot icon
      onSelected: (String value) {
        // setState(() {
          widget.isAluminium = value == "Aluminium";
        // });
        widget.selectedTypeFunction(value == "Aluminium");
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
         PopupMenuItem<String>(
          value: 'Aluminium',
          enabled: !widget.isAluminium ,
          child: Text('Aluminium'),
        ),
         PopupMenuItem<String>(
          enabled: widget.isAluminium ,
          value: 'Copper',
          child: Text('Copper'),
        ),
      ],
    );
  }
}
