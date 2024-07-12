import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:retrofit/retrofit.dart';

abstract class IBasePaginationRepository<T> {

  Future<PaginationModel<T>> paginate();
}