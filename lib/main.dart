import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const LokiBankApp());

class LokiBankApp extends StatelessWidget {
  const LokiBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _numeroContaController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  FormularioTransferencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarLoki(
        appBarTitle: "Criando Transferência",
      ),
      body: Column(
        children: [
          Editor(controlador: _numeroContaController, rotulo: 'Número Conta', dica: '3582'),
          Editor(controlador: _valorController, rotulo: 'Valor', dica: '100', icone: Icons.monetization_on),
          ElevatedButton(
            child: const Text('Confirmar'),
            onPressed: () async => _criaTransferencia(),
          )
        ],
      ),
    );
  }

  void _criaTransferencia() {
    final int? numeroConta =
        int.tryParse(_numeroContaController.text);
    final double? valor = double.tryParse(_valorController.text);
    final transferenciaCriada = Transferencia(valor!, numeroConta!);
    debugPrint('$transferenciaCriada');
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String ?dica;
  final IconData ?icone;

  const Editor({required this.controlador, required this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: const TextStyle(
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
            icon: icone != null ? Icon(icone) : null,
            labelText: rotulo,
            hintText: dica),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarLoki(appBarTitle: "Transferências"),
      body: Column(
        children: [
          ItemTransferencia(Transferencia(100, 3582)),
          ItemTransferencia(Transferencia(200, 3583)),
          ItemTransferencia(Transferencia(300, 3584)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: const Color(0xff198314),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}

class AppBarLoki extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;

  const AppBarLoki({Key? key, required this.appBarTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
            Text(
              appBarTitle,
              style: GoogleFonts.berkshireSwash(),
            )
          ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
