import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kushneta/LoginPage/SignIn.dart';
import 'package:kushneta/UserModel/user_model.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


    final auth = FirebaseAuth.instance;
    String? errorMessage;
    final formkey = GlobalKey<FormState>();
    final firstNameEditingController = TextEditingController();
    final secondNameEditingController =  TextEditingController();
    final emailEditingController =  TextEditingController();
    final createPasswordEditingController =  TextEditingController();
    final conformPasswordEditingController =  TextEditingController();


    @override
    Widget build(BuildContext context) {

      final firstNameField = TextFormField(
          autofocus: false,
          controller: firstNameEditingController,
          onSaved: (value){firstNameEditingController.text  =value!;},
          textInputAction : TextInputAction.next,
          keyboardType: TextInputType.name,
          validator: (value) {
            RegExp regex = RegExp(r'^.{3,}$');
            if (value!.isEmpty) {
              return ("First Name cannot be Empty");
            }
            if (!regex.hasMatch(value)) {
              return ("Enter Valid name(Min. 3 Character)");
            }
            return null;
          },
          decoration: const InputDecoration(
              hintText: "First Name",
              prefixIcon: Icon(Icons.people, color: Colors.blueGrey,)
          )
      );

      final secondNameField = TextFormField(
          autofocus: false,
          controller: secondNameEditingController,
          onSaved: (value){secondNameEditingController.text  =value!;},
          validator: (value) {
            if (value!.isEmpty) {
              return ("Second Name cannot be Empty");
            }
            return null;
          },
          decoration: const InputDecoration(
              hintText: "Second Name",
              prefixIcon: Icon(Icons.people, color: Colors.blueGrey,)
          )
      );

      final emailField = TextFormField(
          autofocus: false,
          controller: emailEditingController,
          keyboardType: TextInputType.emailAddress,
          onSaved: (value){emailEditingController.text  =value!;},
          textInputAction : TextInputAction.next,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Please Enter Your Email");
            }
            // reg expression for email validation
            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                .hasMatch(value)) {
              return ("Please Enter a valid email");
            }
            return null;
          },
          decoration: const InputDecoration(
              hintText: "Email Address ",
              prefixIcon: Icon(Icons.email, color: Colors.blueGrey,)
          )
      );

      final createPasswordField = TextFormField(
          autofocus: false,
          controller: createPasswordEditingController,
          obscureText: true,
          onSaved: (value){createPasswordEditingController.text  =value!;},
          textInputAction : TextInputAction.next,
          validator: (value) {
            RegExp regex = RegExp(r'^.{6,}$');
            if (value!.isEmpty) {
              return ("Password is required for login");
            }
            if (!regex.hasMatch(value)) {
              return ("Enter Valid Password(Min. 6 Character)");
            }
            return null;
          },
          decoration: const InputDecoration(
              hintText: "Create Password",
              prefixIcon: Icon(Icons.security, color: Colors.blueGrey,)
          )
      );

      final conformPasswordField = TextFormField(
          autofocus: false,
          controller: conformPasswordEditingController,
          obscureText: true,
          onSaved: (value){conformPasswordEditingController.text  =value!;},
          textInputAction : TextInputAction.done,
          validator: (value) {
            if (conformPasswordEditingController.text !=
                createPasswordEditingController.text) {
              return "Password don't match";
            }
            return null;
          },
          decoration: const InputDecoration(
              hintText: "Conform Password",
              prefixIcon: Icon(Icons.security, color: Colors.blueGrey,)
          )
      );

      // ignore: non_constant_identifier_names
      final SignUpBottonField =  Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color:const Color(0xFF4e7e92),
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: (){
            SignUp(emailEditingController.text, createPasswordEditingController.text);
          },
          child: const Text("SignUp",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );


      return  Scaffold(
        backgroundColor:Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon (Icons.arrow_back, color: Colors.grey),
            onPressed: () {Navigator.of(context).pop() ; },
          ),
        ),
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
                    firstNameField,
                    const SizedBox(height: 25),
                    secondNameField,
                    const SizedBox(height: 25),
                    emailField,
                    const SizedBox(height: 25),
                    createPasswordField,
                    const SizedBox(height: 25),
                    conformPasswordField,
                    const SizedBox(height: 45),
                    SignUpBottonField
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    // ignore: non_constant_identifier_names
    void SignUp(String email, String password) async {
      if (formkey.currentState!.validate()) {
        try {
          await auth
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) => {postDetailsToFirestore()})
              // ignore: body_might_complete_normally_catch_error
              .catchError((e) {
            Fluttertoast.showToast(msg: e!.message);
          });
        } on FirebaseAuthException catch (error) {
          switch (error.code) {
            case "invalid-email":
              errorMessage = "Your email address appears to be malformed.";
              break;
            case "wrong-password":
              errorMessage = "Your password is wrong.";
              break;
            case "user-not-found":
              errorMessage = "User with this email doesn't exist.";
              break;
            case "user-disabled":
              errorMessage = "User with this email has been disabled.";
              break;
            case "too-many-requests":
              errorMessage = "Too many requests";
              break;
            case "operation-not-allowed":
              errorMessage = "Signing in with Email and Password is not enabled.";
              break;
            default:
              errorMessage = "An undefined Error happened.";
          }
          Fluttertoast.showToast(msg: errorMessage!);
          print(error.code);
        }
      }
    }
    postDetailsToFirestore() async {
      // calling our firestore
      // calling our user model
      // sending these values

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = auth.currentUser;

      UserModel usermodel = UserModel();
      // writing all the values
      usermodel.email = user!.email;
      usermodel.uid = user.uid;
      usermodel.FirstName = firstNameEditingController.text;
      usermodel.SecondName = secondNameEditingController.text;

      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(usermodel.toMap());
      Fluttertoast.showToast(msg: "Account created successfully :) ");

      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => const SignIn()),
              (route) => false);
    }


  }
