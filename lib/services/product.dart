import 'package:asbeza_app/models/product.dart';

List<Product> _fruitProducts = [
  Product(
      productId: 'f1',
      name: 'Apple',
      price: 55,
      discount: 13,
      description: 'This is Apple\'s description.',
      categoryId: 'c1',
      subCategoryId: 'sb_1',
      unitsSold: 16,
      createdAt: '01/01/2015',
      images: appleImage)
];
List<Product> _vegetableProducts = [
  Product(
      productId: 'v1',
      name: 'Brocoli',
      price: 45,
      discount: 20,
      description: 'This is Brocoli\'s description.',
      categoryId: 'c2',
      subCategoryId: 'sb_2',
      unitsSold: 16,
      createdAt: '01/01/2015',
      images: brocoliImage)
];
List<Product> _spiceProducts = [
  Product(
      productId: 's1',
      name: 'Chilli',
      price: 32,
      discount: 15,
      description: 'This is Chilli\'s description.',
      categoryId: 'c3',
      subCategoryId: 'sb_3',
      unitsSold: 16,
      createdAt: '01/01/2015',
      images: chilliImage)
];

List<Image> appleImage = [
  Image(
      url:
          'https://raw.githubusercontent.com/mekonnen070/asbeza_assets/master/apple.png')
];
List<Image> brocoliImage = [
  Image(
      url:
          'https://raw.githubusercontent.com/mekonnen070/asbeza_assets/master/broccoli.png')
];
List<Image> chilliImage = [
  Image(
      url:
          'https://raw.githubusercontent.com/mekonnen070/asbeza_assets/master/chilli.png')
];

class ProductService {
  static Future<List<Product>?> products(String categoryId) async {
    return Future.delayed(const Duration(seconds: 1)).then((value) {
      switch (categoryId) {
        case 'c1':
          return _fruitProducts;
        case 'c2':
          return _vegetableProducts;
        case 'c3':
          return _spiceProducts;
      }
      return [];
    });
  }
}
