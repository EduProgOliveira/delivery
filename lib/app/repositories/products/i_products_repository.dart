import 'package:dw9_delivery_appp/app/models/product_model.dart';

abstract class IProductsRepository {
  Future<List<ProductModel>> findAllProducts();
}
