import 'package:flutter/material.dart';

import '../models/models.dart';

class ProductCard extends StatelessWidget {
  //const ProductCard({Key? key}) : super(key: key);

  final Product product;

  const ProductCard({
    Key? key,
    required this.product
  }): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [

            _BackgroundImage(),

            _ProductDetails(),

            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag()),

            // TODO: mostrar de manera condicional
            Positioned(
              top: 0,
              left: 0,
              child: _NotAvailable())

          ],
        ),

      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    //boxShadow lista de sombras
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 7),
        blurRadius: 10
      )
    ]
  );
}

class _NotAvailable extends StatelessWidget {
  // const _NotAvailable({
  //   Key? key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          'No disponible',
          style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  // const _PriceTag({
  //   Key? key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //El slash invertido se usa para escapar un texto y que no piense que es una variable
      //El FittedBox sirve para que se adapte al espacio que tiene el contenedor
      child: FittedBox(
        //fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('\$10333s.99', style: TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
      ),
    );
  }
}



class _ProductDetails extends StatelessWidget {
  // const _ProductDetails({
  //   Key? key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        //color: Colors.indigo,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$this.product', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            //Sirve solo para permitir solo cierto numero de lineas
            maxLines: 1,
            //Sirve para poner puntos suspensivos cuando una palabra no alcanza a ser completada
            overflow: TextOverflow.ellipsis,
            ),
           Text('Id del disco duro', style: TextStyle(fontSize: 15, color: Colors.white),
            //Sirve solo para permitir solo cierto numero de lineas
            maxLines: 1,
            //Sirve para poner puntos suspensivos cuando una palabra no alcanza a ser completada
            overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25)),


  );
}

class _BackgroundImage extends StatelessWidget {
  // const _BackgroundImage({
  //   Key? key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Al paracer es para utilizar el border radius
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        //color: Colors.red,
        child: FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'), 
          image: NetworkImage('https://via.placeholder.com/400x300/f6f6f6'),
          //Para que la imagen quede totalmente expandida
          fit: BoxFit.cover,
          ),
      ),
    );
  }
}