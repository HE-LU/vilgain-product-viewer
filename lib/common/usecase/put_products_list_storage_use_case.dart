import 'package:hive/hive.dart';
import 'package:product_viewer/common/data/dto/product_storage_dto.dart';
import 'package:product_viewer/common/data/model/product_model.dart';

class PutProductsListStorageUseCase {
  final Box _box;

  PutProductsListStorageUseCase(this._box);

  Future<void> execute({required List<ProductModel> productsList}) async {
    // Title: Step 1: Convert data to DTO
    final data = productsList.map((e) => ProductStorageDTO.fromModel(data: e)).toList();

    // Title: Step 2: Save data to Local Storage
    await _box.delete('productList');
    await _box.put('productsList', data);
  }
}
