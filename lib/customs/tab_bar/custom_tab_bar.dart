import 'package:flutter/material.dart';
import '../../app/app_config.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {super.key, required this.controller, required this.categories});
  final TabController controller;
  final List<String> categories;
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      unselectedLabelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.black.withOpacity(0.3),
      isScrollable: true,
      indicatorColor: Colors.red,
      indicatorWeight: 8,
      indicator: BoxDecoration(
        color: Colors.transparent,
        border: Border(
            bottom: BorderSide(color: Colors.black.withOpacity(0.3), width: 2)),
      ),
      tabs: categories
          .map(
            (item) => Tab(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    // color: AppConfiguration.primaryColor,
                    color: Colors.black26,
                    border: Border.all(),
                    borderRadius:
                        BorderRadius.circular(AppConfiguration.borderRadius)),
                child: categoriesBuilder(item.toString()),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget categoriesBuilder(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
    );
  }
}
