import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CityModel extends Model {
  String currentCity = "";

  void setCurrentCity(String city) {
    if (currentCity != city) {
      currentCity = city;
      notifyListeners();
    }
  }

  static CityModel of(BuildContext context) =>
      ScopedModel.of<CityModel>(context);
}

void main() => runApp(ModelApp());

class ModelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ModelWidget(),
    );
  }
}

class ModelWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ModelWidgetState();
  }
}

class ModelWidgetState extends State<ModelWidget> {
  CityModel cityModel = CityModel();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModel(
        model: cityModel,
        child: ScopeChild(),
      ),
    );
  }
}

class ScopeChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 100,
          child: ScopedModelDescendant<CityModel>(
              builder: (context, child, model) {
                return Text(model.currentCity);
              }),
        ),
        RaisedButton(

          onPressed: () {
            print("${index}");
            CityModel.of(context).setCurrentCity("${index++}");
          },
          child: Text("$index"),
        ),
      ],
    );
  }

}








