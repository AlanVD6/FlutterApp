class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final List<String> galleryImages;
  final List<int> availableSizes;
  final List<String> availableColors; 

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.galleryImages,
    required this.availableSizes,
    this.availableColors = const ['Negro', 'Blanco', 'Gris'], 
  });
}