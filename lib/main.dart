import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/edittext.dart';
import 'package:flutter_app/listdata.dart';
import 'package:flutter_app/simple.dart';
import 'dart:ui';


void main() => runApp(ListApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: RandomWords(),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordsStatus();
  }
}

class RandomWordsStatus extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          final tiles = _saved.map(
                  (pair) {
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              });

          final divided = ListTile
              .divideTiles(
              context: context,
              tiles: tiles
          )
              .toList();

          return Scaffold(
            appBar: AppBar(
              title: Text("Saved Suggesttions"),
            ),
            body: ListView(children: divided,),
          );
        })
    );
  }


//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text("flutter"),
//        actions: <Widget>[
//          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved,)
//        ],
//      ),
//      body: _buildSuggestions(),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("flutter"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved,)
        ],
      ),
      body: MessageForm(),
    );
  }

}


