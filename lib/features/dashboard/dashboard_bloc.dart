import 'package:bloc_effects/bloc_effects.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:product_viewer/common/usecase/get_products_list_use_case.dart';
import 'package:product_viewer/core/di/get_it.dart';
import 'package:product_viewer/data/model/product_model.dart';

part 'dashboard_bloc.freezed.dart';

// Title: Effect
@freezed
class DashboardEffect with _$DashboardEffect {
  const factory DashboardEffect.onDataLoaded() = DashboardEffectOnDataLoaded;
}

// Title: Event
@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.loadData() = DashboardEventLoadData;
}

// Title: State
@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.loading() = DashboardStateLoading;
  const factory DashboardState.empty() = DashboardStateEmpty;
  const factory DashboardState.error({
    required Exception exception,
  }) = DashboardStateError;
  const factory DashboardState.data({
    required List<ProductModel> productsList,
  }) = DashboardStateData;
}

// Title: Bloc
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> with Effects<DashboardEffect> {
  final GetProductsListUseCase _getProductsListUseCase = getIt<GetProductsListUseCase>();

  DashboardBloc() : super(DashboardState.loading()) {
    on<DashboardEvent>(
      (event, emit) => event.map(
        loadData: (_) => _onLoadDataEvent(emit),
      ),
    );

    // Load data when initiliazed
    add(DashboardEvent.loadData());
  }

  /// Load products list from API
  Future<void> _onLoadDataEvent(Emitter<DashboardState> emit) async {
    emit(DashboardState.loading());

    try {
      final data = await _getProductsListUseCase.execute();
      if (data.isEmpty) {
        emit(DashboardState.empty());
      } else {
        emit(DashboardState.data(productsList: data));
      }

      // [Sample] Sample usage of communication from bloc to UI. Just to demonstrate the architecture.
      emitEffect(DashboardEffect.onDataLoaded());
    } on Exception catch (e) {
      emit(DashboardState.error(exception: e));
    }
  }
}
