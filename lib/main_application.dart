import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tast/controllers/prouct_controller.dart';
import 'views/slash_screen.dart';

class MainApplication extends StatefulWidget {
  const MainApplication({super.key});

  @override
  State<MainApplication> createState() => _MainApplicationState();
}

class _MainApplicationState extends State<MainApplication> {
  @override
  void initState() {
    Provider.of<ProductController>(context, listen: false)
        .fetchAllCategoies()
        .then((value) {
      setState(() {
        // _current = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: const MainPage(),
      // home: _current == false ? const SlashScreen() : const HomePage(),
      home: const SlashScreen(),
      // home: MyWidget,
    );
  }
}
