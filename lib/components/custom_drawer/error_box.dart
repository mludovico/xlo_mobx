import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {

  final String message;

  ErrorBox({this.message});

  @override
  Widget build(BuildContext context) {
    if (message == null)
      return Container();
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      color: Color(0xffffaaaa),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.white,
            size: 40,
          ),
          Expanded(
            child: Text(
              'Oops! $message. Por favor tente novamente',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
