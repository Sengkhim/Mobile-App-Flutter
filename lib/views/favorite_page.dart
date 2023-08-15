import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tast/app/app_config.dart';
import 'package:tast/controllers/prouct_controller.dart';
import '../customs/notifications/cart_notification.dart';
import '../customs/product_cart.dart';
import '../models/product_model.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _CartPageState();
}

class _CartPageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _bodyBuilder(context),
    );
  }

  Widget _bodyBuilder(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          floating: true,
          pinned: true,
          stretch: true,
          title: Row(
            children: [
              const Spacer(),
              //notification cart
              Consumer<ProductController>(
                builder: (context, controller, child) {
                  int value = controller.favoites.length;
                  return CartNotification(
                    icon: Icons.favorite_border_outlined,
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
          bottom: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: const Text(
              "My Favorite",
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
    List<ProductModel> data = controller.getFavoites();
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
                    product: product,
                    isFavoite: true,
                    caseOrder: CaseOrder.favorite);
              } else {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 50),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppConfiguration.bgColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    "No fovorite item",
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
