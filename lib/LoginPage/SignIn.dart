// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kushneta/LoginPage/SignUp.dart';
import 'package:kushneta/MyHomePage/MyHomePage.dart';

class SignIn extends StatefulWidget{
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Email is Required");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value){
          emailController.text  =value!;
        },
        textInputAction : TextInputAction.next,
        decoration: const InputDecoration(
            hintText: "User Email",
            prefixIcon: Icon(Icons.email, color: Colors.blueGrey,)
        )
    );
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
          return null;
        },
        obscureText: true,
        onSaved: (value){
          passwordController.text = value!;
        },
        textInputAction : TextInputAction.done,
        decoration: const InputDecoration(
            hintText: "User Password",
            prefixIcon: Icon(Icons.security, color: Colors.blueGrey,)
        )
    );
    final loginBotton =  Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color(0xFF4e7e92),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          SignIn(emailController.text, passwordController.text);
        },
        child: const Text("Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: 200,
                      child: Image.asset("assets/k.jpg",
                        fit: BoxFit.contain,
                      )
                  ),
                  emailField,
                  passwordField,
                  const SizedBox(height: 45),
                  loginBotton,
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment:  MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Don't have account?  "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context)=>
                                  const SignUp()));
                        },
                        child: const Text("SignUp", style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight:  FontWeight.bold,
                            fontSize:15),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // ignore: non_constant_identifier_names
  void SignIn(String email, String password) async {
    if (formkey.currentState!.validate()) {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((udi) => {
        Fluttertoast.showToast(msg: "Login Successful"),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyHomePage())),
      // ignore: body_might_complete_normally_catch_error
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });

    }
  }
}

