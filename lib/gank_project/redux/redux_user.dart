import 'package:flutter_app/gank_project/bean/github_user.dart';
import 'package:redux/redux.dart';

final combineUserReducer = combineReducers<User>([
  TypedReducer<User, UpDateUserAction>(_updateLoaded),
]);

User _updateLoaded(User user, action) {
  user = action.userInfo;
  return user;
}

class UpDateUserAction {
  final User userInfo;

  UpDateUserAction(this.userInfo);
}
