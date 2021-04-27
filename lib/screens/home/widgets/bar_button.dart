import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {
  BarButton({this.label, this.onTap});

  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
              color: Colors.white,
              width: 1,
              style: BorderStyle.solid,
            )),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
