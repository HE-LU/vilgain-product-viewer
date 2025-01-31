import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:product_viewer/component/custom_network_image.dart';
import 'package:product_viewer/data/model/product_model.dart';

/// Just a simple page to show product details.
/// In ideal case, this page should be more complex.
/// The bloc for this page is missing. It should be added.
///
/// In ideal scenario, we would like to display data passsed from the previous page, if any.
/// In the same time, we would like to fetch more data from the server.
/// Those data should be then displayed in this page.
/// In the meantime, missing data should be displayed as loading. For example using shimmering effect.
@RoutePage()
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.title, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
              background: CustomNetworkImage.square(
                url: product.image,
                size: 200,
              ),
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subtitle: Rating in starts
              Text("Product rating", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Text(product.ratingRate.toString()),
                ],
              ),
              Text("Rating count: ${product.ratingCount}"),
              const SizedBox(height: 16),
              Text("Product description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(product.description),
              // TODO: Add more details. For example category.
            ],
          ),
        ),
      ),
    );
  }
}
