import 'package:flutter/material.dart';
import 'package:lokibank/components/app_bar_loki.dart';
import 'package:lokibank/components/editor.dart';
import 'package:lokibank/models/transferencia.dart';

const _tituloAppBar = 'Criando Transferência';
const _rotuloValor = 'Valor';
const _dicaValor = '0.00';
const _rotuloNumeroConta = 'Número da Conta';
const _dicaNumeroConta = '3582';
const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatefulWidget {
  const FormularioTransferencia({Key? key}) : super(key: key);

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
        appBarTitle: _tituloAppBar,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
                controlador: _numeroContaController,
                rotulo: _rotuloNumeroConta,
                dica: _dicaNumeroConta),
            Editor(
                controlador: _valorController,
                rotulo: _rotuloValor,
                dica: _dicaValor,
                icone: Icons.monetization_on),
            ElevatedButton(
              child: const Text(_textoBotaoConfirmar),
              onPressed: () async => _criaTransferencia(context),
            ),
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_numeroContaController.text);
    final double? valor = double.tryParse(_valorController.text);
    final transferenciaCriada = Transferencia(valor!, numeroConta!);
    Navigator.pop(context, transferenciaCriada);
  }
}