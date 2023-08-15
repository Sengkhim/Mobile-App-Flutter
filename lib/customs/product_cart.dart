import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:tast/app/app_config.dart';
import 'package:tast/controllers/prouct_controller.dart';
import 'package:tast/models/product_model.dart';
import 'package:tast/views/details/product_detail.dart';

class ProductCart extends StatelessWidget {
  const ProductCart(
      {super.key, required this.product, this.isFavoite, this.caseOrder});
  final ProductModel product;
  final bool? isFavoite;
  final CaseOrder? caseOrder;
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProductController>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product)));
      },
      child: Slidable(
        key: UniqueKey(),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                controller.removeCart(product: product, caseOrder: caseOrder);
              },
              backgroundColor: Colors.white,
              foregroundColor: Colors.red,
              icon: Icons.delete_outline_outlined,
              label: 'Remove',
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              _elementImage(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.title!,
                          overflow: TextOverflow.ellipsis,
                          style: Style.titleStyles(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      Text(product.description!,
                          overflow: TextOverflow.ellipsis,
                          style: Style.titleStyles(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey)),
                      const SizedBox(height: 6),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                  "\$${controller.onCalulatedByItem(product)}",
                                  overflow: TextOverflow.ellipsis,
                                  style: Style.titleStyles(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ),
                            const SizedBox(width: 25),
                            Expanded(
                              child: Text(
                                  // "x${controller.cartItemQty(key: product.id!)}",
                                  "x${controller.qtyItem(product)}",
                                  overflow: TextOverflow.ellipsis,
                                  style: Style.titleStyles(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 30),
              isFavoite == true ? const SizedBox() : _actionOnQty(context)
            ],
          ),
        ),
      ),
    );
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
          // repeat: ImageRepeat.repeatY,
          isAntiAlias: true,
          filterQuality: FilterQuality.high,
          fit: BoxFit.contain,
          image: NetworkImage(product.image!),
        ),
      ),
    );
  }

  Widget _actionOnQty(BuildContext context) {
    ProductController controller = Provider.of<ProductController>(context);
    int? qtyItem = controller.qtyMapping[product.id];
    return Container(
      width: 70,
      height: 35,
      // alignment: Alignment,
      decoration: BoxDecoration(
          color: AppConfiguration.bgColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            child: IconButton(
                onPressed: () {
                  if (qtyItem! > 1) {
                    controller.onDescrease(
                        model: product, caseOrder: caseOrder);
                  }
                },
                icon: const Icon(
                  Icons.remove_circle,
                  size: 18,
                )),
          ),
          // const Spacer(),
          Text(
            // controller.cartItemQty(key: product.id!)!,
            controller.qtyItem(product),
            style: const TextStyle(color: Colors.black),
          ),
          Expanded(
            child: IconButton(
                onPressed: () {
                  controller.onInCrease(model: product, caseOrder: caseOrder);
                },
                icon: const Icon(
                  Icons.add_circle,
                  size: 18,
                )),
          )
        ],
      ),
    );
  }
}
