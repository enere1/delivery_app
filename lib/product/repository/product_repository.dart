import 'package:delivery_app/common/const/data/data.dart';
import 'package:delivery_app/common/dio/dio.dart';
import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:delivery_app/common/model/pagination_query_params_model.dart';
import 'package:delivery_app/common/repository/pagination_repository.dart';
import 'package:delivery_app/product/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'product_repository.g.dart';

final productRepositoryProvider = StateProvider<ProductRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final productRepository = ProductRepository(dio, baseUrl: '$DOMAIN/product');

  return productRepository;
});

@RestApi()
abstract class ProductRepository implements IBasePaginationRepository<ProductItem> {
  factory ProductRepository(Dio dio, {String baseUrl}) = _ProductRepository;

  @GET('')
  @Headers({
    'accessToken': true,
  })
  Future<PaginationModel<ProductItem>> paginate({
    @Queries() PaginationQueryParamsModel? paginationParams =
        const PaginationQueryParamsModel(),
  });
}
