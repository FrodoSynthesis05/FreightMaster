import 'package:flutter/material.dart';
import 'package:freightmaster/AllScreens/registrationScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

  static const String idScreen = "login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 45.0,),
              Align(
                alignment: Alignment.topCenter,
                child: Image(
                  image: AssetImage("images/logo.png"),
                  width: 250.0,
                  height: 250.0,
                ),
              ),
          
              SizedBox(height: 1.0,),
              Text("Iniciar sesion como Cliente",
              style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
              textAlign: TextAlign.center
              ),
          
          
              Padding(
                  padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 1.0,),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Correo electronico",
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                      ),
                    ),
                    style: TextStyle(fontSize: 14.0,
                    ),
                  ),
          
                  SizedBox(height: 1.0,),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                      ),
                    ),
                    style: TextStyle(fontSize: 14.0,
                    ),
                  ),
          
                  SizedBox(height: 10.0,),
                  ElevatedButton(
                    onPressed: () 
                    {
                      print("login button clicked");
                    },
                    child: Container(
                    height: 50.0,
                    child: Center(
                      child: Text(
                        "Iniciar Sesion",
                        style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                      ),
                    ),
                  ),
                  ),
          
                ],
              ),),
              TextButton(
                onPressed: ()
                {
                  Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
                },
                child: Text(
                  "No tienes una cuenta? Crea una aqui."
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
