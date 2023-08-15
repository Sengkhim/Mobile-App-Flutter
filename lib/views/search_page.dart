import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tast/controllers/prouct_controller.dart';
import 'package:tast/models/product_model.dart';
import '../customs/widgets/search_product.dart';

class ProductSearchDelegate extends SearchDelegate<List<ProductModel>> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, []);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var controller = Provider.of<ProductController>(context);
    var products = controller.product
        .where((element) => element.title.toString().contains(query))
        .toList();
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 100,
          width: double.infinity,
          child: ResultSearchPd(productModel: products[index]),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var controller = Provider.of<ProductController>(context);
    List<ProductModel> products = controller.product;
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            query = products[index].title!;
            showResults(context);
          },
          child: SizedBox(
            height: 100,
            width: double.infinity,
            child: ResultSearchPd(productModel: products[index]),
          ),
        );
      },
    );
  }
}
