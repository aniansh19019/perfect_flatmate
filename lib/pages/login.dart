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
      Auth.login(emailController.text, passwordController.text, false, context);
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
      appBar: AppBar(
        title: Center(child: Text("Perfect Flatmates")),
      ),
  
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  Spacer(flex: 2),
                  // Text("We Event Check In Admin"),
                  Expanded(
                    flex: 6,
                    child: Image.asset("assets/logo.png",
                        scale: 1
                      ),
                  ),
                 
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
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white)
                            ),
                            onPressed: ()
                            {
                              onSignUpFormSubmit("");
                            }, 
                            child: Text("Sign Up", 
                            style: TextStyle(
                              color: Palette.kToDark
                              ),
                            )
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
                      ),
                      SizedBox(height: 16,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: TextButton(
                          
                          onPressed: ()
                        {
                          Auth.signInWithGoogle();
                        }, child: Material(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
                          elevation: 4,
                          child: Image.asset('assets/google.png',
                          scale: 0.4,),
                        )),
                      )
                    ]),
                  ),
                  
                  Spacer(flex: 4,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}