import 'package:ecommerce_app_flutter/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag,
                size: 72,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const Gap(25),
              const Text(
                'E-Market Place',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(10),
              Text(
                'Premium Quality Products',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const Gap(10),
              MyButton(onTap: () => Navigator.pushNamed(context, '/shop_page'), child: const Icon(Icons.arrow_forward)),
            ],
          ),
        ));
  }
}
