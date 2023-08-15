import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tast/app/app_config.dart';
import 'package:tast/controllers/prouct_controller.dart';
import 'package:tast/customs/product_container.dart';
import 'package:tast/models/product_model.dart';
import 'package:tast/states/loading_state.dart';
import 'package:tast/views/favorite_page.dart';
import '../customs/loading/gird_product_loading.dart';
import '../customs/notifications/cart_notification.dart';
import '../customs/search.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    ProductController controller =
        Provider.of<ProductController>(context, listen: false);
    tabController =
        TabController(vsync: this, length: controller.catogories.length);
    controller.fetchAllProduct();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppConfiguration.bgColor,
      backgroundColor: Colors.white,
      body: _elementBody(context),
    );
  }

  Widget _elementBody(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          // Provider.of<ProductController>(context, listen: false).fetchAllCategoies();
          Provider.of<ProductController>(context, listen: false).fetchAllProduct();
        },
        child: CustomScrollView(
          shrinkWrap: true,
          primary: true,
          clipBehavior: Clip.antiAlias,
          slivers: [
            //search and cart
            _elementHeader(context),

            _elementBackGround(),

            //sliver appbar
            _sliverAppBar(context),

            //sliver grid
            _elementGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _elementGrid(BuildContext context) {
    var controller = Provider.of<ProductController>(context);
    return SliverPadding(
      padding: EdgeInsets.symmetric(
          vertical: AppConfiguration.horizontal, horizontal: 15),
      sliver: _elementSliverGrid(controller.product, controller, context),
    );
  }

  SliverGrid _elementSliverGrid(List<ProductModel> object,
      ProductController controller, BuildContext context) {
    var controllers = context.watch<ProductController>();
    return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 275,
            childAspectRatio: 1.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            if (controllers.loadingState == LoadingState.onProcessing) {
              return const GridProductLoading();
            } else {
              ProductModel product = object[index];
              return ProductContainer(
                product: product,
                callBack: () {
                  ///add to favorite
                  Provider.of<ProductController>(context, listen: false)
                      .addToCart(
                          products: product, caseOrder: CaseOrder.favorite);
                },
              );
            }
          },
          childCount: object.isEmpty ? 10 : object.length,
        ));
  }

  Widget _elementHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        // alignment: Alignment.bottomLeft,
        children: [
          Expanded(
              flex: 8,
              child: SearchBuilder(
                onTap: () {
                  // showSearch<String>(
                  //   context: context,
                  //   delegate: MySearchDelegate(),
                  // );
                },
              )),

          //notification cart
          Consumer<ProductController>(
            builder: (context, controller, child) {
              int value = controller.favoites.length;
              return CartNotification(
                value: value,
                iconColor: Colors.black,
                icon: Icons.favorite_border_outlined,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavoritePage()));
                },
              );
            },
          ),
          Consumer<ProductController>(
            builder: (context, controller, child) {
              int value = controller.carts.length;
              return CartNotification(
                value: value,
                iconColor: Colors.black,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartPage()));
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget _sliverAppBar(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
          vertical: AppConfiguration.vertical,
          horizontal: AppConfiguration.horizontalFrame),
      sliver: SliverAppBar(
        elevation: 4,
        shadowColor: Colors.grey,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        floating: true,
        pinned: true,
        stretch: true,
        bottom: _elementTabBar(context),
        expandedHeight: 20,
        flexibleSpace: const FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          stretchModes: [StretchMode.zoomBackground, StretchMode.fadeTitle],
          // title: Text("data"),
          // background: _elementBackGround(),
        ),
      ),
    );
  }

  Widget _elementBackGround() {
    return SliverToBoxAdapter(
      child: Column(
        children: const [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text("Categories",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.5))),
          ),
        ],
      ),
    );
  }

  _elementTabBar(BuildContext context) {
    ProductController controller = Provider.of<ProductController>(context);
    return TabBar(
      controller: tabController,
      unselectedLabelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.black.withOpacity(0.3),
      isScrollable: true,
      indicatorColor: Colors.red,
      indicatorWeight: 8,
      indicator: BoxDecoration(
        color: Colors.transparent,
        border: Border(
            bottom: BorderSide(color: Colors.black.withOpacity(0.3), width: 2)),
      ),
      tabs: controller.catogories
          .map(
            (item) => Tab(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    // color: AppConfiguration.primaryColor,
                    color: controller.currentCategory != item.toString()
                        ? Colors.white
                        : Colors.black,
                    border: Border.all(),
                    borderRadius:
                        BorderRadius.circular(AppConfiguration.borderRadius)),
                child: categoriesBuilder(
                    item.toString(),
                    controller.isCurrent(categories: item)
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          )
          .toList(),
      onTap: (value) {
        if (controller.catogories[value] != controller.currentCategory) {
          controller.onChangeCate(categories: controller.catogories[value]);
          if (controller.currentCategory != controller.catogories.first) {
            controller.loadProductByCategory(
                categories: controller.catogories[value]);
          } else {
            controller.fetchAllProduct();
          }
        }
      },
    );
  }

  Widget categoriesBuilder(String title, Color? color) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: color),
    );
  }
}
