import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tast/app/app_config.dart';
import 'package:tast/controllers/prouct_controller.dart';
import 'package:tast/views/home_page.dart';
import '../customs/buttons/standard_buttom.dart';
import '../customs/notifications/cart_notification.dart';
import '../customs/product_cart.dart';
import '../models/product_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    ProductController controller = context.watch<ProductController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: _bodyBuilder(context),
      bottomNavigationBar: SizedBox(
        height: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text("Total(${controller.carts.length} items):",
                  style: Style.subTitleStyle),
            ),
            Row(
              children: [
                ///add to cart
                StandardButtom(
                  onTap: () async {
                    if (controller.carts.isNotEmpty) {
                      await QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        text: 'Completed Successfully!',
                        autoCloseDuration: const Duration(seconds: 5),
                      );
                      controller.placeOrder();
                    }
                  },
                  title: "Place Order",
                  widget: Text("\$${controller.handleTotalPricing()}"),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _bodyBuilder(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
          title: Row(
            children: [
              const Spacer(),
              //notification cart
              Consumer<ProductController>(
                builder: (context, controller, child) {
                  int value = controller.carts.length;
                  return CartNotification(
                    backgroundColor: AppConfiguration.bgColor,
                    iconColor: Colors.black,
                    value: value,
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const CartPage()));
                    },
                  );
                },
              )
            ],
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          floating: true,
          pinned: true,
          stretch: true,
          // onStretchTrigger: () async {
          //   print("object");
          // },
          bottom: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: const Text(
              "My Cart",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        ///list view of item carts
        _elementItemCard(context)
      ],
    );
  }

  Widget _elementItemCard(BuildContext context) {
    ProductController controller = Provider.of<ProductController>(context);
    List<ProductModel> data = controller.getCarts();
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisExtent: data.isNotEmpty ? 100 : 250,
              childAspectRatio: 1.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (data.isNotEmpty) {
                ProductModel product = data[index];
                return ProductCart(
                    product: product, caseOrder: CaseOrder.addToCart);
              } else {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 50),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppConfiguration.bgColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    "No item",
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }
            },
            childCount: data.isNotEmpty ? data.length : 1,
          )),
    );
  }
}
