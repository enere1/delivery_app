import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:delivery_app/common/repository/pagination_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class PaginationNotifier<T,
        U extends IBasePaginationRepository>
    extends StateNotifier<PaginationBaseModel> {
  final U repository;

  PaginationNotifier({
    required this.repository,
  }) : super(PaginationLoadingModel()) {
    paginate();
  }

  Future<void> paginate() async {
    final paginatModel = await repository.paginate();
    state = paginatModel;
  }
}
