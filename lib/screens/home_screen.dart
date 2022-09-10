import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);

    if(productsService.isLoading) return LoadingScreen();




    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: ( BuildContext context, int index) => GestureDetector(
          onTap: () {

            //Se crea una copia del producto para cuando este valla a la pantalla de editar
            productsService.selectedProduct = productsService.products[index].copy();
            Navigator.pushNamed(context, 'product');
          },
          child: ProductCard(
            product: productsService.products[index],
          ))
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){

            productsService.selectedProduct = new Product(
              available: false, 
              name: 'producto temporal', 
              price: 0.0);
            Navigator.pushNamed(context, 'product');

          },
          child: Icon(Icons.add),
          ),
   );
  }
}