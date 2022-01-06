import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home:Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          "images/logo.png",
          fit: BoxFit.contain,
          height: 72,
        ),
        toolbarHeight: 88,
        backgroundColor: const Color(0xff198314),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: Icon(Icons.add),
        backgroundColor: const Color(0xff198314),
    ),
      ),

    )
  );
}
