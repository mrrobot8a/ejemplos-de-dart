import 'package:flutter_application_1/componentes/alertas.dart';
import 'package:flutter_application_1/componentes/alertas1.dart';
import 'package:flutter_application_1/componentes/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/componentes/listas.dart';

void main() => runApp(Inicial());

class Inicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //Se india que este tema tiene un brillo luminoso

        primaryColor: Colors.blue,
      ),
      routes: {
        '/alertas': (context) => Alertas(),
        '/alertas1': (context) => Alertas1(),
        '/listas': (context) => Listas(null),
        '/login': (context) => Login(),
      },
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rutas Nombradas'),
        ),
        body: Center(
          child: Column(
            children: [
              Botones(titulo: 'Textos y Alertas', ruta: '/alertas'),
              SizedBox(height: 5),
              Botones(titulo: 'Text Controller', ruta: '/alertas1'),
              SizedBox(height: 5),
              Botones(titulo: 'Ejercicio Text', ruta: '/ejercicio'),
              SizedBox(height: 5),
              Botones(titulo: 'listas', ruta: '/listas'),
              SizedBox(height: 5),
              Botones(titulo: 'LOGIN', ruta: '/login'),
            ],
          ),
        ),
      ),
    );
  }
}

class Botones extends StatelessWidget {
  final titulo;
  final ruta;

  const Botones({Key key, this.titulo, this.ruta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, this.ruta);
        },
        child: Text(
          this.titulo,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
