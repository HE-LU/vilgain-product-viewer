import 'package:bloc_effects/bloc_effects.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:product_viewer/common/data/model/product_model.dart';
import 'package:product_viewer/common/usecase/get_products_list_api_use_case.dart';
import 'package:product_viewer/common/usecase/get_products_list_storage_use_case.dart';
import 'package:product_viewer/core/flogger.dart';

part 'dashboard_bloc.freezed.dart';

/// Effect and Events should be preferably excluded from this file and moved to separate files.

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
  DashboardBloc({
    required GetProductsListApiUseCase getProductsListApiUseCase,
    required Future<GetProductsListStorageUseCase> getProductsListStorageUseCaseFuture,
  })  : _getProductsListApiUseCase = getProductsListApiUseCase,
        _getProductsListStorageUseCaseFuture = getProductsListStorageUseCaseFuture,
        super(DashboardState.loading()) {
    on<DashboardEvent>(
      (event, emit) => event.map(
        loadData: (_) => _onLoadDataEvent(emit),
      ),
    );

    // Load data when initialized
    add(DashboardEvent.loadData());
  }

  final GetProductsListApiUseCase _getProductsListApiUseCase;
  final Future<GetProductsListStorageUseCase> _getProductsListStorageUseCaseFuture;

  /// Load products list from API
  Future<void> _onLoadDataEvent(Emitter<DashboardState> emit) async {
    emit(DashboardState.loading());

    List<ProductModel> storageProductsList = [];
    try {
      // Title: Step 1: Load data from Local Storage
      storageProductsList = await (await _getProductsListStorageUseCaseFuture).execute();
    } catch (e) {
      Flogger.e(e.toString());
      // Ignore this error. Just log it.
    }

    // Title: Step 2: Load data from API
    try {
      final productsList = await _getProductsListApiUseCase.execute();
      if (productsList.isEmpty) {
        emit(DashboardState.empty());
      } else {
        emit(DashboardState.data(productsList: productsList));
      }

      // [Sample] Sample usage of communication from bloc to UI. Just to demonstrate the architecture.
      emitEffect(DashboardEffect.onDataLoaded());
    } on Exception catch (e) {
      // TODO: Handle error properly. We should parse and check that it is a network error.
      // Right now this is a simple hack to display data even when offline, and to not display error state.
      // This functionality is always for a long discussion with a PM.
      if (storageProductsList.isNotEmpty) {
        emit(DashboardState.data(productsList: storageProductsList));
      } else {
        emit(DashboardState.error(exception: e));
      }
    }
  }
}
