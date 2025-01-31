import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:product_viewer/data/dto/product_response_dto.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    required int id,
    required String title,
    required double price,
    required String description,
    required String category,
    required String image,
    required double ratingRate,
    required int ratingCount,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  factory ProductModel.fromAPI({required ProductResponseDTO data}) {
    return ProductModel(
      id: data.id,
      title: data.title,
      price: data.price,
      description: data.description,
      category: data.category,
      image: data.image,
      ratingRate: data.rating.rate,
      ratingCount: data.rating.count,
    );
  }
}
