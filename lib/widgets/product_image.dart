import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  //const ProductImage({Key? key}) : super(key: key);

  final String? url;

  const ProductImage({
    Key? key,
    this.url
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        width: double.infinity,
        height: 450,
        decoration: _buidBoxDecoration(),
        child: Opacity(
          opacity: 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            child: getImage(url),

          ),
        ),
      ),
      );
  }

  BoxDecoration _buidBoxDecoration() => BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
    boxShadow: 
    [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: Offset(0,5)
      )
    ]
  );

  Widget getImage(String ? picture){
    if(picture == null)
      return Image(image: AssetImage('assets/no-image.png'),
                fit: BoxFit.cover,
      );

    if(picture.startsWith('http'))
        return  FadeInImage(
                image: NetworkImage('${this.url!}'),
                placeholder: AssetImage('assets/jar-loading.gif'),
                fit: BoxFit.cover,
        );
    
    return Image.file(
      //Se va a mandar el picture el cual es un path fisico del dispositivo
      File(picture),
      fit: BoxFit.cover,
      // height: 55,
      // width: 55, 
    );        
  }
}