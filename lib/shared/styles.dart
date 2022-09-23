import 'package:flutter/material.dart';

var textInputDecoration = InputDecoration(
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
      color: Colors.black,
      width: 1.0,
    )
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.black,
      width: 1.0,
    )
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.red,
      width: 1.0,
    )
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.red,
      width: 1.0,
    )
  ),
  hintText: "E-Mail"
);

var headline = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold
  );
var subHeadline = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold
);
var text = const TextStyle(
  fontSize: 16
);