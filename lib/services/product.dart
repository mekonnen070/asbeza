import 'package:asbeza_app/models/product.dart';

class ProductService {
  static Future<List<Product>?> products(String categoryId) async {
    return null;

    // try {
    //   QueryOptions options = QueryOptions(
    //       document: gql(GetSchema.productsQuery),
    //       variables: {"categoryId": categoryId});

    //   QueryResult response = await client.value.query(options);
    //   if (response.data != null) {
    //     return ProductsResult.fromJson(response.data!).products;
    //   } else {
    //     return throw Error;
    //   }
    // } catch (e) {
    //   dev.log(e.toString());
    // }

    // return null;
  }
}
