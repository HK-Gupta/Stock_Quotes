import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptology/cryptology.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:stock_quote_app/config/assets_path.dart';
import 'package:stock_quote_app/screens/auth_screens/login_screen.dart';
import 'package:stock_quote_app/widgets/custom_text_field.dart';
import 'package:stock_quote_app/widgets/snackbar_message.dart';


import '../../models/user_model.dart';
import '../../services/database_methods.dart';
import '../../widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  static final formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  DateTime? selectedDOB;
  bool isOver18 = true;
  bool isLoading = false;

  Future<void> selectDateOfBirth(BuildContext context) async {
    final DateTime? pickedDOB = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970, 1, 1),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).colorScheme.onSecondary, // header background color
              onPrimary: Theme.of(context).colorScheme.background, // header text color
              onSurface: Theme.of(context).colorScheme.onPrimary, // body text color
            ),
            dialogBackgroundColor: Colors.deepPurple.shade50, // background color
          ),
          child: child!,
        );
      },
    );
    if (pickedDOB != null && pickedDOB != selectedDOB) {
        selectedDOB = pickedDOB;
        isOver18 = DateTime.now().difference(selectedDOB!).inDays >= 365 * 18;
        setState(() { });
    }
  }

  Future<String> _hashPassword(String password) async {
    final passwordEncryption = PasswordEncryption.initial(difficulty: HashDifficulty.strong);
    return passwordEncryption.hashB64(password);
  }

  registerAccount() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final hashedPassword = await _hashPassword(password);
    print("Password: $hashedPassword");
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: hashedPassword
      );

      String id = FirebaseAuth.instance.currentUser?.uid ?? 'default_id'; // Ensure valid ID
      UserModel newUser = UserModel(
        id: id,
        name: nameController.text.trim(),
        email: email,
        mobile: mobileNoController.text.trim(),
        image: '',
        password: hashedPassword,
        dob: selectedDOB!,
      );

      await FirebaseFirestore.instance.collection('users').doc(id).set(newUser.toMap());
      isLoading = false;
      setState(() {});
      SnackbarMessage.showSuccessSnackBar(context, "Account Created Successfully. Kindly Login!");
      Navigator.push(context, MaterialPageRoute(builder: (_)=>const LoginScreen()));
    } on FirebaseAuthException catch(e) {
      isLoading = false;
      setState(() {});
      if(e.code=='weak-password') {
        SnackbarMessage.showErrorSnackBar(context, "Password Provided is Weak");
      }
      else if(e.code=='email-already-in-use') {
        SnackbarMessage.showErrorSnackBar(context, "Account Already Exists");
      } else {
        SnackbarMessage.showErrorSnackBar(context, e as String);
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
                        width: x/1.7,
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
                        "Create an account",
                        style: Theme.of(context).textTheme.bodyMedium
                    ),
                  ),
                  const SizedBox(height: 20,),

                  // Name Text Field related Code.
                  Text(
                    "Name",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  CustomTextField(
                    controller: nameController,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    inputFillColor: Theme.of(context).colorScheme.primaryContainer,
                    inputHint: "Enter Your Full Name",
                    validator: (value) {
                      if(value!.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),

                  // Email Text Field related Code.
                  Text(
                    "Email",
                    style: Theme.of(context).textTheme.labelMedium,
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
                    style: Theme.of(context).textTheme.labelMedium,
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
                  const SizedBox(height: 10,),

                  // Password Confirmation Text Field related Code.
                  Text(
                    "Confirm Password",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  CustomTextField(
                    controller: confirmPasswordController,
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
                      } else if(value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  // Phone Number Text Field related Code.
                  const SizedBox(height: 10,),
                  Text(
                    "Mobile No.",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  CustomTextField(
                    controller: mobileNoController,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    inputFillColor: Theme.of(context).colorScheme.primaryContainer,
                    inputHint: "Enter Your Phone No.",
                    inputKeyBoardType: TextInputType.number,
                    validator: (value) {
                      if(value!.isEmpty) {
                        return 'Phone No. is required';
                      }
                      return null;
                    },
                  ),

                  // DOB Logic
                  const SizedBox(height: 10,),
                  Text(
                    "Date Of Birth",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    width: x/1.8,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary
                        ),
                        borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).colorScheme.primaryContainer
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedDOB == null
                              ? 'Today'
                              : "${selectedDOB!}".split(' ')[0],
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(width: 20,),
                        InkWell(
                          onTap: () => selectDateOfBirth(context),
                            child: const Icon(Icons.calendar_month_rounded)
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 40,),
                  isLoading? const Center(child: CircularProgressIndicator())
                  :CustomButton(
                    buttonText: "Signup",
                    buttonColor: Theme.of(context).colorScheme.primary,
                    onTap: () {
                      if(!isOver18) {
                        SnackbarMessage.showErrorSnackBar(
                          context,
                          "You must be at least 18 year old"
                        );
                      }
                      if(formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        registerAccount();
                      }
                    },
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>const LoginScreen()));
                        },
                        child: Text(
                            "Click to Login",
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
