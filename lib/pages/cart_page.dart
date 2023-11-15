import 'dart:io';

import 'package:ecommerce_app_flutter/components/my_button.dart';
import 'package:ecommerce_app_flutter/models/product.dart';
import 'package:ecommerce_app_flutter/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

String publicKey = 'pk_test_1f5f152fa0b580a0dff31dbb1831575b60112d2f';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final plugin = PaystackPlugin();

  String? _cardNumber;
  String? _cvv;
  int? _expiryMonth;
  int? _expiryYear;

  @override
  void initState() {
    super.initState();
    plugin.initialize(publicKey: publicKey);
  }

  void removeFromCart(BuildContext context, Product product) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Remove ${product.title} from your cart?"),
              actions: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);

                    context.read<Shop>().removeFromCart(product);
                  },
                  child: const Text('Yes'),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        title: const Text('Cart Page'),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Expanded(
              child: cart.isEmpty
                  ? const Center(
                      child: Text('No item added to cart yet'),
                    )
                  : ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final item = cart[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(item.image, scale: 0.01),
                          ),
                          title: Text(
                            item.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(item.price.toStringAsFixed(2)),
                          trailing: Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12)),
                            child: IconButton(
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                              onPressed: () => removeFromCart(context, item),
                            ),
                          ),
                        );
                      },
                    )),
          Visibility(
            visible: cart.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: MyButton(
                  onTap: () => _handleCheckout(context),
                  child: const Text('PAY NOW')),
            ),
          )
        ],
      ),
    );
  }

  _handleCheckout(BuildContext context) async {
    Charge charge = Charge()
      ..amount = 10000 // In base currency
      ..email = 'customer@email.com'
      ..card = _getCardFromUI();

    charge.reference = _getReference();

    try {
      CheckoutResponse response = await plugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge,
        fullscreen: false,
        logo: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.background,
          ),
          child: Icon(
            Icons.shopping_bag,
            size: 32,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      );
      debugPrint('Response = $response');
      _updateStatus(response.reference, '$response');
    } catch (e) {
      _showMessage("Check console for error");
      rethrow;
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _expiryMonth,
      expiryYear: _expiryYear,
    );
  }

  _updateStatus(String? reference, String message) {
    _showMessage('Reference: $reference \n Response: $message',
        const Duration(seconds: 7));
  }

  _showMessage(String message,
      [Duration duration = const Duration(seconds: 4)]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: duration,
      action: SnackBarAction(
          label: 'CLOSE',
          onPressed: () =>
              ScaffoldMessenger.of(context).removeCurrentSnackBar()),
    ));
  }
}
