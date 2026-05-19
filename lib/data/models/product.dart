class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String description; // new field
  final List<String>? features; // new optional field
  final String imageUrl; // for network images (optional)
  final String assetImage; // for local asset images
  final String affiliateLink;
  final String advertiser;
  final List<String> tags;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    this.features,
    required this.imageUrl,
    required this.assetImage,
    required this.affiliateLink,
    required this.advertiser,
    required this.tags,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final affiliate = json['affiliate'] ?? {};

    // Ensure price is always a double
    double parsedPrice;
    final rawPrice = json['price'];
    if (rawPrice is double) {
      parsedPrice = rawPrice;
    } else if (rawPrice is int) {
      parsedPrice = rawPrice.toDouble();
    } else if (rawPrice is String) {
      parsedPrice =
          double.tryParse(rawPrice.replaceAll(RegExp(r'[^0-9\.]'), '')) ?? 0.0;
    } else {
      parsedPrice = 0.0;
    }

    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      price: parsedPrice,
      description: json['description'] ?? '',
      features: (json['features'] as List?)?.map((e) => e.toString()).toList(),
      imageUrl: affiliate['imageUrl'] ?? '',
      assetImage: json['assetImage'] ?? '',
      affiliateLink: affiliate['affiliateLink'] ?? '',
      advertiser: affiliate['advertiser'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "category": category,
      "price": price,
      "description": description,
      "features": features,
      "assetImage": assetImage, // ADDED
      "affiliate": {
        "advertiser": advertiser,
        "link": affiliateLink,
        "imageUrl": imageUrl,
      },
      "tags": tags,
    };
  }
}
