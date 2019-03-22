import 'package:flutter/material.dart';

class Simple1Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "simple UI",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Top Lakes"),
        ),
        body: ListView(
          children: <Widget>[
            headImage(),
            _TitleSection("haha", "123", "60"),
            buttonSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonColumn(BuildContext context, IconData icon, String label) {
    final color = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: color,
        ),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12.0, fontWeight: FontWeight.w400, color: color),
          ),
        )
      ],
    );
  }

  Widget buttonSection(BuildContext context) => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildButtonColumn(context, Icons.call, 'CALL'),
            _buildButtonColumn(context, Icons.near_me, 'ROUTE'),
            _buildButtonColumn(context, Icons.share, 'SHARE'),
          ],
        ),
      );

  Widget headImage() {
    return Image.asset(
      "images/lake.png",
      width: 600.0,
      height: 240.0,
      fit: BoxFit.cover,
    );
  }
}

class _TitleSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final String starCount;

  _TitleSection(this.title, this.subtitle, this.starCount);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(32.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text(starCount.toString())
        ],
      ),
    );
  }
}
