import 'package:flutter/material.dart';
import 'package:flutter_application_1/componentes/listas.dart';
import 'dart:math';
import 'package:flutter_application_1/componentes/textoejercicio.dart';

void main() => runApp(Login());

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List<Cliente> _clientesadd = [];
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController controladornombre;
  TextEditingController controladorapellido;
  TextEditingController controladortelefono;

  @override
  void initState() {
    controladornombre = TextEditingController();
    controladorapellido = TextEditingController();
    controladortelefono = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alert',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ejercicio'),
        ),
        body: new Form(
          key: keyForm,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://www.wallpapertip.com/wmimgs/39-394898_best-hd-backgrounds-for-editing.jpg'),
                    fit: BoxFit.cover)),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: _buildCircleAvatar(),
                ),
                Text('Iniciar seccion',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold)),
                formItemsDesign(
                    Icons.person,
                    TextFormField(
                      controller: controladornombre,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          hintText: 'user',
                          fillColor: Colors.transparent,
                          filled: true,
                          suffix: GestureDetector(
                            child: Icon(Icons.close),
                            onTap: () {
                              controladornombre.clear();
                            },
                          )),
                      validator: validateName,
                    )),
                formItemsDesign(
                    Icons.lock,
                    TextFormField(
                      controller: controladorapellido,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Password',
                          fillColor: Colors.grey,
                          suffix: GestureDetector(
                            child: Icon(Icons.close),
                          )),
                      validator: validateName,
                    )),
                FlatButton(
                  color: Colors.red[400],
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 3),
                  onPressed: () {
                    String nombre = controladornombre.text;
                    if (controladorapellido.text.isEmpty) {
                      save();
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Listas(nombre),
                          ));
                      setState(() {});
                    }
                    ;
                  },
                  child: Text('Entrar',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 2),
      child: Column(
        children: [
          Card(
              color: Colors.white70,
              child: ListTile(leading: Icon(icon), title: item)),
        ],
      ),
    );
  }

  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El nombre es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "El nombre debe de ser a-z y A-Z";
    }
    return null;
  }

  save() {
    if (keyForm.currentState.validate()) {
      print("Nombre ${controladornombre.text}");
      print("Telefono ${controladorapellido.text}");

      keyForm.currentState.reset();
      return 1;
    }
  }

  Widget _buildCircleAvatar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final radius = min(constraints.maxHeight / 4, constraints.maxWidth / 4);
        return Center(
          child: CircleAvatar(
            radius: radius,
            backgroundImage: NetworkImage(
              "https://previews.123rf.com/images/tanyastock/tanyastock1803/tanyastock180300490/97923644-signo-de-inicio-de-sesi%C3%B3n-de-avatar-de-icono-de-usuario-bot%C3%B3n-de-c%C3%ADrculo-con-vector-de-fondo-degradado-de-co.jpg",
            ),
          ),
        );
      },
    );
  }
}
