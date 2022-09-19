import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/services/services.dart';

import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';



class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 250,),

              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text('Crear cuenta', style: Theme.of(context).textTheme.headline4,),
                    SizedBox(height: 30,),

                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                    child: _LoginForm(),
                    )
                  ],
                )
              ),

              SizedBox(height: 50,),

              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  //Para hacer los bordes como redondeados
                  shape: MaterialStateProperty.all(StadiumBorder())
                ),
                //El pushReplacementNamed destruye el stack de pantallas que se tenia anteriormente
                onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
                  child: Text('¿Ya tienes una cuenta?', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                ), 

              SizedBox(height: 50,)
            ],
          ),
        )
      ),
   );
  }
}

class _LoginForm extends StatelessWidget {
  //const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Con este login form se tiene acceso a toda la clase de login_form_provider
  final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      //El form tiene una referencia interna al estado que tienen sus widgets internos
      child: Form(
        //TODO: mantener la referencia al KEY,
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [
            TextFormField(
              //Para que no intente corregir
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'john.doe@gmail.com', 
                labelText: 'Correo electronico',
                prefixIcon: Icons.alternate_email_sharp
                ),
                //EL login form va a ir establecido por lo que sea que se reciba en el value
                onChanged: (value) => loginForm.email = value,
              //El validator es una funcion
              validator: (value) {

                  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp  = new RegExp(pattern);
                  //Toma la expresión regular y verifica si hace match
                  return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';

              }
              //decoration: 
            ),
            SizedBox(height: 30,),
            TextFormField(
              //Para que no intente corregir
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*****', 
                labelText: 'Password',
                prefixIcon: Icons.lock
                ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {

                  return (value != null  && value.length >= 6) 
                  ? null
                  : 'La contraseña debe de ser de 6 caracteres';
                  //Toma la expresión regular y verifica si hace match

              }

              //decoration: 
            ),
            SizedBox(height: 30,),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                child: Text(
                  loginForm.isLoading
                  ? 'Espere'
                  : 'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              //Si esta cargando se va a regresar un nulo sino lo demas
              onPressed: loginForm.isLoading ? null : () async{
                  //Para quitar el teclado cuando pulsan el boton
                  FocusScope.of(context).unfocus();
                  final authService = Provider.of<AuthService>(context, listen: false);


                  // TODO: Login form
                  //Si esto es false que no haga nada
                  if(!loginForm.isValidForm() ) return;
                  //Si esto esta bien que navege a la siguiente pantalla
                  //El pushReplacementNamed, destruye el stack de las pantallas y ya no se puede regresar
                  loginForm.isLoading = true;


                  // TODO: Validar si el login es correcto
                  final String? errorMessage = await authService.createUser(loginForm.email, loginForm.password);
                  if(errorMessage == null){
                    Navigator.pushReplacementNamed(context, 'home');
                  } else{
                    //TODO: mostrar error en pantalla
                    print(errorMessage);
                  }


                  //await Future.delayed(Duration(seconds: 2));
                  //TODO: Validar si el loign es correcto
                  loginForm.isLoading = false;
                  //Navigator.pushReplacementNamed(context, 'home');
              }
              )
          ],
          

        ),
        ),
    );
  }
}