import 'package:flutter/material.dart';

class DialogItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  const DialogItem({Key key, this.icon, this.color, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 26,
            color: color,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(text),
          )
        ],
      ),
    );
  }
}
