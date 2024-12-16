import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextFormField {
  Color fillColor;
  Color borderColor;
  String labelText;
  Widget? suffixIcon;
  BuildContext context;
  Color textColor;
  MyTextFormField({
    required this.fillColor,
    required this.borderColor,
    required this.context,
    this.suffixIcon,
    this.labelText="",
    this.textColor=Colors.white

  });
  InputDecoration decoration(){
    return InputDecoration(
      suffixIcon: suffixIcon,
        filled: true,
      counterText: "",
      labelText: labelText,
      labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor),
      fillColor: fillColor,
      errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(8.0)
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(8.0)
      )
    );
  }
}
