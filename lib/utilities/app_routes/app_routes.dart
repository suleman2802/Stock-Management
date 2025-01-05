import 'package:flutter/material.dart';

const String homeScreen = "./home_screen";
const String authenticationScreen = "./authentication_screen";
const String carScreen = "./car_screen";
const String stockScreen = "./stock_screen";
const String purchaseScreen = "./purchase_screen";
const String sizeScreen = "./size_screen";

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

void navigateToSizeScreen(BuildContext context) {
  Navigator.pushNamed(context, sizeScreen);
}
