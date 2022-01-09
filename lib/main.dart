import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const LokiBankApp());

class LokiBankApp extends StatelessWidget {
  const LokiBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber[700]),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.amber[700],
          textTheme: ButtonTextTheme.primary,
        )

      ),
      home: ListaTransferencias(),
    );
  }
}

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _numeroContaController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarLoki(
        appBarTitle: "Criando Transferência",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
                controlador: _numeroContaController,
                rotulo: 'Número Conta',
                dica: '3582'),
            Editor(
                controlador: _valorController,
                rotulo: 'Valor',
                dica: '100',
                icone: Icons.monetization_on),
            ElevatedButton(
              child: const Text('Confirmar'),
              onPressed: () async => _criaTransferencia(context),
            )
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_numeroContaController.text);
    final double? valor = double.tryParse(_valorController.text);
    final transferenciaCriada = Transferencia(valor!, numeroConta!);
    debugPrint('Criando Transferencia');
    debugPrint('$transferenciaCriada');
    Navigator.pop(context, transferenciaCriada);
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String? dica;
  final IconData? icone;

  const Editor(
      {required this.controlador, required this.rotulo, this.dica, this.icone});

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

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarLoki(appBarTitle: "Transferências"),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: Theme(
        data:Theme.of(context).copyWith(splashColor: Colors.amber[700]),
        child: FloatingActionButton(
          onPressed: () {
            final Future<Transferencia?> future = Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return FormularioTransferencia();
              }),
            );
            future.then((transferenciaRecebida) {
              Future.delayed(Duration(seconds: 1), () {
                debugPrint('chegou no then do future');
                debugPrint('$transferenciaRecebida');
                setState(() {
                  widget._transferencias.add(transferenciaRecebida!);
                });

              });
            });
          },
          child: Icon(Icons.add),
          backgroundColor: const Color(0xff198314),
        ),
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
