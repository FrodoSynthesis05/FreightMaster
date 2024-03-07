import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freightmaster/AllScreens/loginScreen.dart';
import 'package:freightmaster/AllScreens/mainscreen.dart';
import 'package:freightmaster/main.dart';


TextEditingController nameTextEditingController = TextEditingController();
TextEditingController emailTextEditingController = TextEditingController();
TextEditingController phoneTextEditingController = TextEditingController();
TextEditingController passwordTextEditingController = TextEditingController();


class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key});

  static const String idScreen = "register";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 15.0,),
              Align(
                alignment: Alignment.topCenter,
                child: Image(
                  image: AssetImage("images/logo.png"),
                  width: 250.0,
                  height: 250.0,
                ),
              ),

              SizedBox(height: 1.0,),
              Text("Registrarse como Cliente",
                  style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                  textAlign: TextAlign.center
              ),


              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    //NOMBRE
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Nombre",
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



                    //TELEFONO
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Telefono",
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




                    //EMAIL
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingController,
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



                    //PW
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingController,
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
                        if(nameTextEditingController.text.length < 3)
                        {
                          displayToastMessage("El campo de nombre debe contener al menos 3 caracteres.", context);
                        }
                        else if (!emailTextEditingController.text.contains("@"))
                        {
                          displayToastMessage("Correo electronico invalido.", context);
                        }
                        else if (!phoneTextEditingController.text.isEmpty)
                        {
                          displayToastMessage("El numero telefonico es obligatorio.", context);
                        }
                        else if (passwordTextEditingController.text.length < 6)
                        {
                          displayToastMessage("La contraseña debe tener al menos 6 caracteres.", context);
                        }
                        else{
                          registerNewUser(context);
                        }

                      },
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Registrar",
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
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                },
                child: Text(
                    "Ya tienes una cuenta? Inicia sesion aqui."
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async
  {
    final User? firebaseUser = (await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errMsg){
      displayToastMessage("Error: " + errMsg, context);
    })).user;

    if(firebaseUser != null) // Usuario creado
    {
              // Guardar info bd firebase
    Map userDataMap = {
      "name": nameTextEditingController.text.trim(),
      "email": emailTextEditingController.text.trim(),
      "phone": phoneTextEditingController.text.trim(),
    };
    usersRef.child(firebaseUser.uid).set(userDataMap);
    displayToastMessage("Cuenta creada exitosamente", context);

    Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
    }
    else
    {
      // Mostrar mensaje de error
      displayToastMessage("El usuario no ha sido creado", context);
    }
  }



}

displayToastMessage(String message, BuildContext context)
{
  Fluttertoast.showToast(msg: message);
}
