import 'package:flutter/material.dart';

class MessageForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MessageFormState();
  }
}

class _MessageFormState extends State<MessageForm> {
  var editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: editController,
          ),
        ),
        RaisedButton(
          child: Text("click"),
          onPressed: () => showTxtDialog(),
        )
      ],
    );
  }

  showTxtDialog() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: Text(editController.text),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    editController.dispose();
  }
}
