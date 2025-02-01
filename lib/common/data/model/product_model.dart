import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:product_viewer/common/data/dto/product_response_dto.dart';
import 'package:product_viewer/common/data/dto/product_storage_dto.dart';

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

  factory ProductModel.fromStorage({required ProductStorageDTO data}) {
    return ProductModel(
      id: data.id,
      title: data.title,
      price: data.price,
      description: data.description,
      category: data.category,
      image: data.image,
      ratingRate: data.ratingRate,
      ratingCount: data.ratingCount,
    );
  }

  factory ProductModel.mock() {
    return ProductModel(
      id: 0,
      title: 'title',
      price: 10.00,
      description: 'description',
      category: 'category',
      image: 'image',
      ratingRate: 5,
      ratingCount: 100,
    );
  }
}
