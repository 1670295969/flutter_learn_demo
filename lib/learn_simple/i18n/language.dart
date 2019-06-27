abstract class BaseLanguage {
//  'task title': 'Flutter Demo',
//  'titlebar title': 'Flutter Demo Home Page',
//  'click tip': 'You have pushed the button this many times:',
//  'inc':'Increment'
  String task_title;
  String title_bar_title;
  String click_tip;
  String inc;
}

class EnLanguage extends BaseLanguage {
  @override
  String task_title = "Flutter Demo";
  @override
  String title_bar_title = "Flutter Demo Home Page";
  @override
  String click_tip = "You have pushed the button this many times:";
  @override
  String inc = "Increment";
}

class ChLanguage extends BaseLanguage {

  @override
  String task_title = "Flutter 示例";
  @override
  String title_bar_title = "Flutter 示例主页面";
  @override
  String click_tip = "你一共点击了这么多次按钮：";
  @override
  String inc = "增加";

}
