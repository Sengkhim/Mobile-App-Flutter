import 'package:flutter/material.dart';
import 'package:tast/customs/button_navigation_bar/button_navigation_bar_item.dart';
import '../controllers/widgets/widgets_controller.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<WidgetsController>(context);
    return Scaffold(
      body: controller.widget.elementAt(controller.currentPage as int),
      bottomNavigationBar: bottomNavBarBuilder(controller),
    );
  }

  Widget bottomNavBarBuilder(WidgetsController controller) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        CustomButtomNavItemBar.childBottomNavBar(
            label: "Home",
            icon: Icons.home,
            current: controller.actionNavigation(0)),
        CustomButtomNavItemBar.childBottomNavBar(
            label: "Favorite",
            icon: Icons.favorite_sharp,
            current: controller.actionNavigation(1)),
        CustomButtomNavItemBar.childBottomNavBar(
            label: "Profile",
            icon: Icons.supervised_user_circle,
            current: controller.actionNavigation(2)),
      ],
      elevation: 5,
      enableFeedback: true,
      // fixedColor: Colors.red,
      // unselectedFontSize: 24,
      currentIndex: controller.currentPage as int,
      selectedItemColor: Colors.orangeAccent,
      unselectedItemColor: Colors.grey,
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
      showUnselectedLabels: true,
      // selectedIconTheme: const IconThemeData(color: Colors.orangeAccent),
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
      showSelectedLabels: true,
      onTap: (index) {
        controller.onChangePage(index);
        controller.actionNavigation(index);
      },
    );
  }
}
