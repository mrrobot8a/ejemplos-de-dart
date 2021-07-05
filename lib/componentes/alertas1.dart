import 'package:flutter/material.dart';

void main() => runApp(Alertas1());

class Alertas1 extends StatefulWidget {
  @override
  _Alertas1State createState() => _Alertas1State();
}

class _Alertas1State extends State<Alertas1> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alert',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: 'Nombres',
                      // suffix: Icon(Icons.access_alarm),
                      suffix: GestureDetector(
                        child: Icon(Icons.close),
                        onTap: () {
                          _controller.clear();
                        },
                      )
                      //probar suffix
                      ),
                  onSubmitted: (String nombres) {
                    cajatexto(context, nombres);
                  }),
            ),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  cajatexto(context, _controller.text);
                  _controller.clear();
                }
              },
              child: Text('Limpiar Datos'),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> cajatexto(BuildContext context, String nombres) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Alerta'),
              content: Text('Mi Nombre es $nombres'),
            ));
  }
}
