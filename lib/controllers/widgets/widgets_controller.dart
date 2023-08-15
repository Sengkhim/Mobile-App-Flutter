import 'package:flutter/cupertino.dart';
import '../../views/favorite_page.dart';
import '../../views/home_page.dart';
import '../../views/proflie_page.dart';
import '../base_controller.dart';

class WidgetsController extends BaseController {
  final List<Widget> _widgets = <Widget>[
    const HomePage(),
    const FavoritePage(),
    const ProfilePage()
  ];
  num _currentPage = 0;
  num get currentPage => _currentPage;
  bool visible = false;
  List<Widget> get widget => _widgets;

  void visibility(bool value) {
    visible = value;
    updateChange();
  }

  void onChangePage(num index) {
    _currentPage = index;
    updateChange();
  }

  bool actionNavigation(int index) {
    if (index == _currentPage) return true;
    return false;
  }
}
