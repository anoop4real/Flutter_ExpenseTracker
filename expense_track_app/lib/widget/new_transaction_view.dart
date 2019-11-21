import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactionView extends StatefulWidget {
  final Function callback;

  NewTransactionView({this.callback});

  @override
  _NewTransactionViewState createState() => _NewTransactionViewState();
}

class _NewTransactionViewState extends State<NewTransactionView> {
  final titleEditingController = TextEditingController();

  final amountEditinController = TextEditingController();

  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return _buildUserInputCard(context);
  }

  Widget _buildUserInputCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          _buildTextInputWith('Title', titleEditingController),
          _buildTextInputWith('Enter Amount', amountEditinController),
          _buildDateInput(context),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              'Add Transaction',
              style: TextStyle(color: Theme.of(context).textTheme.button.color),
            ),
            onPressed: () {
              _addData(titleEditingController.text, amountEditinController.text, _selectedDate);
            },
          )
        ],
      ),
    );
  }

  void _addData(String title, String amount, DateTime date ){
    if (title.isEmpty || amount.isEmpty || date == null){
      return;
    }
    widget.callback(title,
        double.parse(amount), date);
    Navigator.of(context).pop();
  }
  Widget _buildTextInputWith(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hint,
      ),
    );
  }

  Widget _buildDateInput(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(_selectedDate == null ? 'Select the date': DateFormat('dd-MMM-yyyy').format(_selectedDate)),
          FlatButton(
            textColor: Theme.of(context).primaryColor,
            child: Text('Choose date'),
            onPressed: () {
              _showDatePicker(context);
            },
          )
        ],
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((selectedDate) {
      if (selectedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = selectedDate;
      });

    });
  }
}
