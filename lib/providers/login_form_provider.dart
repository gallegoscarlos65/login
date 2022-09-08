import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{
  //Si fuese Scaffol seria <ScaffoldState>
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading( bool value){
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm(){

    print(formKey.currentState?.validate());

    print('$email - $password');

    //Regresa si el formulario es valido
    return formKey.currentState?.validate() ?? false;

  }


}