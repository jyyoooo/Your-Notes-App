// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final int? maxLines;
  final double? fs;
  final FontWeight? fw;
  final bool border;

  const CustomTextField({
    Key? key,
    this.labelText = '',
    this.hintText = '',
    this.controller,
    this.obscureText = false,
    this.maxLines,
    this.fs,
    this.fw,
    this.border = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: TextStyle(fontSize: fs, fontWeight: fw),
        maxLines: maxLines,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          focusedBorder: OutlineInputBorder(
            borderSide: border
                ? BorderSide(color: Colors.teal.withOpacity(.3))
                : BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
          // enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: const EdgeInsets.all(12),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.grey),
          floatingLabelStyle: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 18),
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal.withOpacity(.2)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
