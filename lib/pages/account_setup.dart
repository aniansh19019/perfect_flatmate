import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:perfect_flatmate/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:perfect_flatmate/util/route_args.dart';
import 'package:perfect_flatmate/util/theme.dart';
import 'package:image_picker/image_picker.dart';
import '../services/auth.dart';
//import 'package:firebase_picture_uploader/firebase_picture_uploader.dart';
class AccountSetup extends StatefulWidget {
  const AccountSetup({super.key});

  @override
  State<AccountSetup> createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void onSetupFormSubmit(value) async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signing Up...')),
      );
      debugPrint("SignUp Pressed!");
      Auth.signUp(emailController.text, passwordController.text, context);
    }
  }
  void _selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    /*setState(() {
      _imageFile = File(pickedFile.path);
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 4),
                // Text("We Event Check In Admin"),

                // Spacer(),
                Spacer(),
                Form(
                  key: _formKey,
                  child: Column(children: [
                    EasyFormField(
                      label: "Name",
                      textEditingController: nameController,
                      onSubmit: onSetupFormSubmit,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    EasyFormField(
                      label: "Email",
                      textEditingController: emailController,
                      validator: CustomValidators.emailValidator,
                      onSubmit: onSetupFormSubmit,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    EasyFormField(
                      label: "Password",
                      textEditingController: passwordController,
                      obscureText: true,
                      onSubmit: onSetupFormSubmit,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    EasyFormField(
                      label: "Phone Number",
                      textEditingController: phonenumberController,
                      onSubmit: onSetupFormSubmit,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    EasyFormField(
                      label: "Age",
                      textEditingController: ageController,
                      onSubmit: onSetupFormSubmit,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _selectImage,
                        child: Text('Upload Image'),
                      ),
                    ),
                    Text(
                      // loginErrorMessage,
                      "",
                      style: CustomTheme.error,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              onSetupFormSubmit("");
                            },
                            child: Text("Continue")),
                      ],
                    )
                  ]),
                ),

                Spacer(
                  flex: 4,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
