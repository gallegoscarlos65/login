import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {

  final String _baseUrl = 'flutter-varios-41b97-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  //Cuando no halla ningun producto va a estar cargando por lo tanto es true
  bool isLoading = true;

  //Cuando la instancia de ProductsService sea llamada se va a querer disparar un metodo
  ProductsService() {
    this.loadProducts();
  }

  // TODO: Hacer fetch de los productos
  //Este es el metodo 
  Future<List<Product>> loadProducts() async {

    this.isLoading = true;
    notifyListeners();

    //authority, unencodedPath
    final url = Uri.https(_baseUrl, 'producst.json');
    final resp = await http.get(url);

    //Se tiene que transformar ese body en un mapa
    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value){
      //Se usa fromMap por que eso es un mapa y se sabe por que tiene llaves en la impresion en consola
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);
    });

    this.isLoading = false;
    notifyListeners();

    return this.products;
    // print(this.products[0].name);

    // print(productsMap);


  }
}