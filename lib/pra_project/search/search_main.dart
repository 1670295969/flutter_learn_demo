

import 'package:flutter/material.dart';
import 'package:flutter_app/pra_project/search/default_search_page.dart';
import 'package:flutter_app/pra_project/search/search_result_page.dart';

class SearchMain extends StatefulWidget{


  static push(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
      return SearchMain();
    }));


  }


  @override
  State<StatefulWidget> createState() {
    return _SearchMainState();
  }

}

class _SearchMainState extends State<SearchMain>{

  TextEditingController _searchController = TextEditingController();
  TextField _searchWidget;

  void _submit(String search){

  }

  @override
  void initState() {
    super.initState();
    _searchWidget = TextField(
    autofocus: true,
    textInputAction: TextInputAction.search,
    controller: _searchController,
    onSubmitted: _submit,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "搜索",
        hintStyle: TextStyle(color: Colors.white)
      ),
    );
  }

  _clearSearch(){
    setState(() {
      _searchController.clear();
    });

  }
  _changeSearchContent(){

  }
  _body(){

    if(_searchController.text == null || _searchController.text.isEmpty){
      return Center(
        child: DefaultSearchPage(),
      );
    }else{
      return SearchResultPage(ValueKey(_searchController.text));
    }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title :_searchWidget,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _changeSearchContent,
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: _clearSearch,
          )
        ],
      ),
      body: _body(),


    );
  }

}

