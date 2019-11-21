import 'package:expense_track_app/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionListView extends StatelessWidget {
  final List<Transaction> transactions;
  Function deleteCallback;
  TransactionListView({this.transactions, this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    return _buildTransactionListWith(context, transactions);
  }

  Widget _buildTransactionListWith(
      BuildContext context, List<Transaction> transactions) {
    return transactions.isEmpty
        ? Center(
            child: Text(
              'No expenses added yet',
              style: Theme.of(context).textTheme.title,
            ),
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                child: _buidListTile(transactions[index], context),
              );

            });
  }

  Widget _buidListTile(Transaction transaction, BuildContext context) {
    return ListTile(
      trailing: IconButton(icon:Icon(Icons.delete, color: Theme.of(context).primaryColor,), onPressed: (){
        deleteCallback(transaction.id);
      },),
      leading: CircleAvatar(
        radius: 30 ,
          child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            transaction.formattedAmount(),
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          ),
        ),
      )),
      title: Text(
        transaction.title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(transaction.formattedDate(),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
          overflow: TextOverflow.ellipsis),
    );
  }

  Widget _buildCardItem(Transaction transaction, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 100,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                    style: BorderStyle.solid)),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                transaction.formattedAmount(),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  transaction.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(transaction.formattedDate(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          )
        ],
      ),
    );
  }
}
