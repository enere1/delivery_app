import 'package:delivery_app/common/model/model_with_id.dart';
import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:delivery_app/common/model/pagination_query_params_model.dart';

abstract class IBasePaginationRepository<T> {

  Future<PaginationModel<T>> paginate({
    PaginationQueryParamsModel? paginationParams = const PaginationQueryParamsModel(),
  });
}