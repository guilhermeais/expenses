import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function(String title, double value, DateTime date) onSubmit;
  final Transaction? edit;
  TransactionForm({Key? key, required this.onSubmit, this.edit})
      : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final _valueController = TextEditingController();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    if (title.isEmpty) return;
    if (value <= 0) return;
    if (_selectedDate == null) return;

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
        // _submitForm();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
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
                  _showDatePicker();
                },
                decoration: const InputDecoration(labelText: "Valor (R\$)"),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate != null
                          ? 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}'
                          : 'Nenhuma data selecionada!'),
                    ),
                    TextButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        'Selecionar Data',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(
                        '${false ? 'Editar' : 'Adicionar'} Transação',
                        style: Theme.of(context).textTheme.button,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
