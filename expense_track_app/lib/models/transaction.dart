import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
class Transaction {
  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
  // TODO (Assert): Assert mandatory values.

  final String id;
  final String title;
  final double amount;
  final DateTime date;

  String formattedAmount(){
    return  '${this.amount}\$';
  }

  String formattedDate(){
    return DateFormat('dd-MMM-yyyy').format(this.date);
  }

  // TODO (Implement): Create and add currency
}
