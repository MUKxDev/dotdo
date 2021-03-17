import 'package:dotdo/theme/colors.dart';
import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String labelText;
  final String hintText;

  const TextfieldWidget({
    Key key,
    @required this.controller,
    @required this.obscureText,
    @required this.labelText,
    @required this.hintText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.darkBackground
              : AppColors.white,
        ),
        autocorrect: false,
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
