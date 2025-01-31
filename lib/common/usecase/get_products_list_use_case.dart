import 'package:dio/dio.dart';
import 'package:product_viewer/data/dto/product_response_dto.dart';
import 'package:product_viewer/data/model/product_model.dart';

class GetProductsListUseCase {
  final Dio _dio;

  GetProductsListUseCase(this._dio);

  Future<List<ProductModel>> execute() async {
    final response = await _dio.get('/products');

    return (response.data as List).map((e) => ProductModel.fromAPI(data: ProductResponseDTO.fromJson(e))).toList();
  }
}
