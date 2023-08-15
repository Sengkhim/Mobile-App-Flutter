import 'package:flutter/material.dart';
import 'package:tast/app/app_config.dart';
import 'package:tast/models/product_model.dart';
import 'package:tast/views/details/product_detail.dart';
import '../functions/func_callBack.dart';
import 'buttons/favorite_buttom.dart';

class ProductContainer extends StatelessWidget {
  const ProductContainer({super.key, required this.product, this.callBack});
  final ProductModel product;
  final CallBack? callBack;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product)));
      },
      child: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: AppConfiguration.bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///product image
            Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              children: [
                Container(
                  height: 170,
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(product.image!),
                      )),
                ),
                //faovite
                FavoriteButton(callBack: callBack),
              ],
            ),

            ///Name, description and price of product
            textBuilder(
                title: product.title.toString(),
                description: product.description.toString(),
                price: product.price.toString())
          ],
        ),
      ),
    );
  }

  Widget textBuilder({
    required String title,
    required String description,
    required String price,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            overflow: TextOverflow.ellipsis,
            style:
                TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            "\$$price",
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
