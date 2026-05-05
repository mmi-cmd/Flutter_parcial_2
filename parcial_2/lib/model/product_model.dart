class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final String category;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // images es una List<dynamic> — tomamos la primera
    final images = json['images'] as List<dynamic>? ?? [];
    final rawImage = images.isNotEmpty ? images.first.toString() : '';
    // La API a veces devuelve la URL con comillas o corchetes extra: ["https://..."]
    final cleanImage = rawImage
        .replaceAll('"', '')
        .replaceAll('[', '')
        .replaceAll(']', '');

    // category es un Map: { "id": 1, "name": "Clothes" }
    final categoryData = json['category'];
    final categoryName = categoryData is Map
        ? (categoryData['name'] ?? '').toString()
        : categoryData?.toString() ?? '';

    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Sin título',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      image: cleanImage,
      category: categoryName,
    );
  }
}