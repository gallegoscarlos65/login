import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  //const CardContainer({Key? key}) : super(key: key);

  final Widget child;

  const CardContainer({
    Key? key,
    required this.child
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      // padding: const EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        //height: 300,
        //color: Colors.red,
        decoration: _createCardShape(),
        child: this.child,

      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      //Lo de la sombra en la caja
      BoxShadow(
        color: Colors.black12,
        blurRadius: 15,
        //0 en x, 0 en y
        offset: Offset(0, 5)
      )
    ]
  );
}