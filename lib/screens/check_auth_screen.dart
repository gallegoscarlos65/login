import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    //No se necesita redibujar el widget por lo tanto se pone el listene n false para que no este escuchando los cambios
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          //Es el future que se va a mandar a llamar
          future: authService.readToken(),
          //El builder es algo que tiene que regresar un widget por lo tanto no se puede sacar al usuario con una redireccion normal
          builder: (BuildContext context, AsyncSnapshot<String>snapshot) {

            if(!snapshot.hasData)
              return Text('');

            if(snapshot.data == ''){
                          Future.microtask(() {

              Navigator.pushReplacement(context, PageRouteBuilder(
                //Necesita un builder el cual es la pagina que va a terminar aterrizando
                pageBuilder: ( _, __, ___) => LoginScreen(),
                transitionDuration: Duration(seconds: 0)
                
                ));


              //La animacion no se ve natural por lo tanto se debe de hacer una animación manual
              //Navigator.of(context).pushReplacementNamed('login');
            });
            }else{
              Future.microtask(() {

              Navigator.pushReplacement(context, PageRouteBuilder(
                //Necesita un builder el cual es la pagina que va a terminar aterrizando
                pageBuilder: ( _, __, ___) => HomeScreen(),
                transitionDuration: Duration(seconds: 0)
                
                ));


              //La animacion no se ve natural por lo tanto se debe de hacer una animación manual
              //Navigator.of(context).pushReplacementNamed('login');
            });


            }



            return Container();


            //TODO: Esto tronaria porque primero se necesita contruir el widget antes de dar una instruccion
            // Navigator.of(context).pushReplacementNamed('home');
            // return Container();
          },
        ),
      ),
    );
  }
}