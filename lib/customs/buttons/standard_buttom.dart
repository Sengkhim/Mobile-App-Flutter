import 'package:flutter/material.dart';
import 'package:tast/functions/func_callBack.dart';

class StandardButtom extends StatelessWidget {
  const StandardButtom({
    Key? key,
    this.title,
    this.icon,
    required this.onTap,
    this.padding,
    this.widget,
  }) : super(key: key);
  final Widget? widget;
  final String? title;
  final IconData? icon;
  final CallBack onTap;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: padding!,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          onPressed: onTap,
          child: Row(
            children: [
              const Spacer(),
              icon == null ? const SizedBox() : Icon(icon),
              // const SizedBox(width: 12),
              icon == null ? const SizedBox() : const Spacer(),
              Text(
                title ?? "",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 20),
              widget ?? const SizedBox(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
