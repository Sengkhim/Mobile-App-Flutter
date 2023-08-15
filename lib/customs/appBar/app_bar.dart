import 'package:flutter/material.dart';

class AppBarBuilder extends StatelessWidget {
  const AppBarBuilder(
      {super.key,
      this.leading,
      this.title,
      this.trailing,
      this.contentPadding});
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding,
      leading: leading,
      title: title,
      trailing: trailing,
    );
  }
}
