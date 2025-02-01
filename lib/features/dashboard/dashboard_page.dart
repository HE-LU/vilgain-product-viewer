import 'package:auto_route/auto_route.dart';
import 'package:bloc_effects/bloc_effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_viewer/common/usecase/get_products_list_api_use_case.dart';
import 'package:product_viewer/common/usecase/get_products_list_storage_use_case.dart';
import 'package:product_viewer/core/di/get_it.dart';
import 'package:product_viewer/features/dashboard/dashboard_bloc.dart';
import 'package:product_viewer/features/dashboard/dashboard_page_content.dart';

/// Page wrapper with Scaffold and AppBar.
/// Ths page is scoping the [DashboardBloc] to the [DashboardPageContent].
/// The [BlocListener] is listening to the [DashboardBloc] state changes. (Just a sample usage)

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Viewer'),
      ),
      body: MultiBlocProvider(
        // Title: Providers
        providers: [
          // Subtitle: [DashboardState] Bloc
          BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc(
              getProductsListApiUseCase: getIt<GetProductsListApiUseCase>(),
              getProductsListStorageUseCaseFuture: getIt.getAsync<GetProductsListStorageUseCase>(),
            ),
          ),
        ],
        child: BlocEffectListener<DashboardBloc, DashboardEffect>(
          // Title: Effect Listeners
          listener: (context, effect) {
            effect.map(onDataLoaded: (_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data loaded')));
            });
          },
          // Title: Content
          child: DashboardPageContent(),
        ),
      ),
    );
  }
}
