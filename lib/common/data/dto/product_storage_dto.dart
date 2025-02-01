import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:product_viewer/common/data/model/product_model.dart';

part 'product_storage_dto.freezed.dart';
part 'product_storage_dto.g.dart';

@freezed
class ProductStorageDTO with _$ProductStorageDTO {
  @HiveType(typeId: 0)
  const factory ProductStorageDTO({
    @HiveField(0) required int id,
    @HiveField(1) required String title,
    @HiveField(2) required double price,
    @HiveField(3) required String description,
    @HiveField(4) required String category,
    @HiveField(5) required String image,
    @HiveField(6) required double ratingRate,
    @HiveField(7) required int ratingCount,
  }) = _ProductStorageDTO;

  factory ProductStorageDTO.fromModel({required ProductModel data}) {
    return ProductStorageDTO(
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
}
