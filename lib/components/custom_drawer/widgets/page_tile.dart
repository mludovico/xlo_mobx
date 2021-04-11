import 'package:flutter/material.dart';

class PageTile extends StatelessWidget {

  final String label;
  final IconData iconData;
  final VoidCallback onTap;
  final bool highlighted;

  PageTile({this.label, this.iconData, this.onTap, this.highlighted});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          color: highlighted ? Colors.purple : Colors.black54,
        ),
      ),
      leading: Icon(
        iconData,
        color: highlighted ? Colors.purple : Colors.black54,
      ),
      onTap: onTap,
    );
  }
}
