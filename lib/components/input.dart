import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({ Key? key, required this.hintText, required this.onChange }) : super(key: key);

  final String hintText;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return (
      TextFormField(
        decoration: InputDecoration(
          fillColor: const Color.fromRGBO(255, 255, 255, 0.3),
          filled: true,
          labelStyle: TextStyle(
            color: Colors.grey[600]
          ),
          hintStyle: TextStyle(
            color: Colors.grey[600]
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 0.0,
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1.0,
            )
          ),
          hintText: hintText
        ),
        validator: (value) {
          return value;
        },
        onChanged: (value) {

        }
      )
    );
  }
}