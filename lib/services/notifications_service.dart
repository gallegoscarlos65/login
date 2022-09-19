import 'package:flutter/material.dart';

class NotificationsService {

  //El messenger key va a servir para mantener la referencia al material app
  static GlobalKey<ScaffoldMessengerState> messengerKey = new GlobalKey<ScaffoldMessengerState>();

  //Este key va servir para poder llamar a los snackbar en cualquier lado
  //La idea de este showSnackbar es que se pueda mostrar en cualquier lado de la aplicacion y va a recibir un mensaje el cual va a ser lo que mostrara el snackbar
  static showSnackbar(String message){

    final snackBar = new SnackBar(
      content: Text(
        message, style: TextStyle(color: Colors.white, fontSize: 20),
      ));

    messengerKey.currentState!.showSnackBar(snackBar);

  }

}