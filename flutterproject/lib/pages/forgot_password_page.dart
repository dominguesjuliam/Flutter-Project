import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/components/my_button.dart';
import 'package:flutterproject/components/my_textfield.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key,});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  
  final emailController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text.trim());
        showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.greenAccent,
            title: Center (
              child: Text (
                "Password reset link sent! Check your email",
                style: 
                TextStyle(color: Colors.white)
              ),
            ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
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
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey.shade300),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    //welcome back, you've been missed!
                    child: 
                      Text(
                        'Enter your email and we will send you a password reset link!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
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

                  //sign in button
                  MyButton(
                    onTap: passwordReset, 
                    text: 'Reset Password!',
                  ),

                  const SizedBox(height: 30),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
