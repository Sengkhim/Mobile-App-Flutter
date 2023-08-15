import 'package:flutter/cupertino.dart';
import 'package:tast/controllers/base_controller.dart';

class BaseWidget<T extends BaseController> extends StatelessWidget {
  const BaseWidget(
      {super.key,
      this.controller,
      this.activeWidget,
      this.waitingWidget,
      this.doneWidget,
      this.future});
  final T? controller;
  final Widget? activeWidget;
  final Widget? waitingWidget;
  final Widget? doneWidget;
  final Future? future;
  @override
  Widget build(BuildContext context) {
    // var controller =
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return _connectionState();
            case ConnectionState.waiting:
              return SliverToBoxAdapter(child: waitingWidget!);
            case ConnectionState.active:
              return SliverToBoxAdapter(child: activeWidget!);
            case ConnectionState.done:
              return doneWidget!;
            default:
              return const SliverToBoxAdapter(
                child: SizedBox(),
              );
          }
        } else {
          return const SliverToBoxAdapter(
            child: SizedBox(),
          );
        }
      },
    );
  }

  Widget _connectionState() {
    return Container(
      alignment: Alignment.center,
      height: 100,
      width: double.infinity,
      child: const Text("Connection is offine"),
    );
  }
}
