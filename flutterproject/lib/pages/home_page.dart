import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/pages/first_page.dart';
import 'package:flutterproject/pages/second_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  //sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        actions: [
          IconButton(
            onPressed: signUserOut, 
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[400],
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    'L O G O',
                    style: TextStyle(fontSize: 35, color: Colors.grey[100]),
                ))
              ),
              ListTile(
                leading: Icon(Icons.account_circle, color: Colors.grey[100]),
                title: Text(
                  'Page 1',
                  style: TextStyle(fontSize: 20, color: Colors.grey[100]),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FirstPage()));                
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle, color: Colors.grey[100]),
                title: Text(
                  'Page 2',
                  style: TextStyle(fontSize: 20, color: Colors.grey[100]),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SecondPage()));                
                },
              ),
            ],  
          ),
        ),
      ),
      body: Center(
        child: Text(
          "LOGGED IN AS: ${user.email!}",
          style: const TextStyle(fontSize: 20),
      ),),
    );
  }
}