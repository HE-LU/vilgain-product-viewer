import 'package:dio/dio.dart';
import 'package:product_viewer/common/data/dto/product_response_dto.dart';
import 'package:product_viewer/common/data/model/product_model.dart';
import 'package:product_viewer/common/usecase/put_products_list_storage_use_case.dart';
import 'package:product_viewer/core/di/get_it.dart';

class GetProductsListApiUseCase {
  final Dio _dio;

  GetProductsListApiUseCase(this._dio);

  Future<List<ProductModel>> execute() async {
    // Title: Step 1: Load data from API
    final response = await _dio.get('/products');

    // Title: Step 2: Parse data from API
    final data = (response.data as List).map((e) => ProductModel.fromAPI(data: ProductResponseDTO.fromJson(e))).toList();

    // Title: Step 3: Save data to Local Storage
    final putStorageUseCase = await getIt.getAsync<PutProductsListStorageUseCase>();
    await putStorageUseCase.execute(productsList: data);

    return data;
  }
}
