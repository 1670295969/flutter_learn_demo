import 'package:rxdart/rxdart.dart';

class GlobalBloc {
  BehaviorSubject<String> _controller = BehaviorSubject<String>();

  Function(String) get push => _controller.sink.add;

  Stream<String> get stream => _controller.stream;

  static final GlobalBloc _bloc = GlobalBloc._internal();

  GlobalBloc._internal();

  factory GlobalBloc() {
    return _bloc;
  }

  void dispose(){
    _controller.close();
  }

  GlobalBloc globalBloc = GlobalBloc();


}
