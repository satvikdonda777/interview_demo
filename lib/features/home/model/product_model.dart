// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
@immutable
abstract class ProductModel with _$ProductModel {
  @JsonSerializable(explicitToJson: true)
  const factory ProductModel({
    List<Products>? products,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

@freezed
@immutable
class Products with _$Products {
  @JsonSerializable(explicitToJson: true)
  const factory Products({
    int? id,
    String? title,
    String? description,
    double? price,
    int? quantity,
    double? rating,
    double? discountPercentage,
    int? stock,
    String? brand,
    String? category,
    String? thumbnail,
    List<String>? images,
  }) = _Products;

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);
}
