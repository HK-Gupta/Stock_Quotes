import 'package:cryptology/cryptology.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_quote_app/config/assets_path.dart';
import 'package:stock_quote_app/screens/auth_screens/register_screen.dart';
import 'package:stock_quote_app/screens/bottom_navigation.dart';
import 'package:stock_quote_app/widgets/custom_text_field.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/snackbar_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  static final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<String> _hashPassword(String password) async {
    final passwordEncryption = PasswordEncryption.initial(difficulty: HashDifficulty.strong);
    return passwordEncryption.hashB64(password);
  }

  userLogin() async{
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final hashedPassword = await _hashPassword(password);
    try{
      await FirebaseAuth
          .instance
          .signInWithEmailAndPassword(
          email: email,
          password: hashedPassword
      );
      SnackbarMessage.showSuccessSnackBar(context, "Logged In Successfully!");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const BottomNavigation()));
    } on FirebaseAuthException catch(e) {
      print("Error as: $e");
      if(e.code=='user-not-found') {
        SnackbarMessage.showErrorSnackBar(context, "User Not Found");
      }
      else if(e.code=='wrong-password') {
        SnackbarMessage.showErrorSnackBar(context, "Wrong Password");
      } else {
        SnackbarMessage.showErrorSnackBar(context, "$e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final x = w < h? w/1.1: h/1.5;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
          key: formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Center(
                    child: Container(
                      width: x/1.5,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primaryContainer
                      ),
                      child: Image.asset(
                        ImagePaths.loginPic
                      )
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Center(
                    child: Text(
                      "Login to your account",
                      style: Theme.of(context).textTheme.bodyMedium
                    ),
                  ),
                  const SizedBox(height: 20,),
                  // Email Text Field related Code.
                  Text(
                    "Email",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  CustomTextField(
                    controller: emailController,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    inputFillColor: Theme.of(context).colorScheme.primaryContainer,
                    inputHint: "Enter Your Email Id",
                    validator: (value) {
                      if(value!.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  // Password Text Field related Code.
                  Text(
                    "Password",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    inputHint: "Enter the Password",
                    obscureText: true,
                    inputFillColor: Theme.of(context).colorScheme.primaryContainer,
                    validator: (value) {
                      if(value!.isEmpty) {
                        return 'Password is weak';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40,),
                  CustomButton(
                    buttonText: "Login",
                    buttonColor: Theme.of(context).colorScheme.primary,
                    onTap: () {
                      if(formKey.currentState!.validate()) {
                        userLogin();
                      }
                    },
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const RegisterScreen()));
                        },
                        child: Text(
                          "Click to Register",
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.blue
                          )
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
      ),
    );;
  }
}
