import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_quote_app/config/assets_path.dart';
import 'package:stock_quote_app/widgets/custom_app_bar.dart';
import 'package:stock_quote_app/widgets/custom_text_field.dart';
import 'package:stock_quote_app/widgets/snackbar_message.dart';
import '../../widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isEditable = false;
  bool isLoading = false;
  XFile? _imageFile;
  String imageUrl = "https://firebasestorage.googleapis.com/v0/b/zoomussic.appspot.com/o/user_images%2Fprofile.png?alt=media&token=624856bb-9fd7-4552-a866-2479ea1a9492";
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userData.exists) {
        setState(() {
          nameController.text = userData['name'];
          emailController.text = userData['email'];
          phoneController.text = userData['mobile'];
          passwordController.text = userData['password'];
          String? imageUrl = userData['image'];
          _imageFile = imageUrl != null ? XFile(imageUrl) : null;
        });
      } else {
        print('No user data found');
      }
    } else {
      print('No authenticated user');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<void> _saveUserData() async {
    if (formKey.currentState!.validate()) {
      isLoading= true;
      setState(() {});
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (_imageFile != null) {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('user_images')
              .child(user.uid + '.jpg');
          await storageRef.putFile(File(_imageFile!.path));
          imageUrl = await storageRef.getDownloadURL();
          setState(() {});
        }
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'name': nameController.text,
          'email': emailController.text,
          'mobile': phoneController.text,
          if (imageUrl != null) 'image': imageUrl,
        });
        isEditable = !isEditable;
        isLoading = false;
        setState(() {});
        SnackbarMessage.showSuccessSnackBar(context, "Data Updated Successfully!");
      }
      isLoading= false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final x = w < h ? w / 1.1 : h / 1.5;

    return Form(
      key: formKey,
      child: Scaffold(
        appBar: CustomAppBar(context, "Profile", ""),
        floatingActionButton: isEditable
            ? const SizedBox()
            : InkWell(
                onTap: () {
                  isEditable = !isEditable;
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 30,
                  ),
                ),
              ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: InkWell(
                    onTap: isEditable ? _pickImage : null,
                    child: Container(
                      width: x / 3.3,
                      height: x / 3.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(x),
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: _imageFile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(x),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                                ImagePaths.addCamera,
                                width: x / 3.5,
                                height: x / 3.5,
                              ),
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Name Text
                Text(
                  "Name: ",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 2),
                CustomTextField(
                  controller: nameController,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  inputFillColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  readOnly: !isEditable,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Email Text
                Text(
                  "Email",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 2),
                CustomTextField(
                  controller: emailController,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  inputFillColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  readOnly: !isEditable,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Phone Text
                Text(
                  "Phone No.",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 2),
                CustomTextField(
                  controller: phoneController,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  inputFillColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  readOnly: !isEditable,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Phone Number is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Account Text
                Text(
                  "Password",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 2),
                CustomTextField(
                  controller: passwordController,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  inputFillColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  readOnly: true,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Account details are required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Save Button
                const SizedBox(height: 40),
                isEditable
                    ? isLoading? Center(child: CircularProgressIndicator(),)
                    :CustomButton(
                        buttonText: "Save",
                        buttonColor: Theme.of(context).colorScheme.primary,
                        onTap: _saveUserData,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
