import 'package:flutter/material.dart';

class ProductModel {
  late final int? id;
  late final String? title;
  late final double price;
  late final String? description;
  late final String? category;
  late final String? image;
  late final Rating? rating;
  late final ValueNotifier<int>? qty;

  ProductModel(
      {this.id,
      this.title,
      required this.price,
      this.description,
      this.category,
      this.image,
      this.rating,
      this.qty}) {
    qty = ValueNotifier<int>(1);
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toInt();
    title = json['title'];
    price = json['price'].toDouble();
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    qty = ValueNotifier<int>(1);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['category'] = category;
    data['image'] = image;
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    return data;
  }
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'].toDouble();
    count = json['count'].toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = rate;
    data['count'] = count;
    return data;
  }
}
