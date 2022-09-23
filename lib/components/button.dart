import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({ 
    Key? key, 
    required this.text, 
    required this.action, 
    Color? this.backgroundColor 
  }) : super(key: key);

  final String text;
  final Function action;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: (
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            primary: Colors.white,
            textStyle: const TextStyle(
              fontSize: 20,
            ),
            backgroundColor: backgroundColor ?? const Color(0xff50665a)
          ),
          onPressed: () {
            action();
          },
          child: FractionallySizedBox(
            widthFactor: 1,
            child: Text(
              text,
              textAlign: TextAlign.center
            )
          ),
        )
      ),
    );
  }
}