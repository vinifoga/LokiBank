import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Column(
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('100.00'),
              subtitle: Text('3582'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('200.00'),
              subtitle: Text('3582'),
            ),
          ),
        ],
      ),
      appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 88,
          backgroundColor: const Color(0xff198314),
          title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "images/logo.png",
                  fit: BoxFit.contain,
                  height: 52,
                ),
                Text("Transferências", style: GoogleFonts.berkshireSwash(),)
              ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: const Color(0xff198314),
      ),
    ),
  ));
}
