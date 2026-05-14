import 'dart:convert';

class ServiceModel {
  final String id;
  final String providerId;
  final String title;
  final String description;
  final double price;
  final String category;

  ServiceModel({
    required this.id,
    required this.providerId,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'providerId': providerId,
    'title': title,
    'description': description,
    'price': price,
    'category': category,
  };

  factory ServiceModel.fromJson(Map<dynamic, dynamic> json) => ServiceModel(
    id: json['id']?.toString() ?? '',
    providerId: json['providerId']?.toString() ?? '',
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    price: (json['price'] is num)
        ? (json['price'] as num).toDouble()
        : double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
    category: json['category'] ?? '',
  );

  String encode() => jsonEncode(toJson());

  static ServiceModel decode(String s) => ServiceModel.fromJson(jsonDecode(s));
}
