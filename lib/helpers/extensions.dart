import 'package:intl/intl.dart';

extension StringExtension on String {
  bool isEmailValid() {
    final RegExp regex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(this);
  }
}

extension NumberExtension on num {
  String formattedMoney() {
    return NumberFormat('R\$ ###,##0.00', 'pt_BR').format(this);
  }
}

extension DateTimeExtension on DateTime {
  String toDMHm() {
    return DateFormat('dd/MM/yyyy HH:mm', 'pt-BR').format(this);
  }
}
