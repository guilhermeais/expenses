import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  final Function(String title, double value) onSubmit;
  TransactionForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Título"),
              controller: _titleController,
            ),
            TextField(
              controller: _valueController,
              decoration: const InputDecoration(labelText: "Valor (R\$)"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      onSubmit(_titleController.text, double.tryParse(_valueController.text)??0.0 );
                    },
                    child: const Text(
                      'Nova Transação',
                      style: TextStyle(color: Colors.purple),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
