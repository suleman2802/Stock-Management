import 'package:flutter/material.dart';

import '../../../utilities/app_alerts/app_alerts.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/spaces/space.dart';
import 'widgets/single_input_pin.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController pinController1 = TextEditingController();
  final TextEditingController pinController2 = TextEditingController();
  final TextEditingController pinController3 = TextEditingController();
  final TextEditingController pinController4 = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pinController1.dispose();
    pinController2.dispose();
    pinController3.dispose();
    pinController4.dispose();
  }

  validatePin() {
    if (pinController1.text.trim() +
            pinController2.text.trim() +
            pinController3.text.trim() +
            pinController4.text.trim() ==
        "0202") {
  
    }
    AppAlertUtil.showError(context, "Invalid pin");
  }

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      label: "Authentication",
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Good To have you back",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          largeHeightSpace(),
          const Text("Please Authenticate yourself"),
          mediumHeightSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SingleInputPin(
                pinKey: Key("pin1"),
                pinController: pinController1,
              ),
              SingleInputPin(
                pinKey: Key("pin2"),
                pinController: pinController2,
              ),
              SingleInputPin(
                pinKey: Key("pin3"),
                pinController: pinController3,
              ),
              SingleInputPin(
                pinKey: Key("pin4"),
                pinController: pinController4,
              ),
            ],
          ),
          mediumHeightSpace(),
          ElevatedButton(
            onPressed: validatePin,
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
