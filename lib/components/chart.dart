import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = recentTransactions.fold(0, (previousValue, element) {
        bool sameDay = element.date.day == weekDay.day;
        bool sameMonth = element.date.month == weekDay.month;
        bool sameYear = element.date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          previousValue += element.value;
        }
        return previousValue;
      });

      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(
        0,
        (previousValue, element) =>
            previousValue + (element['value'] as double));
  }

  double _getPercentage(double value1, double value2) {
    if (value1 <= 0 && value2 <= 0) {
      return 0;
    }

    return value1 / value2;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...groupedTransactions
                .map((tr) => Flexible(
                      fit: FlexFit.tight,
                      child: ChartBar(
                        label: tr['day'] as String,
                        value: tr['value'] as double,
                        percentage: _getPercentage(
                            tr['value'] as double, _weekTotalValue),
                      ),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
