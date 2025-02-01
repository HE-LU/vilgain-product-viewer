import 'package:hive/hive.dart';
import 'package:product_viewer/common/data/dto/product_storage_dto.dart';
import 'package:product_viewer/common/data/model/product_model.dart';

class GetProductsListStorageUseCase {
  final Box _box;

  GetProductsListStorageUseCase(this._box);

  Future<List<ProductModel>> execute() async {
    // Title: Step 1: Load data from Storage
    final response = (_box.get('productsList', defaultValue: <ProductStorageDTO>[]) as List).cast<ProductStorageDTO>();

    // Title: Step 2: Parse data from Storage
    final data = response.map((e) => ProductModel.fromStorage(data: e)).toList();

    return data;
  }
}
