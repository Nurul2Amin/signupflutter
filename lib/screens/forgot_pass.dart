import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreeen extends StatefulWidget {
  const ForgotPasswordScreeen({super.key});

  @override
  State<ForgotPasswordScreeen> createState() => _ForgotPasswordScreeenState();
}

class _ForgotPasswordScreeenState extends State<ForgotPasswordScreeen> {

  final TextEditingController emailcontroller = new TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  Future passwordReset()  async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text.trim());
      showDialog(context: context, builder:(context){
        return AlertDialog(
          content: Text("Password reset link sent check email"),
        );
      },
      );
    } on FirebaseException catch(e){
    print(e);
    showDialog(context: context, builder:(context){
      return AlertDialog(
        content: Text(e.message.toString()),
      );
    },
    );
    }
  }


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
          contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
          hintText: "Email",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ));
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget> [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text("Enter Your Email and we wil send you a password resetting", textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),),
          ),

          SizedBox(height: 20),
          emailfield,
          MaterialButton(
              onPressed: passwordReset,
            child: Text("Reset Password"),
            color: Colors.blue

          ),

        ],
      ),
    );
  }
}
