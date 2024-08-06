import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_quote_app/config/assets_path.dart';
import 'package:stock_quote_app/widgets/custom_app_bar.dart';
import 'package:stock_quote_app/widgets/custom_text_field.dart';

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
  TextEditingController accountController = TextEditingController();
  bool isEditable = false;

  @override
  void initState() {
    nameController.text = "name";
    emailController.text = "email";
    phoneController.text = "1397129989";
    accountController.text = "4547541316441";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final x = w < h? w/1.1: h/1.5;
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: CustomAppBar(context, "Profile", ""),
        floatingActionButton: isEditable? const SizedBox():
        InkWell(
          onTap: () {
            isEditable = !isEditable;
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(50)
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
                const SizedBox(height: 20,),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(x),
                      border: Border.all(
                        color: Colors.white,
                        width: 1.5
                      )
                    ),
                    child: Image.asset(
                      ImagePaths.addCamera,
                      width: x/3.5,
                      height: x/3.5,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),

                // Name Text
                Text(
                  "Name: ",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 2,),
                CustomTextField(
                  controller: nameController,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  inputFillColor: Theme.of(context).colorScheme.primaryContainer,
                  readOnly: !isEditable,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),

                // Email Text
                Text(
                  "Email",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 2,),
                CustomTextField(
                  controller: emailController,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  inputFillColor: Theme.of(context).colorScheme.primaryContainer,
                  readOnly: !isEditable,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),

                // Phone Text
                Text(
                  "Phone No.",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 2,),
                CustomTextField(
                  controller: phoneController,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  inputFillColor: Theme.of(context).colorScheme.primaryContainer,
                  readOnly: !isEditable,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return 'Phone Number is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),

                // Account Text
                Text(
                  "Account Details",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 2,),
                CustomTextField(
                  controller: accountController,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  inputFillColor: Theme.of(context).colorScheme.primaryContainer,
                  readOnly: !isEditable,
                  obscureText: true,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return 'Phone Number is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),

                // Save Button
                const SizedBox(height: 40,),
                isEditable? CustomButton(
                  buttonText: "Save",
                  buttonColor: Theme.of(context).colorScheme.primary,
                  onTap: () {
                    if(formKey.currentState!.validate()) {
                      // Get.to(const HomeScreen());
                      isEditable = !isEditable;
                      setState(() {});
                    }
                  },
                ): const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
