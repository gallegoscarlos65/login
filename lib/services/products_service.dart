import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {

  final String _baseUrl = 'flutter-varios-41b97-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product ?selectedProduct;

  File? newPictureFile;

  //Cuando no halla ningun producto va a estar cargando por lo tanto es true
  bool isLoading = true;
  bool isSaving = false;

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

  Future saveOrCreateProduct(Product product) async {

    isSaving = true;
    notifyListeners();
    //si es igual a nulo significa que es necesario crear
    if(product.id == null){
      //Es necesario crear
      await this.createProduct(product);
    }
    //En caso contrario quiere decir que es necesario actualizar
    else{
      //Actualizar
      await this.updateProduct(product);
    }



    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
//producst
    final url = Uri.https(_baseUrl, 'producst/${ product.id }.json');
    final resp = await http.put(url, body: product.toJson());
    final decodedData = resp.body;

    //print(decodedData);

    //TODO: Actualizar el listado de productos
    //Se toman todos los productos y se busca el indice del elemento donde elemento id sea igual a product.id
    final index = this.products.indexWhere((element) => element.id == product.id);
    
    //Actualización
    this.products[index] = product;

    return product.id!;

  }

  Future<String> createProduct(Product product) async {
//producst
    final url = Uri.https(_baseUrl, 'producst.json');
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode(resp.body);

    //TODO: Actualizar el listado de productos
    product.id  = decodedData['name'];

    this.products.add(product);

    return product.id!;

  }

  void updateSelectedProductImage(String path){


    this.selectedProduct!.picture = path;
    this.newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();

  }

  // El signo de ? es para ponerlo opcional
  Future<String?> uploadImage() async {

    if( this.newPictureFile == null) return null;

    this.isSaving = true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dssadxus5/image/upload?upload_preset=kgqmv369');    

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromString('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);


    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return null;
    }

    this.newPictureFile = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
    //print(resp.body);

    //final imageUploadRequest = http.MultipartRequest('POST',url);

    //final file = await http.

  }


}