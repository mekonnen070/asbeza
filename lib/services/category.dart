import 'package:asbeza_app/models/category.dart';
import 'package:asbeza_app/models/sub_category.dart';

List<SubCategory> subCat1 = [
  SubCategory(categoryId: 'c1', name: 'Fruits', subCategoryId: 'sb_1'),
];
List<SubCategory> subCat2 = [
  SubCategory(categoryId: 'c2', name: 'Vegetables', subCategoryId: 'sb_2'),
];
List<SubCategory> subCat3 = [
  SubCategory(categoryId: 'c3', name: 'Spices', subCategoryId: 'sb_3'),
];

class CategoryService {
  List<Category> catItems = [
    Category(categoryId: "c1", name: 'Fruits', subCategories: subCat1),
    Category(categoryId: "c2", name: 'Vegetables', subCategories: subCat2),
    Category(categoryId: "c3", name: 'Spices', subCategories: subCat3),
  ];

  Future<List<Category>?> categories() async {
    return Future.delayed(const Duration(seconds: 1)).then((value) => catItems);
  }
}
