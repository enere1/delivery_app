import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/common/model/model_with_id.dart';
import 'package:delivery_app/common/model/pagination_model.dart';
import 'package:delivery_app/common/provider/pagination_provider.dart';
import 'package:delivery_app/restaurant/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef Widget ItemBuilder<T extends ModelWithId>(BuildContext context, int index, T model);

class PaginationView<T extends ModelWithId> extends ConsumerStatefulWidget {

  final StateNotifierProvider<PaginationNotifier, PaginationBaseModel> provider;
  final ItemBuilder<T> builder;
  const PaginationView({
    required this.provider,
    required this.builder,
    Key? key}) : super(key: key);

  @override
  ConsumerState<PaginationView> createState() => _PaginationViewState<T>();
}

class _PaginationViewState<T extends ModelWithId> extends ConsumerState<PaginationView> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(isLastItem);
  }

  void isLastItem() {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(widget.provider.notifier).paginate(fetchMore: true);
    }
  }

  @override
  void dispose() {
    controller.removeListener(isLastItem);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final item = ref.watch(widget.provider);
    if (item is PaginationLoadingModel) {
      return DefaultLayout(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final model = item as PaginationModel<T>;
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(widget.provider.notifier).paginate(reFetch: true);
      },
      child: ListView.separated(
        controller: controller,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 22.0,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          if (index == model.data.length) {
            return model.meta.hasMore
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(child: Text('nomore'));
          }
          final item = model.data[index];
          return widget.builder(context, index, item);
        },
        itemCount: model.data.length + 1,
      ),
    );
  }
}
