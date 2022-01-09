import 'package:flutter/material.dart';
import 'package:lokibank/screens/transferencia/lista.dart';

void main() => runApp(const LokiBankApp());

class LokiBankApp extends StatelessWidget {
  const LokiBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.amber[700]),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.amber[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: ListaTransferencias(),
    );
  }
}
