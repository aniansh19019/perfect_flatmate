import 'package:flutter/material.dart';
import 'package:perfect_flatmate/util/route_args.dart';
import 'package:perfect_flatmate/util/theme.dart';
import 'package:perfect_flatmate/widgets/forms.dart';

import '../services/auth.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> 
{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  void onLoginFormSubmit(value)
  {
    if (_formKey.currentState!.validate()) 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logging In...')),
      );
      debugPrint("Login Pressed!");
      Auth.login(emailController.text, passwordController.text, context);
    }
  }

  void onSignUpFormSubmit(value)
  {
    if (_formKey.currentState!.validate()) 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signing Up...')),
      );
      debugPrint("SignUp Pressed!");
      Auth.signUp(emailController.text, passwordController.text, context);
    }
  }


  @override
  Widget build(BuildContext context) 
  {
    final args = ModalRoute.of(context)!.settings.arguments as LoginArgs;
    String loginErrorMessage = "";
    if(!args.doesEmailExist)
    {
      loginErrorMessage = "This account does not exist!";
    }
    else if(!args.isPasswordCorrect)
    {
      loginErrorMessage = "Incorrect Password!";
    }


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
                    EasyFormField(label: "Email", textEditingController: emailController, 
                    validator: CustomValidators.emailValidator, onSubmit: onLoginFormSubmit,
                    ),
                    SizedBox(height: 16,),
                    EasyFormField(label: "Password", textEditingController: passwordController, obscureText: true,
                    onSubmit: onLoginFormSubmit,
                    ),
                    Text(loginErrorMessage, style: CustomTheme.error,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: ()
                          {
                            onSignUpFormSubmit("");
                          }, 
                          child: Text("Sign Up")
                          ),
                          SizedBox(width: 20,),
                          
                        ElevatedButton(
                          onPressed: ()
                          {
                            onLoginFormSubmit("");
                          }, 
                          child: Text("Sign In")
                          ),
                      ],
                    )
                  ]),
                ),
                
                Spacer(flex: 4,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}