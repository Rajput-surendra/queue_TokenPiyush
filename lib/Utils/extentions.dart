import 'package:booknplay/Utils/Colors.dart';
import 'package:flutter/material.dart';

extension CustomBoxDecoration on BoxDecoration {
  static BoxDecoration myCustomDecoration({
    Color color = Colors.white,
    double boxShadowOpacity = 0.5,
    double boxShadowBlurRadius = 10,
    double boxShadowSpreadRadius = 0,
    double borderRadius = 10.0,
  }) {
    return BoxDecoration(
      color: color,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(boxShadowOpacity),
          blurRadius: boxShadowBlurRadius,
          spreadRadius: boxShadowSpreadRadius,
        ),
      ],
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }
}


extension CustomInputDecoration on InputDecoration {
  static InputDecoration myCustomInputDecoration({
    String? labelText,
    String? hintText,
    IconData? prefixIcon,
    Widget? suffixIcon,
    InputBorder border = InputBorder.none,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.symmetric(vertical: 8.0),
  }) {
    return InputDecoration(
      //labelText: labelText,
      hintText: hintText,
      prefixIcon: Icon(prefixIcon,color: AppColors.subTxtClr),
      suffixIcon: suffixIcon,
      border: border,
      contentPadding: contentPadding,
      counterText: ''

    );
  }
}