import 'dart:convert';

import 'package:ecommerce_app/model/produit.dart';
import 'package:http/http.dart' as http;
class ProductService{
  Future<List> getProducts() async {
    var url = Uri.parse("https://fakestoreapi.com/products");
    var response = await http.get(url);
    if(response.statusCode == 200){
      dynamic dataMap = jsonDecode(response.body);
      print(dataMap);
      return dataMap as List;
    }else{
      throw Exception("Failed to load products");
    }
  }
}