import 'package:flutter/material.dart';
import 'package:lokibank/components/app_bar_loki.dart';
import 'package:lokibank/models/transferencia.dart';
import 'package:lokibank/screens/transferencia/formulario.dart';

const _tituloAppBar = 'Transferências';

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  ListaTransferencias({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarLoki(appBarTitle: _tituloAppBar),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const FormularioTransferencia();
              }),
            ).then((transferenciaRecebida) {
                setState(() {
                  widget._transferencias.add(transferenciaRecebida!);
                });
            });
          },
          child: const Icon(Icons.add),
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
