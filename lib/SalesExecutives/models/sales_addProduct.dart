import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SalesAddProductModel {
  final String sales_id;
  final String shop_name;
  final String id;
  final String name;
  final String description;
  final int price;
  final int discount;
  final int quantity;
  final String category;
  final List<String> images;
  SalesAddProductModel({
    required this.description,
    required this.sales_id,
    required this.shop_name,
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.quantity,
    required this.category,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description':description,
      'sales_id': sales_id,
      'shop_name': shop_name,
      'id': id,
      'name': name,
      'price': price,
      'discount': discount,
      'quantity': quantity,
      'category': category,
      'images': images,
    };
  }

  factory SalesAddProductModel.fromMap(Map<String, dynamic> map) {
    return SalesAddProductModel(
      description: map['description'] as String,
      sales_id: map['sales_id'] as String,
      shop_name: map['shop_name'] as String,
      id: map['_id'] as String,
      name: map['name'] as String,
      price: map['price'] as int,
      discount: map['discount'] as int,
      quantity: map['quantity'] as int,
      category: map['category'] as String,
      images: List<String>.from((map['images'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesAddProductModel.fromJson(String source) =>
      SalesAddProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
