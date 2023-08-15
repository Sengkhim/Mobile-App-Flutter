import 'package:flutter/material.dart';
import 'package:tast/models/product_model.dart';
import 'package:tast/views/details/product_detail.dart';
import '../../app/app_config.dart';

class ResultSearchPd extends StatelessWidget {
  const ResultSearchPd({super.key, this.productModel});
  final ProductModel? productModel;
  @override
  Widget build(BuildContext context) {
    return _elementBody(context);
  }

  Widget _elementImage() {
    return Container(
      // padding: const EdgeInsets.all(10),
      width: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppConfiguration.bgColor,
        image: DecorationImage(
          isAntiAlias: true,
          filterQuality: FilterQuality.high,
          fit: BoxFit.contain,
          image: NetworkImage(productModel!.image!),
        ),
      ),
    );
  }

  Widget _elementBody(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductDetailPage(product: productModel)));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            _elementImage(),
            Expanded(
              // width: 250,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productModel!.title!,
                        overflow: TextOverflow.ellipsis,
                        style: Style.titleStyles(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text(productModel!.description!,
                        overflow: TextOverflow.ellipsis,
                        style: Style.titleStyles(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey)),
                    const SizedBox(height: 8),
                    Text("\$${productModel!.price.toStringAsFixed(2)}",
                        overflow: TextOverflow.ellipsis,
                        style: Style.titleStyles(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
