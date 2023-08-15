import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tast/controllers/base_controller.dart';
import 'package:tast/controllers/widgets/widgets_controller.dart';
import 'package:tast/services/product_service.dart';
import 'controllers/prouct_controller.dart';
import 'main_application.dart';

void main() {
  ProductService service = ProductService();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => BaseController()),
    ChangeNotifierProvider(create: (context) => WidgetsController()),
    ChangeNotifierProvider(create: (context) => ProductController(service)),
  ], child: const MainApplication()));
}
