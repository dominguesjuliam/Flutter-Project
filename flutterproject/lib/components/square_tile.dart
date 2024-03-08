import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {

  final String imagePath;
  const SquareTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context){
    return Container(
      
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color:Colors.white),
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200]
      ),
      child: Image.network(
        imagePath,
        height: 40,
      ),
    );
  }

}