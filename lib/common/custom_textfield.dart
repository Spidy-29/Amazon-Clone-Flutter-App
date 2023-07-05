import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomTextField({super.key,required this.controller,required this.hintText,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // this validator we make validation and if error gets throwns it will called by the Form widgets and display on the screens
      validator: (val) {},
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          )
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          )
        )
      ),
    );
  }
}