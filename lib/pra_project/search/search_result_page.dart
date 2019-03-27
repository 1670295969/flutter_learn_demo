

import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget{


  String searchKey;

  SearchResultPage(ValueKey<String> key):super(key:key){
    searchKey = key.value;
  }




  @override
  State<StatefulWidget> createState() {
    return _SearchResultPageState();
  }

}


class _SearchResultPageState extends State<SearchResultPage>{
  @override
  Widget build(BuildContext context) {
    return null;
  }

}