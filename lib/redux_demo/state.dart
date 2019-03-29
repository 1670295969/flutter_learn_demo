class CountState {
  final int _count;

  get count => _count;

  CountState(this._count);

  CountState.initState() : _count = 0;
}

enum Action{
  increment
}

CountState reducer(CountState state,action){
  if(action == Action.increment){
    return CountState(state._count+1);
  }
  return state;
}



