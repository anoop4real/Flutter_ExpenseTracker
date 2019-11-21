import 'package:expense_track_app/models/transaction.dart';
import 'package:expense_track_app/widget/chart.dart';
import 'package:expense_track_app/widget/new_transaction_view.dart';
import 'package:expense_track_app/widget/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chart_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _transactions = _createTransactionData();

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }
  void _openNewTransactionView(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
              color: Color(0xFF737373),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.red,
                        offset: Offset(0.5, 0.5),
                        blurRadius: 10.0
                      )
                    ],
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))
                ),
                child: NewTransactionView(callback: _createNewTransaction)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildContainerView(context);
  }

  Widget _buildContainerView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _openNewTransactionView(context);
            },
          )
        ],
      ),
      body: _buildColumn(),
    );
  }

  Widget _buildColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 200,
          child: Card(
            child: ChartView(_recentTransactions),
            elevation: 5,
          ),
        ),
        Expanded(child: TransactionListView(transactions: this._transactions, deleteCallback: this._deleteTransaction,))
      ],
    );
  }

  static List<Transaction> _createTransactionData() {
    List<Transaction> transactions = [
      /*
      Transaction(
          title: 'New Transaction',
          date: DateTime.now(),
          amount: 45.6,
          id: 'QWSDD'),
      Transaction(
          title: 'New Transaction',
          date: DateTime.now(),
          amount: 45.6,
          id: 'QWSDD'),
      Transaction(
          title: 'New Transaction',
          date: DateTime.now(),
          amount: 45.6,
          id: 'QWSDD')

       */
    ];
    return transactions;
  }

  void _createNewTransaction(String title, double amount, DateTime selectedDate) {
    final newTransaction = Transaction(
        title: title,
        amount: amount,
        id: DateTime.now().toString(),
        date: selectedDate);
    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _transactions.removeWhere((tx){return tx.id == id;} );
    });
  }
}
