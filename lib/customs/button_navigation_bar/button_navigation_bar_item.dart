import 'package:flutter/material.dart';
import 'package:tast/app/app_config.dart';

class CustomButtomNavItemBar {
  static BottomNavigationBarItem childBottomNavBar(
      {String? label, IconData? icon, bool? current}) {
    return BottomNavigationBarItem(
      tooltip: label,
      label: '',
      // backgroundColor: Colors.red,
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // margin: const EdgeInsets.only(left: 15, right: 4, top: 15),
                padding: const EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: current == false
                      ? Colors.white10
                      : AppConfiguration.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 6),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: current!
                          ? AppConfiguration.primaryColor.withOpacity(0.5)
                          : Colors.white,
                      child: Icon(
                        icon,
                        size: 22,
                        color: current == false ? Colors.grey : Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Visibility(
                      visible: current,
                      child: Expanded(
                        child: Text(
                          label!,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // replacement: Text(label),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
