import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(const MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados';

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados';
    });
  }

  void calculated() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = (weight / (height * height));

      if (imc < 18.6) {
        _infoText = 'Abaixo do peso (${imc.toStringAsPrecision(3)})';
      }

      if (imc > 18.6 && imc < 24.9) {
        _infoText = 'O seu peso é normal (${imc.toStringAsPrecision(3)})';
      }

      if (imc > 25 && imc < 29.9) {
        _infoText = 'Peso moderado (${imc.toStringAsPrecision(3)})';
      }

      if (imc > 30 && imc < 34.9) {
        _infoText = 'Peso Alto (${imc.toStringAsPrecision(3)})';
      }

      if (imc > 35 && imc < 39.9) {
        _infoText = 'Peso Muito Alto (${imc.toStringAsPrecision(3)})';
      }

      if (imc > 40) {
        _infoText = 'Peso Extramente Alto (${imc.toStringAsPrecision(3)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('calculadora IMC'),
        centerTitle: true,
        backgroundColor: Colors.green[400],
        actions: [
          IconButton(onPressed: _resetFields, icon: const Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.person_outline,
                  size: 120.0, color: Color(0xff66bb6a)),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Peso (kg)'),
                  labelStyle: TextStyle(color: Colors.black, fontSize: 25),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Insira seu peso";
                  }
                },
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Altura (cm)'),
                    labelStyle: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 25.0),
                  controller: heightController,
                  validator: (value){
                    if(value == null || value.isEmpty) {
                      return "Insira a sua altura";
                    }
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Container(
                  padding: const EdgeInsets.only(top: 20.0),
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: (){
                     if( _formKey.currentState!.validate() ){
                        calculated;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: const RoundedRectangleBorder()),
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 23.0),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
