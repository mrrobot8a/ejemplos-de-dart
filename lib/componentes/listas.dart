import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/componentes/textoejercicio.dart';
import 'package:flutter_application_1/componentes/modificar.dart';
import 'package:flutter_application_1/componentes/Paciente.dart';

class Listas extends StatefulWidget {
  // variables que resivo de la otra vista
  String nombre;
  Listas(this.nombre);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Listas> {
  List<Cliente> _clientes = [];
  List<Cliente> _clientesfil = [];
  bool isVisible = false;
  @override
  void initState() {
    //asigan los valores viejos a los nuevos lista nueva = a vieja
    _clientesfil = _clientes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido' + '\t' + widget.nombre),
          actions: [
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => setState(() => isVisible = !isVisible))
          ],
        ),
        drawer: MenuLateral(),
        body:
            //aqui se realiza el buscar
            Visibility(
          visible: isVisible,
          child: ListView.builder(
              itemCount: _clientesfil.length + 1,
              itemBuilder: (context, index) {
                return index == 0 ? _searchBar() : _ListItem(index - 1);
              }),
        ),

        //Llamar ventana para adicionar datos

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TextoEjercicio(),
                )).then((resultado) {
              _clientes.addAll(resultado);
              _clientesfil = _clientes;
              setState(() {});
            });
          },
          tooltip: 'Eliminar Cliente',
          child: Icon(Icons.add),
        ));
  }

  _ListItem(index) {
    return ListTile(
      onTap: () {
        print(index);
        Navigator.push(context,
                MaterialPageRoute(builder: (_) => Modificar(_clientes[index])))
            .then((value) {
          if (value != null) {
            setState(() {
              _clientes.removeAt(index);
              _clientes.insert(index, value);
            });
          }
        });
      },
      onLongPress: () {
        setState(() {
          _eliminarcliente(context, _clientes[index]);
        });
      },
      title: Text(
          _clientesfil[index].nombre + ' ' + _clientesfil[index].academico),
      subtitle: Text('Edad=' +
          _clientesfil[index].telefono +
          '\n' +
          'profesion=' +
          _clientesfil[index].correo),
      leading: CircleAvatar(
        backgroundImage: FileImage(_clientesfil[index].foto),
      ),
      /*  trailing: Text(_clientes[index].dia +
                  '-' +
                  _clientes[index].mes +
                  '-' +
                  _clientes[index].ano),*/
    );
  }

  _searchBar() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 8),
        child: TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: 'Buscar cliente',
            suffix: Icon(Icons.search),
          ),
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              _clientesfil = _clientes.where((nombre) {
                var nombreresult = nombre.nombre.toLowerCase();
                return nombreresult.contains(text);
              }).toList();
            });
          },
        ));
  }

  _eliminarcliente(context, Cliente climsg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Eliminar Cliente'),
        content: Text('Esta Seguro de Eliminar a ' + climsg.nombre + '?'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {});
              this._clientes.remove(climsg);
              Navigator.pop(context);
            },
            child: Text(
              'Eliminar',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

class Cliente {
  var nombre;
  var academico;
  var telefono;
  var nacionalidad;
  File foto;
  var correo;

  Cliente({
    this.nombre,
    this.academico,
    this.telefono,
    this.nacionalidad,
    this.foto,
    this.correo,
  });
}

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            arrowColor: Colors.black,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/cruz.jpeg"),
            )),
          ),
          Text(
            "APPTIVAWEB",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.left,
          ),
          Text(
            "informes@gmail.com",
            style: TextStyle(color: Colors.black),
          ),
          Ink(
            color: Colors.indigo,
            child: new ListTile(
              title: Text(
                "MENU 1",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: new ListTile(
              title: Text("Paciente"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Paciente(),
                ));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: new ListTile(
              title: Text("Empleados"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TextoEjercicio(),
                ));
              },
            ),
          ),
          new ListTile(
            title: Text("MENU 3"),
          ),
          new ListTile(
            title: Text("MENU 4"),
          )
        ],
      ),
    );
  }
}

/*
class Adicionar extends StatefulWidget {
  Adicionar({Key key}) : super(key: key);

  @override
  _AdicionarState createState() => _AdicionarState();
}

class _AdicionarState extends State<Adicionar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Cliente'),
      ),
    );
  }
}
*/
