import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_viewer/app/navigation/app_router.dart';
import 'package:product_viewer/component/custom_network_image.dart';
import 'package:product_viewer/features/dashboard/dashboard_bloc.dart';

class DashboardPageContent extends StatelessWidget {
  const DashboardPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        // Title: Map Dashboard State
        return state.map(
          loading: (_) => _LoadingStateWidget(),
          empty: (_) => _EmptyStateWidget(),
          error: (state) => _ErrorStateWidget(exception: state.exception),
          data: (state) => _DataStateWidget(data: state),
        );
      },
    );
  }
}

class _LoadingStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _EmptyStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No Products'),
    );
  }
}

class _ErrorStateWidget extends StatelessWidget {
  const _ErrorStateWidget({
    required this.exception,
  });

  final Exception exception;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Error loading data: $exception'),
    );
  }
}

class _DataStateWidget extends StatelessWidget {
  const _DataStateWidget({
    required this.data,
  });

  final DashboardStateData data;

  @override
  Widget build(BuildContext context) {
    // Display a listview with small cards, containing image on the left, title and description on the right, and bold price next to the title.
    return RefreshIndicator(
      onRefresh: () async => context.read<DashboardBloc>().add(DashboardEvent.loadData()),
      child: ListView.builder(
        itemCount: data.productsList.length,
        itemBuilder: (context, index) {
          final product = data.productsList[index];
          return InkWell(
            // Subtitle: Navigate to product detail page
            onTap: () => context.pushRoute(ProductDetailRoute(product: product)),
            child: Card(
              child: Row(
                children: [
                  // Subtitle: Product image
                  CustomNetworkImage.square(
                    url: product.image,
                    size: 100,
                    fit: BoxFit.contain,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Subtitle: Title text
                          Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          SizedBox(height: 4),
                          // Subtitle: Description text
                          Text(product.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                          SizedBox(height: 8),
                          // Subtitle: Price text
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text("${product.price} \$", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
