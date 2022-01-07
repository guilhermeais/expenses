import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

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
        ? Column(
            children: [
              Text(
                'Nenhuma Transação Cadastrada',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (BuildContext ctx, int index) {
              final tr = transactions[index];
              return TextButton(
                onPressed: () {
                 // onEdit(tr.id, index);
                },
                child: Card(
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            Theme.of(context).colorScheme.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                              child: Text(
                            'R\$${tr.value}',
                            style: const TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                      title: Text(
                        tr.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                      trailing: IconButton(
                        onPressed: () {
                          onDelete(tr.id);
                        },
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                      )),
                ),
              );
            },
          );
  }
}
