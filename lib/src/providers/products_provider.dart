import 'dart:convert';

import 'package:images_app/src/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:images_app/src/preferences/user_preferences.dart';

class ProductsProvider{
  
  final String _url = 'flutter-varios-7d47a-default-rtdb.firebaseio.com';
  final _prefs = new UserPreferences();
  
  Future<bool> createProduct( ProductModel product ) async {
    final url = Uri.https(_url,'productos.json', { "auth": _prefs.token });
    final resp = await http.post(url, body: productModelToJson(product) );
    final decodedData = json.decode(resp.body );
    return true;
  }

  Future<List<ProductModel>> getProducts() async {
    final url = Uri.https(_url,'productos.json', { "auth": _prefs.token });
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body );
    
    if(decodedData == null) return [];
    if(decodedData['error'] != null) return [];

    final data = <ProductModel>[];
 
    decodedData.forEach((id, value){
      final prod = ProductModel.fromJson(value);
      prod.id = id;
      data.add(prod);
    });
    return data;
  }

  Future<int> deleteProduct( String id ) async {
    final url = Uri.https(_url, 'productos/$id.json', { "auth": _prefs.token });
    final resp = await http.delete(url);
    return 1;
  }

  Future<bool> editProduct( ProductModel product ) async {
    final url = Uri.https(_url,'productos/${product.id}.json');
    final resp = await http.put(url, body: productModelToJson(product) );
    final decodedData = json.decode(resp.body );
    return true;
  }

}