import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_rating_dto.freezed.dart';
part 'product_rating_dto.g.dart';

@freezed
class ProductRatingDTO with _$ProductRatingDTO {
  const factory ProductRatingDTO({
    required double rate,
    required int count,
  }) = _ProductRatingDTO;

  factory ProductRatingDTO.fromJson(Map<String, dynamic> json) => _$ProductRatingDTOFromJson(json);
}
