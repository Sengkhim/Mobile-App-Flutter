import 'package:tast/controllers/base_controller.dart';
import 'package:tast/models/product_model.dart';

class CartController extends BaseController {
  late final List<ProductModel> _cart = [];

  List<ProductModel> get cart => _cart;
}
