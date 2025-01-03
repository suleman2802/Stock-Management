import 'package:flutter/widgets.dart';

class Dimensions {
  late final double height;
  late final double width;

  late final bool isPortrait;

  bool get isMobile => width < 650;

  bool get isTablet => width >650 && width < 900;

  bool get isDesktop => width > 1300;

  double get display1 => height / 15;

  double get display2 => height / 20;

  double get display3 => height / 30;

  double get display5 => height / 37;

  double get display6 => height / 45;

  double get radiusSmall => 15.0;

  double get height1 => height * 0.01;

  double get height2 => height * 0.02;

  double get height3 => height * 0.03;

  double get height5 => height * 0.05;

  double get height7 => height * 0.07;

  double get height10 => height * 0.1;

  double get height15 => height * 0.15;

  double get height20 => height * 0.2;

  double get height25 => height * 0.25;

  double get height30 => height * 0.3;

  double get height35 => height * 0.35;

  double get height40 => height * 0.4;

  double get height45 => height * 0.45;

  double get height50 => height * 0.5;

  double get height55 => height * 0.55;

  double get height60 => height * 0.6;

  double get height70 => height * 0.7;

  double get height80 => height * 0.8;

  double get height90 => height * 0.9;

  double get width2 => width * 0.02;

  double get width3 => width * 0.03;

  double get width4 => width * 0.04;

  double get width5 => width * 0.05;

  double get width10 => width * 0.1;

  double get width15 => width * 0.15;

  double get width20 => width * 0.2;

  double get width30 => width * 0.3;

  double get width40 => width * 0.4;

  double get width50 => width * 0.5;

  double get width60 => width * 0.6;

  double get width70 => width * 0.7;

  double get width80 => width * 0.8;

  Dimensions(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;

    isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  }

  @override
  String toString() {
    return 'Dimensions{height: $height, width: $width, isPortrait: $isPortrait}';
  }
}
