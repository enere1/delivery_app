
import 'package:delivery_app/common/const/data/data.dart';
import 'package:delivery_app/common/dio/dio.dart';
import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:delivery_app/common/model/pagination_query_params_model.dart';
import 'package:delivery_app/common/repository/pagination_repository.dart';
import 'package:delivery_app/order/model/order_model.dart';
import 'package:delivery_app/order/model/post_order_body.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'order_repository.g.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final orderRepository = OrderRepository(dio, baseUrl: '$DOMAIN/order');
  return orderRepository;
});

@RestApi()
abstract class OrderRepository implements IBasePaginationRepository<OrderModel> {

  factory OrderRepository(Dio dio, {String baseUrl}) = _OrderRepository;

  @POST('')
  @Headers({
    'accessToken': true,
  })
  Future<void> postOrder({
    @Body() required PostOrderBody body,
  });

  @GET('')
  @Headers({
    'accessToken': true,
  })
  Future<PaginationModel<OrderModel>> paginate({
    @Queries()
    PaginationQueryParamsModel? paginationParams = const PaginationQueryParamsModel()
  });

}