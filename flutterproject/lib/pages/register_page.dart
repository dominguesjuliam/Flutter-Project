import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterproject/components/my_button.dart';
import 'package:flutterproject/components/my_textfield.dart';
import 'package:flutterproject/components/square_tile.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers 
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign user up method
  void signUserUp() async {
    //show loading circle
    showDialog(
      context: context, 
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );

    //try creating the user
    try{
      //check if password is confirmed
      if (passwordController.text == confirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text,
        );
      } else {
        //pop the loading circle
        Navigator.pop(context);
        //show error message
        showErrorMessage("Passwords don't match!");
      }
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
                  const SizedBox(height: 25,),
                  //logo
                  const Icon(
                    Icons.lock,
                    size: 50,
                  ),
                  const SizedBox(height: 25),

                  //Let's create an account for you!
                  Text(
                    'Let\'s create an account for you!',
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

                  const SizedBox(height: 10),

                  //confirm password TextField
                  MyTextField(
                    controller: confirmPasswordController, 
                    hintText: 'confirm password', 
                    obscureText: true,
                  ),


                  const SizedBox(height: 25),

                  //sign in button
                  MyButton(
                    onTap:  signUserUp, 
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ 
                      //Google buton
                      SquareTile(imagePath: 'https://static-00.iconduck.com/assets.00/google-logo-icon-503x512-d3y72ufg.png'),
                        
                      SizedBox(width: 10),
                      //Apple button
                      SquareTile(imagePath: 'https://cdn.icon-icons.com/icons2/3398/PNG/512/apple_logo_icon_214672.png'),
                    ],
                  ),

                  const SizedBox(height: 20),

                  //not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login now',
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

