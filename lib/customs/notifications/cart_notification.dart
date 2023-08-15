import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:tast/functions/func_callBack.dart';
import '../../app/app_config.dart';

class CartNotification extends StatelessWidget {
  const CartNotification({
    Key? key,
    this.onTap,
    this.backgroundColor,
    this.height,
    this.width,
    this.value,
    this.iconColor,
    this.icon,
  }) : super(key: key);
  final CallBack? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? height;
  final double? width;
  final int? value;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Container(
          height: height ?? 40,
          width: width ?? 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: backgroundColor ?? AppConfiguration.bgColor,
              borderRadius: BorderRadius.circular(50)),
          child: badges.Badge(
            stackFit: StackFit.loose,
            showBadge: value == null || value! <= 0 ? false : true,
            ignorePointer: true,
            badgeContent: Text(
              "",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: value! <= 9 ? 12 : 10,
                  fontWeight: FontWeight.bold),
            ),
            child: Icon(
              icon ?? Icons.shopping_cart_outlined,
              color: iconColor ?? Colors.grey,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
