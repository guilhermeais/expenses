import 'package:expenses/components/adaptatives/adaptative_button.dart';
import 'package:expenses/components/adaptatives/adaptative_date_picker.dart';
import 'package:expenses/components/adaptatives/adaptative_text_field.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  _onDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    // _submitForm();
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
              AdaptativeTextField(
                label: "Título",
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptativeTextField(
                controller: _valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              
                label: "Valor (R\$)",
              ),
              AdaptativeDatePicker(
                onDateChanged: _onDateChanged,
                selectedDate: _selectedDate,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                    onPressed: _submitForm,
                    label: '${false ? 'Editar' : 'Adicionar'} Transação',
                  )
                  // ElevatedButton(
                  //     onPressed: _submitForm,
                  //     child: Text(
                  //       '${false ? 'Editar' : 'Adicionar'} Transação',
                  //       style: Theme.of(context).textTheme.button,
                  //     ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
