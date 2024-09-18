import 'dart:convert';
import 'package:token_api_project/api/api.dart';
import 'package:token_api_project/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductController {
  final client = http.Client();

  Future<ProductModel?> getAllProducts() async {
    try {
      final response = await client.get(
        Uri.parse("${API().baseUrl}${API().allProducts}"),
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        final ProductModel product = ProductModel.fromJson(responseBody);
        print(product);
        return product;
      }
    } catch (e) {
      print("$e");
    }
  }
}
