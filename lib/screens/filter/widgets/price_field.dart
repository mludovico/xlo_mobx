import 'package:brasil_fields/formatter/real_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceField extends StatelessWidget {
  PriceField(this.hint, this.onChanged, this.initialValue);
  final String hint;
  final Function(int) onChanged;
  final int initialValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          prefixText: 'R\$ ',
          border: OutlineInputBorder(),
          hintText: hint,
          isDense: true,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          RealInputFormatter(centavos: true),
        ],
        onChanged: (textValue) {
          onChanged(
              int.tryParse(textValue.replaceAll('.', '').replaceAll(',', '')));
        },
        initialValue: initialValue?.toString(),
      ),
    );
  }
}
