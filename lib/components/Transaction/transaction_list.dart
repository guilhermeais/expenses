import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import '../../models/transaction.dart';
import 'package:intl/intl.dart';

import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final void Function(String id, int index) onEdit;
  final void Function(String id) onDelete;

  const TransactionList(
      {Key? key,
      required this.transactions,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Container(
                    height: constraints.maxHeight * .3,
                    child: Text(
                      'Nenhuma Transação Cadastrada',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: constraints.maxHeight * .5,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (BuildContext ctx, int index) {
              final tr = transactions[index];
              return TransactionItem(
                tr: tr,
                onDelete: onDelete,
                key: Key(index.toString()),
              );
            },
          );
  }
}


