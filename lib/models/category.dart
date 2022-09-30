import 'package:asbeza_app/models/sub_category.dart';

class Category {
  Category(
      {required this.categoryId,
      required this.name,
      required this.subCategories});

  String categoryId;
  String name;
  List<SubCategory> subCategories;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["categoryId"],
        name: json["name"],
        subCategories: List<SubCategory>.from(
            json["subCategories"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "name": name,
        "subCategories":
            List<dynamic>.from(subCategories.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'categoryId: $categoryId, subCategories: $subCategories, name: $name';
  }
}
