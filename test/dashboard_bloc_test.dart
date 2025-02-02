import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:product_viewer/common/data/model/product_model.dart';
import 'package:product_viewer/common/usecase/get_products_list_api_use_case.dart';
import 'package:product_viewer/common/usecase/get_products_list_storage_use_case.dart';
import 'package:product_viewer/features/dashboard/dashboard_bloc.dart';

import 'dashboard_bloc_test.mocks.dart';

/// This file contains the tests for the DashboardBloc.
/// The DashboardBloc is responsible for managing the state of the dashboard screen.
/// It fetches the products list from the local storage and the API.
/// The tests verify that the bloc emits the correct states when the data is loaded from the local storage and the API.
@GenerateNiceMocks([
  MockSpec<GetProductsListStorageUseCase>(),
  MockSpec<GetProductsListApiUseCase>(),
])
void main() {
  late GetProductsListStorageUseCase mockGetProductsListStorageUseCase;
  late GetProductsListApiUseCase mockGetProductsListApiUseCase;
  late DashboardBloc dashboardBloc;

  setUp(() {
    mockGetProductsListStorageUseCase = MockGetProductsListStorageUseCase();
    mockGetProductsListApiUseCase = MockGetProductsListApiUseCase();
    dashboardBloc = DashboardBloc(
      getProductsListApiUseCase: mockGetProductsListApiUseCase,
      getProductsListStorageUseCaseFuture: Future.value(mockGetProductsListStorageUseCase),
    );
  });

  test('initial state is DashboardState.loading()', () {
    when(mockGetProductsListStorageUseCase.execute()).thenAnswer((_) => Future.value([ProductModel.mock()]));
    when(mockGetProductsListApiUseCase.execute()).thenAnswer((_) => Future.value([ProductModel.mock()]));
    expect(dashboardBloc.state, DashboardState.loading());
  });

  blocTest<DashboardBloc, DashboardState>(
    'emits [loading, data] when local storage has data',
    build: () {
      when(mockGetProductsListStorageUseCase.execute()).thenAnswer((_) => Future.value([ProductModel.mock()]));
      when(mockGetProductsListApiUseCase.execute()).thenAnswer((_) => Future.value([ProductModel.mock()]));
      return DashboardBloc(
        getProductsListApiUseCase: mockGetProductsListApiUseCase,
        getProductsListStorageUseCaseFuture: Future.value(mockGetProductsListStorageUseCase),
      );
    },
    act: (bloc) => bloc.add(DashboardEvent.loadData()),
    expect: () => [
      DashboardState.loading(),
      DashboardState.data(productsList: [ProductModel.mock()]),
    ],
  );

  blocTest<DashboardBloc, DashboardState>(
    'emits [loading, empty] when API returns empty data',
    build: () {
      when(mockGetProductsListStorageUseCase.execute()).thenAnswer((_) async => []);
      when(mockGetProductsListApiUseCase.execute()).thenAnswer((_) async => []);
      return DashboardBloc(
        getProductsListApiUseCase: mockGetProductsListApiUseCase,
        getProductsListStorageUseCaseFuture: Future.value(mockGetProductsListStorageUseCase),
      );
    },
    act: (bloc) => bloc.add(DashboardEvent.loadData()),
    expect: () => [
      DashboardState.loading(),
      DashboardState.empty(),
    ],
  );

  blocTest<DashboardBloc, DashboardState>(
    'emits [loading, data] when API returns data',
    build: () {
      when(mockGetProductsListStorageUseCase.execute()).thenAnswer((_) async => []);
      when(mockGetProductsListApiUseCase.execute()).thenAnswer((_) async => [ProductModel.mock()]);
      return DashboardBloc(
        getProductsListApiUseCase: mockGetProductsListApiUseCase,
        getProductsListStorageUseCaseFuture: Future.value(mockGetProductsListStorageUseCase),
      );
    },
    act: (bloc) => bloc.add(DashboardEvent.loadData()),
    expect: () => [
      DashboardState.loading(),
      DashboardState.data(productsList: [ProductModel.mock()]),
    ],
  );

  blocTest<DashboardBloc, DashboardState>(
    'emits [loading, error] when API throws an exception',
    build: () {
      when(mockGetProductsListStorageUseCase.execute()).thenAnswer((_) async => []);
      when(mockGetProductsListApiUseCase.execute()).thenThrow(Exception('API Error'));
      return DashboardBloc(
        getProductsListApiUseCase: mockGetProductsListApiUseCase,
        getProductsListStorageUseCaseFuture: Future.value(mockGetProductsListStorageUseCase),
      );
    },
    act: (bloc) => bloc.add(DashboardEvent.loadData()),
    expect: () => [
      DashboardState.loading(),
      isA<DashboardStateError>().having((e) => e.exception.toString(), 'exception', contains('API Error')),
    ],
  );

  blocTest<DashboardBloc, DashboardState>(
    'emits [loading, data] when API throws an exception, but local storage has data',
    build: () {
      when(mockGetProductsListStorageUseCase.execute()).thenAnswer((_) async => [ProductModel.mock()]);
      when(mockGetProductsListApiUseCase.execute()).thenThrow(Exception('API Error'));
      return DashboardBloc(
        getProductsListApiUseCase: mockGetProductsListApiUseCase,
        getProductsListStorageUseCaseFuture: Future.value(mockGetProductsListStorageUseCase),
      );
    },
    act: (bloc) => bloc.add(DashboardEvent.loadData()),
    expect: () => [
      DashboardState.loading(),
      DashboardState.data(productsList: [ProductModel.mock()]),
    ],
  );
}
