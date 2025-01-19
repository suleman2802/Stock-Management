import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../utilities/app_routes/app_routes.dart';
import '../../widgets/input_feilds/text_input_field.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/styling/round_icon_button.dart';
import 'widgets/single_sale_block.dart';

class SaleFormScreen extends StatefulWidget {
  const SaleFormScreen({super.key});

  @override
  State<SaleFormScreen> createState() => _SaleFormScreenState();
}

class _SaleFormScreenState extends State<SaleFormScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController customerNameController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();
  String? _selectedTime;
  Future<void> _startDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2501),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String getFormattedDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  void _timePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      } else {
        setState(() {
          _selectedTime = pickedTime.format(context).toString(); //pickedTime;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      curentIndex: 1,
      label: "Add Sale",
      action: RoundIconButton(
        iconData: Icons.save,
        onPress: () {
          //? validate form

          //? navigate to car screen
          navigateToStockScreen(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      _selectedDate == null
                          ? 'Pick up Date'
                          : getFormattedDate(_selectedDate!),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.calendar_month,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: _startDatePicker)
                  ],
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      _selectedTime == null ? 'Pick up Time' : _selectedTime!,
                      //!.format(context).toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.lock_clock,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: _timePicker),
                  ],
                ),
              ],
            ),
            TextInputField(
              controller: customerNameController,
              label: "Enter Customer Name",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Total Bill : 1000 /pkr"),
                IconButton.filledTonal(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).primaryColor,
                    )),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("----------------------("),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                        Text(")----------------------"),
                      ],
                    ),
                    SingleSaleBlock(),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
