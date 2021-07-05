import 'package:flutter/material.dart';

void main() => runApp(Alertas());

class Alertas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alert',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Nombres',
              ),
              onSubmitted: (String nombres) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Alerta'),
                          content: Text('Mi Nombre es $nombres'),
                        ));
              }),
        ),
      ),
    );
  }
}
