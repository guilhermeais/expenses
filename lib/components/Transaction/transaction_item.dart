import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.tr,
    required this.onDelete,
  }) : super(key: key);

  final Transaction tr;
  final void Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
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
              backgroundColor: Theme.of(context).colorScheme.primary,
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
            trailing: MediaQuery.of(context).size.width > 400
                ? TextButton.icon(
                    onPressed: () {
                      onDelete(tr.id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    label: Text(
                      "Excluir",
                      style: TextStyle(
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      onDelete(tr.id);
                    },
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                  )),
      ),
    );
  }
}