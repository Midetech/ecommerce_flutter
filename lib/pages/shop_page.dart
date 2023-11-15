import 'dart:convert';

import 'package:ecommerce_app_flutter/components/my_drawer.dart';
import 'package:ecommerce_app_flutter/components/product_tile.dart';
import 'package:ecommerce_app_flutter/models/product.dart';
import 'package:ecommerce_app_flutter/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  late List<Product> products;

  @override
  void initState() {
    super.initState();
    products = [];
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON array
      List<dynamic> responseData = json.decode(response.body);

      setState(() {
        // Convert the JSON array to a list of Product objects
        products = responseData.map((json) => Product.fromJson(json)).toList();
      });
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception or handle the error accordingly.
      throw Exception('Failed to load data from the API');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = context.watch<Shop>().cart;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 0,
          title: const Text('Shop Page'),
          actions: [
            Stack(alignment: Alignment.center, children: [
              IconButton(
                  onPressed: () => Navigator.pushNamed(context, '/cart'),
                  icon: const Icon(Icons.shopping_cart_outlined)),
              cartItems.isNotEmpty
                  ? Positioned(
                      right: 3,
                      top: 5,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 10,
                        child: Text(
                          "${cartItems.length}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
            ])
          ],
        ),
        drawer: const MyDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ListView(
          children: [
            const Gap(25),
            Center(
                child: Text(
              'Please pick a selected list of premium products',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
            )),
            SizedBox(
              height: 590,
              child: products.isEmpty
                  ? const Center(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.red,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                        Gap(25),
                        Text('Loading products...')
                      ],
                    ))
                  : ListView.builder(
                      padding: const EdgeInsets.all(15.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductTile(product: product);

                        // return Text('producttitle');
                      }),
            ),
          ],
        ));
  }
}
