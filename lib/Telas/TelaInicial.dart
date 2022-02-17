import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TelaIncial extends StatefulWidget {
  @override
  _TelaIncialState createState() => _TelaIncialState();
}

class _TelaIncialState extends State<TelaIncial> {
  TextEditingController _pesoController = new TextEditingController();
  TextEditingController _alturaController = new TextEditingController();
  String _result = '';
  var _imagem;
  
  calcIMC(String peso, String altura){
    var _pesoParse = double.tryParse(peso);
    var _alturaParse = double.tryParse(altura);
    if(_pesoParse != null  && _alturaParse != null){
      _alturaParse = _alturaParse/100;
      double _imc = (_pesoParse/(_alturaParse * _alturaParse));

      setState(() {
        _result = _imc.toString();
      });
      this.showImage();
    }
    else {
      setState(() {
        _result = "Digite os campos obrigatórios";
      });
    }

  }

  showImage(){
    var imcImage = double.tryParse(_result);
    if(imcImage < 18.5){
      setState(() {
        _imagem = "images/abaixo-peso.jpg";
      });
    }
    if(imcImage >= 18.5 && imcImage >= 24.9){
      setState(() {
        _imagem = "images/normal-peso.jpg";
      });
    }
    if(imcImage >= 18.5 && imcImage <= 24.9){
      setState(() {
        _imagem = "images/normal-peso.jpg";
      });
    }
    if(imcImage >= 25 && imcImage <= 29.9){
      setState(() {
        _imagem = "images/sobre-peso.jpg";
      });
    }
    if(imcImage >= 30 && imcImage <= 34.9){
      setState(() {
        _imagem = "images/obesidade-grau-1.png";
      });
    }
    if(imcImage >= 35 && imcImage <= 39.9){
      setState(() {
        _imagem = "images/obesidade-grau-2.jpeg";
      });
    }
    if(imcImage >= 40){
      setState(() {
        _imagem = "images/obesidade-grau-3.jpeg";
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("IMC"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            createInputs("Peso: (kg)", _pesoController),
            createInputs("Altura: (kg)", _alturaController),
            Container(
              // padding: EdgeInsets.only(top: 25.0),
              margin: EdgeInsets.only(top: 25.0),
              height: 50.0, width: 200.00,
              child: RaisedButton(
                child: Text('Calcular'),
                onPressed: () => calcIMC(_pesoController.text, _alturaController.text)
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 28.0),
              height: 100.0, width: 200.00,
              child: Text(_result != null ? _result : '',
                style: TextStyle(fontSize: 20.0),),
            ),
            Container(
              height: 260.0, width: 300.00,
              child: _imagem != null ? Image.asset(_imagem) : null
            )
          ],
        ),
      )
    );
  }

  Padding createInputs(String text, TextEditingController controllerField){
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
      child: TextField(
        decoration: InputDecoration(
          labelText: text
        ),
        keyboardType: TextInputType.number,
        controller: controllerField,
      ),
    );
  }
}
