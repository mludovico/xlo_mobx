import 'package:flutter/material.dart';

class ChipButton<T> extends StatelessWidget {
  ChipButton(this.label, this.value, this.groupValue, this.onTap);
  final String label;
  final T value;
  final T groupValue;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: groupValue == value ? Colors.purple : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.purple,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: 50,
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: groupValue == value ? Colors.white : Colors.purple,
          ),
        ),
      ),
    );
  }
}
