import 'package:flutter/material.dart';
import 'package:token_api_project/controllers/product_controller.dart';
import 'package:token_api_project/models/product_model.dart';
import 'package:token_api_project/models/user_model.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductController _productController = ProductController();

  @override
  void initState() {
    super.initState();

    _productController.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.user.firstName}!"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _productController.getAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final ProductModel productModel = snapshot.data!;
              final products = productModel.products;

              return ListView.builder(
                  itemCount: products!.length,
                  itemBuilder: (context, index) {
                    final product = products![index];

                    return Card(
                      child: ListTile(
                        title: Text("${product.title}"),
                        subtitle: Text("${product.price}"),
                      ),
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
