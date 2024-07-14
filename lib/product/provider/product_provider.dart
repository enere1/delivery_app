import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:delivery_app/common/provider/pagination_provider.dart';
import 'package:delivery_app/product/model/product_model.dart';
import 'package:delivery_app/product/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final productProvider = StateNotifierProvider<ProductNotifier, PaginationBaseModel>((ref){
  final repository = ref.watch(productRepositoryProvider);
  return ProductNotifier(repository: repository);
});

class ProductNotifier extends PaginationNotifier<ProductItem, ProductRepository> {
  ProductNotifier({required super.repository});
}