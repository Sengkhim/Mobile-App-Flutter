import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tast/app/app_config.dart';
import 'package:tast/controllers/prouct_controller.dart';
import 'package:tast/customs/buttons/standard_buttom.dart';
import 'package:tast/models/product_model.dart';
import '../cart_page.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, this.product});
  final ProductModel? product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _elementAppBar(context),
      body: _elementbody(context),
      bottomNavigationBar: SizedBox(
        height: 110,
        child: Row(
          children: [
            ///increase qty or descrease qty
            _modifieQty(context),

            ///add to cart
            StandardButtom(
              onTap: () {
                Provider.of<ProductController>(context, listen: false)
                    .addToCart(
                        products: product,
                        increase: true,
                        isDetail: true,
                        caseOrder: CaseOrder.addToCart);
                Provider.of<ProductController>(context, listen: false)
                    .removeCart(
                        product: product, caseOrder: CaseOrder.favorite, isAtc: true);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartPage()));
              },
              title: "Add To Cart",
              icon: Icons.shopping_cart,
              padding: const EdgeInsets.only(right: 25),
            )
          ],
        ),
      ),
    );
  }

  Widget _modifieQty(BuildContext context) {
    var controller = Provider.of<ProductController>(context);
    var qtys = controller.fakePrice(product!);
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 37,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      if (int.parse(qtys!) != 1) {
                        controller.action(product!, "-");
                      }
                    },
                    icon: const Icon(Icons.remove_circle)),
                const SizedBox(width: 8),
                Text(qtys!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                IconButton(
                    onPressed: () {
                      controller.action(product!, "+");
                    },
                    icon: const Icon(Icons.add_circle))
              ],
            ),
          )),
    );
  }

  Widget _elementbody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            //Product Image
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                color: AppConfiguration.bgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                    image: NetworkImage(product!.image!),
                  ),
                ),
              ),
            ),

            ///name, description and price
            ListTile(
              title: Text(product!.title!, style: Style.titleStyle),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(product!.description!, style: Style.subTitleStyle),
              ),
            ),

            const SizedBox(height: 8),

            ///rate and stocking
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Price : \$${product!.price}",
                      style: Style.trailingStyles(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Text("Rate  : ${product!.rating!.rate.toString()}",
                      style: Style.trailingStyles(
                          fontSize: 14, fontWeight: FontWeight.w700)),
                )),
          ],
        ),
      ),
    );
  }

  AppBar _elementAppBar(BuildContext context) {
    return AppBar(
      excludeHeaderSemantics: true,
      // toolbarHeight: 70,
      leadingWidth: 50,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.black,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }
}
