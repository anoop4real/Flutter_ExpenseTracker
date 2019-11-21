
import 'package:expense_track_app/models/chart_model.dart';
import 'package:expense_track_app/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class ChartView extends StatelessWidget{
  final List<Transaction> recentTransactions;


  ChartView(this.recentTransactions);

  List<ChartModel> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return
        ChartModel(DateFormat.E().format(weekDay).substring(0, 2), totalSum);
    }).reversed.toList();
  }

  /// Create one series with sample hard coded data.
  List<charts.Series<ChartModel, String>> _createSampleData() {
    final data = groupedTransactionValues;

    return [
      new charts.Series<ChartModel, String>(
        id: 'Expenses',
        areaColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault ,
        fillColorFn:(_, __) => charts.MaterialPalette.red.shadeDefault ,
        seriesColor: charts.MaterialPalette.red.shadeDefault,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (ChartModel expenses, _) => expenses.days,
        measureFn: (ChartModel expenses, _) => expenses.expenses,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final seriesList = _createSampleData();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: charts.BarChart(
        seriesList,
        animate: true,
      ),
    );
  }
}

