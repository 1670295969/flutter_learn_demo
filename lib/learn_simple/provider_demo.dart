import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderCounter with ChangeNotifier {
  int _count = 0;

  int get value => _count;


  void inc() {
    _count++;
    notifyListeners();
  }


}


void main() {
  runApp(
      ChangeNotifierProvider(builder:(_)=> ProviderCounter(),
        child: CountApp(),)
  );
}


class CountApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "provider",
      home:CountHome(),
    );
  }
}

class CountHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CountHomeState();
  }

}

class _CountHomeState extends State<CountHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("provider"),

      ),
      body: Consumer<ProviderCounter>(builder: (_, count, w) {
        return Text("${count.value}");
      }),

      floatingActionButton: FloatingActionButton(onPressed: Provider
          .of<ProviderCounter>(context)
          .inc,
        child: Icon(Icons.add),),


    );
  }

}







