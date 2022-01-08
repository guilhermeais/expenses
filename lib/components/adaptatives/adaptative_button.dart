import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  AdaptativeButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label),
            onPressed: onPressed,
            padding: const EdgeInsets.symmetric(horizontal: 20),
          )
        : ElevatedButton(
            child: Text(label),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.primary),
              textStyle: MaterialStateProperty.all(
                  TextStyle(color: Theme.of(context).textTheme.button!.color)),
            ),
            onPressed: onPressed,
          );
  }
}
