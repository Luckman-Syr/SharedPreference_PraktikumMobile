// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFields extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  const TextFields({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
  }) : super(key: key);

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  @override
  Widget build(BuildContext context) {
    final _controller = widget.controller;
    // String? text;
    return Container(
      padding: EdgeInsets.all(1),
      child: TextFormField(
        obscureText: widget.obscureText,
        style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 15)),
        decoration: InputDecoration(
          hintStyle: GoogleFonts.nunitoSans(fontSize: 15.0),
          hintText: widget.hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(7.0)),
          filled: true,
        ),
        controller: _controller,
      ),
    );
  }
}
