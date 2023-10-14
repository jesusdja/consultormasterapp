
import 'package:consultormasterapp/config/master_colors.dart';
import 'package:flutter/material.dart';

Widget circularProgressColors({
  double widthContainer1 = 50,
  double widthContainer2 = 50,
  Color colorCircular = MasterColors.primary,
}){
  return SizedBox(
    width: widthContainer1,
    child: Center(
      child: SizedBox(
        height: widthContainer2, width: widthContainer2,
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(colorCircular)),
      ),
    ),
  );
}