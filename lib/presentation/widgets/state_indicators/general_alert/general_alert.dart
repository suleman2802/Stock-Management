import 'package:flutter/material.dart';

import '../../../../utilities/app_alerts/app_alerts.dart';

enum AlertType {
  added,
  updated,
  deleted,
}

void generalAlert(
    {required BuildContext context,
    required bool isSuccessful,
    required String tile,
    required AlertType type}) {
  if (isSuccessful) {
    AppAlertUtil.showSuccess(context, "$tile ${type.name} record Successfully");
  } else {
    AppAlertUtil.showError(context, "Unable to ${type.name} $tile record!...");
  }
}
