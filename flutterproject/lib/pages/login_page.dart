import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterproject/components/my_button.dart';
import 'package:flutterproject/components/my_textfield.dart';
import 'package:flutterproject/components/square_tile.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
      
      //wrong email
      if(e.code == 'invalid-email') {
        wrongEmailMessage();
      } 

      //wrong password
      else if (e.code == 'invalid-credential') {
        wrongPasswordMessage();
      }
    }
  }

  //wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop(true);
        });
        return const AlertDialog(
          title: Text('Incorrect Email!'),
        );
      },
    );
  }

  //wrong password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop(true);
        });
        return const AlertDialog(
          title: Text('Incorrect Password!'),
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
                  Icon(
                    Icons.lock,
                    size: 100,
                    color: Colors.grey[700],
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
                        Text(
                          'Forgot Password',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  //sign in button
                  MyButton(
                    onTap: signUserIn,
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not a member?'),
                      SizedBox(width: 4,),
                      Text('Register now',
                      style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold
                      ),),
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

