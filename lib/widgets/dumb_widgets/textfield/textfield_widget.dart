import 'package:dotdo/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class TextfieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final bool autocorrect;
  final String labelText;
  final String hintText;
  final int maxLine;
  final TextInputType keyboardType;
  final String autofillHints;
  final AutovalidateMode autovalidateMode;
  final Function validator;

  const TextfieldWidget({
    Key key,
    @required this.controller,
    this.obscureText = false,
    @required this.labelText,
    @required this.hintText,
    this.maxLine,
    this.keyboardType,
    this.autofillHints,
    this.autovalidateMode,
    this.validator,
    this.autocorrect = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: TextFormField(
        autovalidateMode: autovalidateMode,
        validator: validator,
        keyboardType: keyboardType,
        autofillHints: [autofillHints],
        maxLength: maxLine,
        controller: controller,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.darkBackground
              : AppColors.white,
        ),
        autocorrect: autocorrect,
        autofocus: false,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
