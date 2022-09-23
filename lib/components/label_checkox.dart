import 'package:flutter/material.dart';

class LabelCheckbox extends StatelessWidget {
  LabelCheckbox({ 
    Key? key, 
    required this.value, 
    required this.onValueChange, 
    required this.alignHorizontal, 
    required this.label 
  }) : super(key: key);

  final bool alignHorizontal;
  final bool value;
  final Function onValueChange;
  final String label;

  var textStyle = const TextStyle(
    fontSize: 16
  );

  @override
  Widget build(BuildContext context) {
    if(alignHorizontal) {
      return Row(
        children: <Widget>[
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              activeColor: const Color(0xFF50665a),
              onChanged: (checked) {
                onValueChange(checked);
              },
              value: value,
            ),
          ),
          const SizedBox(
            width: 10
          ),
          Text(
            label,
            style: textStyle
          )
        ]
      );
    }
    else {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                activeColor: const Color(0xFF50665a),
                onChanged: (checked) {
                  onValueChange(checked);
                },
                value: value
              ),
            ),
            Text(
              label,
              style: textStyle
            )
          ]
        );
      }
    }
}