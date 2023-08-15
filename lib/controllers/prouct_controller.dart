import 'package:flutter/foundation.dart';
import 'package:tast/controllers/base_controller.dart';
import 'package:tast/extensions/list_extension.dart';
import 'package:tast/states/loading_state.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

enum CaseOrder {
  none,
  favorite,
  addToCart,
}

class ProductController extends BaseController {
  ProductController(this.service);
  late ProductService service;

  late String currentCategory = 'All';
  late List<ProductModel> _pruduct = [];
  late final List<dynamic> _catogories = ["All"];
  late final List<ProductModel> _favoites = [];
  late final List<ProductModel> _cart = [];
  late int counter = 0;
  late String valueChange = "1";

  List<ProductModel> get favoites => _favoites;
  List<ProductModel> get carts => _cart;
  List<ProductModel> get product => _pruduct;
  List<dynamic> get catogories => _catogories;
  late Map<double, int> qtyMapping = {};
  CaseOrder caseOrder = CaseOrder.none;

  void placeOrder() {
    _cart.clear();
    updateChange();
  }

  String qtyItem(ProductModel products) {
    var result = qtyMapping[products.id!.toDouble()].toString();
    return result.isEmpty ? "1" : result;
  }

  updateActionOrder(CaseOrder caseOrder) {
    this.caseOrder = caseOrder;
    updateChange();
  }

  String? fakePrice(ProductModel products) {
    int sumQty = 0;
    var data = qtyMapping[products.id].toString();
    if (data != "null") {
      sumQty = int.parse(data);
      sumQty;
    }
    return data == "null" || data == "0" ? " 1" : sumQty.toString();
  }

  void action(ProductModel products, String sign) {
    switch (sign) {
      case "+":
        _favoites.add(products);
        if (!qtyMapping.containsKey(products.id)) {
          qtyMapping.addAll({products.id!.toDouble(): 2});
        } else {
          var length = _favoites
              .where((element) => element.id == products.id)
              .toList()
              .length;
          qtyMapping.update(products.id!.toDouble(), (value) => length);
        }
        onCalulatedByItem(products);
        fakePrice(products);
        notifyListeners();
        break;
      case "-":
        _favoites.removeAt(
            _favoites.indexWhere((element) => element.id == products.id));
        var length = _favoites
            .where((element) => element.id == products.id)
            .toList()
            .length;
        qtyMapping.update(products.id!.toDouble(), (value) => length);
        onCalulatedByItem(products);
        fakePrice(products);
        notifyListeners();
        break;
      default:
    }
    // updateChange();
  }

  List<ProductModel> getFavoites() {
    var object = Set.of(_favoites).toList();
    return object;
  }

  List<ProductModel> getCarts() {
    var object = Set.of(_cart).toList();
    return object;
  }

  void addToCart(
      {ProductModel? products,
      bool? increase = false,
      bool? isDetail = false,
      CaseOrder? caseOrder}) {
    switch (caseOrder) {
      case CaseOrder.favorite:
        _handleFavorited(isDetail, products, increase);
        onCalulatedByItem(products!);
        updateChange();
        break;
      case CaseOrder.addToCart:
        _handleCarts(isDetail, products, increase);
        onCalulatedByItem(products!);
        updateChange();
        break;
      default:
        debugPrint("No Case");
    }
  }

  void _handleCarts(bool? isDetail, ProductModel? products, bool? increase) {
    if (isDetail == false) {
      _cart.add(products!);
    } else if (qtyMapping[products!.id].toString() == "null") {
      _cart.add(products);
    } else {
      //ingore
      _cart.addAll(_favoites.where((element) => element.id == products.id));
    }

    counter = _cart.length;
    if (increase == false) {
      _handleMappingQty(products);
    } else {
      if (!qtyMapping.containsKey(products.id)) {
        qtyMapping.addAll({products.id!.toDouble(): 1});
      } else {
        var length =
            _cart.where((element) => element.id == products.id).toList().length;
        qtyMapping.update(products.id!.toDouble(), (value) => length);
      }
    }
  }

  void _handleFavorited(
      bool? isDetail, ProductModel? products, bool? increase) {
    if (isDetail == false) {
      _favoites.add(products!);
    } else if (qtyMapping[products!.id].toString() == "null") {
      _favoites.add(products);
    } else {
      //ingore
    }

    counter = _favoites.length;
    if (increase == false) {
      _handleMappingQty(products);
    } else {
      if (!qtyMapping.containsKey(products.id)) {
        qtyMapping.addAll({products.id!.toDouble(): 1});
      } else {
        var length = _favoites
            .where((element) => element.id == products.id)
            .toList()
            .length;
        qtyMapping.update(products.id!.toDouble(), (value) => length);
      }
    }
  }

  String? onCalulatedByItem(ProductModel model) {
    int qty = qtyMapping[model.id]!.toInt();
    var result = model.price * (model.qty!.value = qty).toDouble();
    return result.toStringAsFixed(2);
  }

  void _handleMappingQty(ProductModel products) {
    if (!qtyMapping.containsKey(products.id)) {
      qtyMapping.addAll({products.id!.toDouble(): 1});
    } else {
      var length = _favoites
          .where((element) => element.id == products.id)
          .toList()
          .length;
      qtyMapping.update(products.id!.toDouble(), (value) => length);
    }
    // onCalulatedByItem(products);
  }

  String? cartItemQty({int? key}) {
    return qtyMapping[key].toString();
  }

  String? handleTotalPricing() {
    var result = _cart.sumBy((element) => element.price);
    return result.toStringAsFixed(2);
  }

  String? priceByitem(ProductModel model) {
    var result = model.price * model.qty!.value;
    return result.toStringAsFixed(2);
  }

  void onInCrease({ProductModel? model, CaseOrder? caseOrder}) {
    switch (caseOrder) {
      case CaseOrder.favorite:

        ///ingore
        break;
      case CaseOrder.addToCart:
        _cart.add(model!);
        var length =
            _cart.where((element) => element.id == model.id).toList().length;
        qtyMapping.update(model.id!.toDouble(), (value) => length);
        invokeOperation(model);
        updateChange();
        break;
      default:
    }
  }

  void onDescrease({ProductModel? model, CaseOrder? caseOrder}) {
    switch (caseOrder) {
      case CaseOrder.addToCart:
        _cart.removeAt(_cart.indexWhere((element) => element.id == model!.id));
        var length =
            _cart.where((element) => element.id == model!.id).toList().length;
        qtyMapping.update(model!.id!.toDouble(), (value) => length);
        invokeOperation(model);
        updateChange();
        break;
      case CaseOrder.favorite:

        ///ingore
        break;
      default:
    }
  }

  void invokeOperation(ProductModel model) {
    int qty = qtyMapping[model.id]!.toInt();
    model.price * (model.qty!.value = qty).toDouble();
    // updateChange();
  }

  void removeCart(
      {ProductModel? product, CaseOrder? caseOrder, bool? isAtc = false}) {
    switch (caseOrder) {
      case CaseOrder.addToCart:
        if (product != null) {
          _cart.removeWhere((element) => element.id == product.id);
        }
        qtyMapping.update(product!.id!.toDouble(), (value) => 1);
        updateChange();
        break;
      case CaseOrder.favorite:
        if (product != null) {
          _favoites.removeWhere((element) => element.id == product.id);
        }
        if (isAtc == false) {
          qtyMapping.update(product!.id!.toDouble(), (value) => 1);
        }

        updateChange();
        break;
      default:
    }
  }

  bool isCurrent({String? categories}) => currentCategory == categories;

  void onChangeCate({String? categories}) {
    currentCategory = categories!;
    debugPrint(currentCategory);
    updateChange();
  }

  Future<void> fetchAllProduct() async {
    onChangeState(LoadingState.onProcessing);
    var data = await service.getAllProduct();
    if (data.isNotEmpty) {
      _pruduct = data;
    }
    onChangeState(LoadingState.onSuccess);
    updateChange();
  }

  Future<List<ProductModel>> fetchAllProductAS() async {
    var data = await service.getAllProduct();
    if (data.isNotEmpty) {
      _pruduct = data;
    }
    return data;
    // updateChange();
  }

  Future<void> fetchAllCategoies() async {
    onChangeState(LoadingState.onProcessing);
    var data = await service.getAllCategoies();
    if (data.isNotEmpty) {
      _catogories.addAll(data);
    }
    onChangeState(LoadingState.onSuccess);
    updateChange();
  }

  Future<void> loadProductByCategory({String? categories}) async {
    onChangeState(LoadingState.onProcessing);
    var product = await service.getProductByCate(categories: categories);
    if (product.isNotEmpty) {
      _pruduct = product;
    }
    onChangeState(LoadingState.onSuccess);
    updateChange();
  }

  Future<List<ProductModel>> loadProductByCategoryFu(
      {String? categories}) async {
    onChangeState(LoadingState.onProcessing);
    var product = await service.getProductByCate(categories: categories);
    if (product.isNotEmpty) {
      _pruduct = product;
    }
    onChangeState(LoadingState.onSuccess);
    // updateChange();
    return product;
  }
}
