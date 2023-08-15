import 'package:flutter/material.dart';
import 'package:tast/models/product_model.dart';

import '../views/search_page.dart';

class SearchBuilder extends StatelessWidget {
  const SearchBuilder({
    Key? key,
    this.onTap,
  }) : super(key: key);
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 40,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        onTap: () {
          showSearch<List<ProductModel>>(
            context: context,
            delegate: ProductSearchDelegate(),
          );
        },
        cursorColor: Colors.black,
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 16.0),
        decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(bottom: 10),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.black, fontSize: 16.0),
            icon: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.search_rounded,
                color: Colors.black,
              ),
            )),
      ),
    );
  }
}
