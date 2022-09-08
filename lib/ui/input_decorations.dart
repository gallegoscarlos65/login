import 'package:flutter/material.dart';

class InputDecorations {

  //Puras propiedades estaticas para no tener que hacer instancia despues

  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
  }) {


           return InputDecoration(
                //Para cuando no se esta escribiendo
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple
                  ),          
                ),
                //Para cuando se selecciona
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.indigoAccent,
                    width: 2
                  )
                ),
                hintText: hintText,
                labelText: labelText,
                labelStyle: TextStyle(
                  color: Colors.grey
                ),
                //Evalua si el prefixIcon es diferente de nulo y de ser el caso crea el icono, sino lo deja nulo
                prefixIcon: prefixIcon != null
                 ? Icon(prefixIcon, color: Colors.deepPurple,)
                 : null,
              );



  }

}