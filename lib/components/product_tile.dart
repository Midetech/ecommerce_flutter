import 'package:ecommerce_app_flutter/models/product.dart';
import 'package:ecommerce_app_flutter/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({super.key, required this.product});

  void addToCart(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Add ${product.title} to your cart?"),
              actions: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);

                    context.read<Shop>().addToCart(product);
                  },
                  child: const Text('Yes'),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  // child: const Icon(Icons.favorite)
                  child: Image.network(product.image),
                ),
              ),
              const Gap(25),
              Text(
                product.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Gap(10),
              Text(
                product.description,
                maxLines: 3,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              const Gap(25),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${product.price.toStringAsFixed(2)}'),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: IconButton(
                  onPressed: () => addToCart(context),
                  icon: const Icon(Icons.add),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
