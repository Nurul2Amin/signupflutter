
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:signup/screens/home.dart';
import 'package:signup/screens/registration.dart';
import 'package:signup/screens/forgot_pass.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}




class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey <FormState>();

  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController passwordcontroller = new TextEditingController();


  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    final emailfield = TextFormField(
        autofocus: false,
        controller: emailcontroller,
        keyboardType: TextInputType.emailAddress,

        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(
              value)) {
            return ("Please Enter a Valid Email");
          }
          return null;
        },
        onSaved: (value) {
          emailcontroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final passwordfield = TextFormField(
        autofocus: false,
        controller: passwordcontroller,
        obscureText: true,

        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is Required for Login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 character");
          }
        },
        onSaved: (value) {
          passwordcontroller.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));



    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          onPressed: () {
            signIn(emailcontroller.text, passwordcontroller.text);
          },
          child: Text("Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold))),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 150,
                          child: Text(
                            "PLAN IT",
                            style: TextStyle(
                                fontSize: 50,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 45),
                        emailfield,
                        SizedBox(height: 20),
                        passwordfield,
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.end ,
                            children: [
                              GestureDetector(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return ForgotPasswordScreeen();
                                  }));
                        },
                                child: Text("Forgot Password?", style: TextStyle(
                                  color: Colors.blue, fontWeight: FontWeight.bold
                                ),),
                              )
                            ],

                          ),
                        ),
                        SizedBox(height: 15),
                        loginButton,
                        SizedBox(height: 15),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Don't have an account?"),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationScreen()));
                                },
                                child: Text("Signup",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15),
                                ),
                              )
                            ]),
                      ]
                  ),
                ),
              ),
            ),
          )),
    );
  }


  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth.signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
            Fluttertoast.showToast(msg: "Login Successful"),
             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen())),


      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

}