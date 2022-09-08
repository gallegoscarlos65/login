import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  //const ProductImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        width: double.infinity,
        height: 450,
        decoration: _buidBoxDecoration(),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          child: FadeInImage(
            image: NetworkImage('https://via.placeholder.com/400x300/green'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            //Para que se adapte al tamaño
            fit: BoxFit.cover,
          ),
        ),
      ),
      );
  }

  BoxDecoration _buidBoxDecoration() => BoxDecoration(
    color: Colors.red,
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
}