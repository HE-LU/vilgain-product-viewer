import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:product_viewer/common/data/dto/product_rating_dto.dart';

part 'product_response_dto.freezed.dart';
part 'product_response_dto.g.dart';

@freezed
class ProductResponseDTO with _$ProductResponseDTO {
  const factory ProductResponseDTO({
    required int id,
    required String title,
    required double price,
    required String description,
    required String category,
    required String image,
    required ProductRatingDTO rating,
  }) = _ProductResponseDTO;

  factory ProductResponseDTO.fromJson(Map<String, dynamic> json) => _$ProductResponseDTOFromJson(json);
}
