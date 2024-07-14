import 'package:delivery_app/common/model/model_with_id.dart';
import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:delivery_app/common/model/pagination_query_params_model.dart';
import 'package:delivery_app/common/repository/pagination_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

abstract class PaginationNotifier<T extends ModelWithId,
        U extends IBasePaginationRepository<T>>
    extends StateNotifier<PaginationBaseModel> {
  final U repository;

  PaginationNotifier({
    required this.repository,
  }) : super(PaginationLoadingModel()) {
    paginate();
  }

  Future<void> paginate({
    int count = 20,
    bool fetchMore = false,
    bool reFetch = false,
  }) async {
    // refetch이면은 새로가져옴
    final isLoading = state is PaginationLoadingModel;
    final isFechingMoreModel = state is PaginationFetchingMoreModel;
    final isReFechingModel = state is PaginationReFetchingModel;

    if (fetchMore && (isLoading || isFechingMoreModel || isReFechingModel)) {
      return;
    }

    PaginationQueryParamsModel paginationParam = PaginationQueryParamsModel(count: count);

    if (reFetch == true) {
      final pState = state as PaginationModel<T>;
      state = PaginationReFetchingModel<T>(meta: pState.meta, data: pState.data);
    }

    if (fetchMore == true) {
      final pState = state as PaginationModel<T>;
      state = PaginationFetchingMoreModel<T>(meta: pState.meta, data: pState.data);
      paginationParam = paginationParam.copyWith(
        after: pState.data.last.id,
      );
    }

    final paginatModel =
        await repository.paginate(paginationParams: paginationParam);

    if (state is PaginationFetchingMoreModel) {
      final pState = state as PaginationFetchingMoreModel<T>;

      state = pState.copyWith(
        meta: paginatModel.meta,
        data: [
          ...pState.data,
          ...paginatModel.data
        ]
      );
    } else {
      state = paginatModel;
    }
  }
}
