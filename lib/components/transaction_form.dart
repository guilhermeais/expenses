import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Function(String title, double value, String? id) onSubmit;
  final Transaction? edit;
  TransactionForm({Key? key, required this.onSubmit, this.edit})
      : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    if (title.isEmpty) return;
    if (value <= 0) return;
    widget.onSubmit(title, value, null);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              '${false ? 'Editando' : 'Adicionando'} Transação',
              style: Theme.of(context).textTheme.headline6,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Título"),
              controller: _titleController,
            ),
            TextField(
              controller: _valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) {
                _submitForm();
              },
              decoration: const InputDecoration(labelText: "Valor (R\$)"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: _submitForm,
                    child: Text(
                      '${false ? 'Editar' : 'Adicionar'} Transação',
                      style: const TextStyle(color: Colors.purple),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
