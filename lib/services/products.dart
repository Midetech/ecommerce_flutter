import 'dart:convert';
import 'package:http/http.dart' as http;

Future fetchProducts() async {
  final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products?limit=2'));
  if (response.statusCode == 200) {
    List<dynamic> responseData = json.decode(response.body);
    return responseData;
  } else {
    throw Exception('Failed');
  }
}
