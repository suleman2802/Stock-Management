import 'package:flutter/material.dart';

const String homeScreen = "./home_screen";
const String authenticationScreen = "./authentication_screen";
const String carScreen = "./car_screen";
const String stockScreen = "./stock_screen";
const String purchaseScreen = "./purchase_screen";
const String rowScreen = "./row_screen";
const String reportsScreen = "./reports_screen";
const String stockFormScreen = "./stock_form_screen";
const String finScreen = "./fin_screen";
const String radiatorScreen = "./radiator_screen";
const String radiatorFormScreen = "./radiator_form_screen";

void navigateBack(BuildContext context){
  Navigator.pop(context);
}

void navigateToHomeScreen(BuildContext context) {
  Navigator.pushNamed(context, homeScreen);
}

void navigateToAuthenticationScreen(BuildContext context) {
  Navigator.pushNamed(context, authenticationScreen);
}

void navigateToCarScreen(BuildContext context) {
  Navigator.pushNamed(context, carScreen);
}

void navigateToStockScreen(BuildContext context) {
  Navigator.pushNamed(context, stockScreen);
}

void navigateToPurchaseScreen(BuildContext context) {
  Navigator.pushNamed(context, purchaseScreen);
}

void navigateToRowScreen(BuildContext context) {
  Navigator.pushNamed(context, rowScreen);
}

void navigateToReportsScreen(BuildContext context) {
  Navigator.pushNamed(context, reportsScreen);
}

void navigateToStockFormScreen(BuildContext context) {
  Navigator.pushNamed(context, stockFormScreen);
}

void navigateToFinScreen(BuildContext context) {
  Navigator.pushNamed(context, finScreen);
}

void navigateToRadiatorScreen(BuildContext context) {
  Navigator.pushNamed(context, radiatorScreen);
}

void navigateToRadiatorFormScreen(BuildContext context) {
  Navigator.pushNamed(context, radiatorFormScreen);
}
