import 'dart:io';

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

            _BackgroundImage(url: product.picture,),

            _ProductDetails(
              title: product.name, 
              subTitle: product.id!,),

            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(product.price)
              ),

            // TODO: mostrar de manera condicional
            if(!product.available)
            Positioned(
              top: 0,
              left: 0,
              child: _NotAvailable()
              )

          ],
        ),

      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
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

  final double price;

  const _PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('${this.price}', style: TextStyle(color: Colors.white, fontSize: 20),),
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


  final String title;
  final String subTitle;

  const _ProductDetails({
    required this.title, 
    required this.subTitle
    });

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
            Text(this.title, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            ),
           Text(this.subTitle, style: TextStyle(fontSize: 15, color: Colors.white),
            maxLines: 1,
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
      const _BackgroundImage({
        Key? key,
        this.url,
      }) : super(key: key);
      final String? url;
      @override
      Widget build(BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: SizedBox(
            width: double.infinity,
            height: 400,
            child: getImage(url),
          ),
        );
      }
     
      Widget getImage(String? picture) {
        if (picture == null) {
          return const Image(
              image: AssetImage('assets/no-image.png'), fit: BoxFit.cover);
        }
        if (picture.startsWith('http')) {
          return FadeInImage(
            placeholder: const AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(url!),
            fit: BoxFit.cover,
          );
        }
        return Image.file(File(picture), fit: BoxFit.cover);
      }
    }








// class _BackgroundImage extends StatelessWidget {


//   final String? url;

//   const _BackgroundImage(this.url);

//   @override
//   Widget build(BuildContext context) {
//     //Al paracer es para utilizar el border radius
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(25),
//       child: Container(
//         width: double.infinity,
//         height: 400,
//         //color: Colors.red,
//         //Cuando la url venga nula entonces pondra la imagen de que no hay imagen y si no traera la imagen de la base de datos
//         child: url == null
//           es ? Image(
//             image: AssetImage('assets/no-image.png'),
//             fit: BoxFit.cover,
//             )
//           :
//         FadeInImage(
//           //TODO: Fix productos cuando no hay imagen
//           placeholder: AssetImage('assets/jar-loading.gif'), 
//           image: NetworkImage(url!),
//           //Para que la imagen quede totalmente expandida
//           fit: BoxFit.cover,
//           ),
//       ),
//     );
//   }
// }