class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;       // thumbnail — para la lista
  final List<String> images; // todas las imágenes — para el detalle
  final String category;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.images,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final rawImages = json['images'] as List<dynamic>? ?? [];
    final cleanImages = rawImages.map((img) {
      return img.toString()
          .replaceAll('"', '')
          .replaceAll('[', '')
          .replaceAll(']', '');
    }).toList();

    final categoryData = json['category'];
    final categoryName = categoryData is Map
        ? (categoryData['name'] ?? '').toString()
        : categoryData?.toString() ?? '';

    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Sin título',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      image: cleanImages.isNotEmpty ? cleanImages.first : '',
      images: cleanImages,
      category: categoryName,
    );
  }
}