import 'package:flutter/material.dart';
import '../../app/app_config.dart';
import '../../functions/func_callBack.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    this.callBack,
  }) : super(key: key);
  final CallBack? callBack;
  @override
  Widget build(BuildContext context) {
    // ProductController controller = Provider.of(context, listen: false);
    return Container(
      height: 35,
      width: 35,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey.withOpacity(0.7)),
      child: IconButton(
        iconSize: 20,
        splashColor: AppConfiguration.bgColor,
        alignment: Alignment.center,
        focusColor: AppConfiguration.bgColor,
        highlightColor: AppConfiguration.bgColor,
        hoverColor: AppConfiguration.bgColor,
        disabledColor: AppConfiguration.bgColor,
        onPressed: callBack,
        icon: const Icon(Icons.favorite_border_sharp, color: Colors.black),
      ),
    );
  }
}
