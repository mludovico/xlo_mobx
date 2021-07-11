import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  final String text;

  const EmptyCard({Key key, this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Icon(
              Icons.border_clear,
              size: 200,
              color: Colors.purple,
            ),
          ),
          Divider(),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Hmmmm...',
                  style: TextStyle(color: Colors.orange, fontSize: 18),
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
