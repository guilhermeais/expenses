import 'dart:math';
import 'dart:io';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.purple, accentColor: Colors.amber),
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    // if (id != null && id.isNotEmpty) {
    //   final idxEdited = _transactions.indexWhere((element) => element.id == id);
    //   if (idxEdited > -1) {
    //     setState(() {
    //       _transactions[idxEdited].title = title;
    //       _transactions[idxEdited].value = value;
    //     });
    //   }
    // } else
    {
      final newTrasaction = Transaction(
          id: Random().nextDouble().toString(),
          title: title,
          value: value,
          date: date);

      setState(() {
        _transactions.add(newTrasaction);
      });
    }

    Navigator.of(context).pop();
  }

  // _editTransaction(String id, int index, BuildContext context) {
  //   final findedTransaction =
  //       _transactions.firstWhere((element) => element.id == id);
  //   if (findedTransaction.id.isNotEmpty) {
  //     _openTransactionFormModal(context, findedTransaction);
  //   }
  // }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(
      BuildContext context, Transaction? editingTransaction) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(
              onSubmit: _addTransaction, edit: editingTransaction);
        });
  }

  Widget _getIconButton(IconData icon, Function() fn, String? tooltip) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(
            onPressed: fn,
            icon: Icon(icon),
            tooltip: tooltip,
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.list_bullet : Icons.list;
    final chartIcon =
        Platform.isIOS ? CupertinoIcons.chart_bar_alt_fill : Icons.show_chart;

    final actions = [
      if (isLandscape)
        _getIconButton(
            _showChart ? iconList : chartIcon,
            () => setState(() {
                  _showChart = !_showChart;
                }),
            "Muda a forma de exibição da lista/gráfico."),
      _getIconButton(Platform.isIOS ? CupertinoIcons.add : Icons.add,
          () => _openTransactionFormModal(context, null), null),
    ];

    final Widget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text("Despesas Pessoais"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(
            title: const Text("Despesas Pessoais"),
            actions: actions,
          );
    final availableHeigth = mediaQuery.size.height -
        (appBar as PreferredSizeWidget).preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_showChart || !isLandscape)
            SizedBox(
              height: availableHeigth * (isLandscape ? .6 : .3),
              child: Chart(recentTransactions: _recentTransactions),
            ),
          if (!_showChart || !isLandscape)
            SizedBox(
              height: availableHeigth * (isLandscape ? .7 : .7),
              child: TransactionList(
                transactions: _transactions,
                onDelete: _deleteTransaction,
                onEdit: (String id, int index) {
                  // _editTransaction(id, index, context);
                },
              ),
            ),
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Despesas Pessoais'),
              // trailing: Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: actions,
              // ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () {
                      _openTransactionFormModal(context, null);
                    },
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
