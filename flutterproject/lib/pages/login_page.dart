import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterproject/components/my_button.dart';
import 'package:flutterproject/components/my_textfield.dart';
import 'package:flutterproject/components/square_tile.dart';
import 'package:flutterproject/services/auth_service.dart';
import 'forgot_password_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers 
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {
    //show loading circle
    showDialog(
      context: context, 
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );

    //try sign in
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text,
      );
      
      //pop the loading circle
      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
      
    }
  }

  //error message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.redAccent,
          title: Center (
            child: Text (
              message,
              style: const TextStyle(color: Colors.white)
            ),
          ),
        );
      },
    );
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  const SizedBox(height: 20,),
                  //logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  const SizedBox(height: 20),

                  //welcome back, you've been missed!
                  Text(
                    'Welcome back you\'ve been missed!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),

                  //email TextField
                  MyTextField(
                    controller: emailController,
                    hintText: 'email', 
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  //password TextField
                  MyTextField(
                    controller: passwordController, 
                    hintText: 'password', 
                    obscureText: true,
                  ),

                  //forgot password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ForgotPasswordPage();
                                }, 
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  //sign in button
                  MyButton(
                    onTap: signUserIn, 
                    text: 'Sign in',
                  ),

                  const SizedBox(height: 30),

                  //or coninue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey[700]),
                            
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ]
                    )
                  ),
                  
                  const SizedBox(height: 20),
                  //google + apple sign in button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ 
                      //Google buton
                      SquareTile(
                        onTap: () => AuthService().signInWithGoogle(),  
                        imagePath: 'https://static-00.iconduck.com/assets.00/google-logo-icon-503x512-d3y72ufg.png'
                      ),
                        
                      SizedBox(width: 10),
                      //Apple button
                      SquareTile(
                        onTap: (){},
                        imagePath: 'https://cdn.icon-icons.com/icons2/3398/PNG/512/apple_logo_icon_214672.png'),
                    ],
                  ),

                  const SizedBox(height: 20),

                  //not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a member?'),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register now',
                            style: TextStyle(
                            color: Colors.blue, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      
                      
                    ],
                  )
                ],
             ),
          ),
        ),
      ),
    );
  }
}

