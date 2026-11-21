class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;
  final int ratingCount;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.ratingCount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final ratingData = json['rating'];

    return ProductModel(
      id: _parseInt(json['id']),
      title: _parseString(json['title']),
      price: _parseDouble(json['price']),
      description: _parseString(json['description']),
      category: _parseString(json['category']),
      image: _parseString(json['image']),
      rating: ratingData is Map ? _parseDouble(ratingData['rate']) : 0.0,
      ratingCount: ratingData is Map ? _parseInt(ratingData['count']) : 0,
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    throw const FormatException('Invalid product integer value');
  }

  static double _parseDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) {
      final parsed = double.tryParse(value);
      if (parsed != null) return parsed;
    }
    throw const FormatException('Invalid product numeric value');
  }

  static String _parseString(dynamic value) {
    if (value is String) return value;
    throw const FormatException('Invalid product text value');
  }
}
