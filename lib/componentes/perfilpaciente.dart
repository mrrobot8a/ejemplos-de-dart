import 'package:flutter/material.dart';
import 'package:flutter_application_1/componentes/listas.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';

class Paciente extends StatefulWidget {
  @override
  _PacienteState createState() => _PacienteState();
}

class _PacienteState extends State<Paciente> {
  List<Cliente> _clientesadd = [];
  List<String> _lista = ["+65", "+91"];
  List<String> _listaEstadoPaciente = ["activo", "Inactvo"];
  String _vista = 'seleccionar una opcion';
  String _Estadoservicio = 'Selecionar una opcion ';
  List<String> _colors = ['', 'red', 'green', 'blue', 'orange'];

  String _selectedCountryCode;
  String _color = '';

  TextEditingController controladornombre;
  TextEditingController controladorApellido;
  TextEditingController controladorDireccion;
  TextEditingController controladorBarrio;
  TextEditingController controladorTelefono;
  TextEditingController controladorCiudad;

  DateTime dateInput;
  GlobalKey<FormState> keyForm = new GlobalKey();
  var hola;
  var fechabuena = '';
  File imageFile;

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _fileFromImageUrl();
    controladornombre = TextEditingController();
    controladorApellido = TextEditingController();
    controladorDireccion = TextEditingController();
    controladorBarrio = TextEditingController();
    controladorTelefono = TextEditingController();
    controladorCiudad = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alert',
      home: Scaffold(
        endDrawer: MenuLateral(),
        body: new Form(
          key: keyForm,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    //flecha hacia atras
                    Positioned(
                      top: 50,
                      left: 20,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    //aqui esta el cuadro del formulario
                    Positioned(
                      top: MediaQuery.of(context).size.height / 7 - 30,
                      left: MediaQuery.of(context).size.width / 3 - 150,
                      right: MediaQuery.of(context).size.height / 6 - 150,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1,
                        height: MediaQuery.of(context).size.height / 1.3,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(
                                50,
                              )),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 60,
                              ),

                              /// validator: validateName,

                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 120, vertical: 2),
                                  child: ConstrainedBox(
                                      constraints: BoxConstraints.tightFor(
                                          width: 200, height: 40),
                                      child: ElevatedButton(
                                          child: Text('Enviar   Datos'),
                                          onPressed: () {
                                            if (controladornombre
                                                .text.isNotEmpty) {
                                              _clientesadd.add(new Cliente(
                                                nombre: controladornombre.text,
                                                /* academico:
                                                    controladorUsuario.text,
                                                telefono:
                                                    controladorContrasena.text,
                                                nacionalidad:
                                                    controladorEstado.text,
                                                correo:
                                                    controladorEstadoServicio
                                                        .text,*/
                                                foto: imageFile,
                                              ));
                                              Navigator.pop(
                                                  context, _clientesadd);
                                            } else {
                                              save();
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blue,
                                          )))),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //card de foto
                    Positioned(
                      top: MediaQuery.of(context).size.height / 8 - 120,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width:
                                  MediaQuery.of(context).size.width / 2.5 - 20,
                              height:
                                  MediaQuery.of(context).size.height / 5.5 + 20,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                                  Positioned(
                                    top: 50,

                                    left: (MediaQuery.of(context).size.width /
                                            7) -
                                        55,
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border:
                                            Border.all(color: Colors.lightBlue),
                                      ),
                                      //color: Colors.blue,
                                      child: Card(
                                        elevation: 2,
                                        child: _decideImageView(),
                                      ),
                                    ),

                                    //height: 190,
                                    //left: -10,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Registrar',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Welcome to barber favorite',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 325,
                      top: MediaQuery.of(context).size.height / 3.4 - 160,
                      child: MaterialButton(
                          onPressed: () {
                            _showChoiceDialog(context);
                          },
                          padding: EdgeInsets.all(10),
                          shape: CircleBorder(),
                          color: Colors.white,
                          child: Icon(OMIcons.photoCamera)),

                      //icono camara
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El nombre es necesario no ecribio nada ";
    } else if (!regExp.hasMatch(value)) {
      return "El nombre debe de ser a-z y A-Z";
    }
    return null;
  }

  /*
  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
      child: Column(
        children: [
          Card(
              color: Colors.white70,
              child: ListTile(leading: Icon(icon), title: item)),
        ],
      ),
    );
  }
*/
  int holaa(var uno, var dos) {
    return dos - uno;
  }

  Future<dynamic> cajatexto(BuildContext context, String nombres) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Alerta'),
              content: Text('Mi Nombre es $nombres'),
            ));
  }

  Future<File> _fileFromImageUrl() async {
    final response = await http.get(
        'https://lh5.googleusercontent.com/proxy/9vqIPeIeHQHyGEo43DlSgD-DUtidieclv56O6UoAcYNGPXGNnZwFJL2V7oSodehCB1YT28jit7pMSVjNTnrBOnlBxW0CiRmOeH22FlPockzEbfdQPHLkDMPcgMwWdNfVHF1r2QpUk6W_aY_J87A9lFtYKMHf8_xhkMB7l_4=s0-d');

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(join(documentDirectory.path, 'imagetest.png'));

    file.writeAsBytesSync(response.bodyBytes);

    imageFile = file;

    return file;
  }

//funcion para abrir panel de camara
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Seleccione"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Galeria"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text("Camara"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  //retorna  texto si no se ha seleccionado alguna imagen
  Widget _decideImageView() {
    if (imageFile == null) {
      return Image.network(
          'https://lh5.googleusercontent.com/proxy/9vqIPeIeHQHyGEo43DlSgD-DUtidieclv56O6UoAcYNGPXGNnZwFJL2V7oSodehCB1YT28jit7pMSVjNTnrBOnlBxW0CiRmOeH22FlPockzEbfdQPHLkDMPcgMwWdNfVHF1r2QpUk6W_aY_J87A9lFtYKMHf8_xhkMB7l_4=s0-d');
    } else {
      print(imageFile);
      return Image.file(imageFile, width: 400, height: 400);
    }
  }

// funcion de validar
  save() {
    if (keyForm.currentState.validate()) {
      print("Nombre ${controladornombre.text}");

      keyForm.currentState.reset();
      return 1;
    }
  }

// caja de fecha date time
  void _dataPresent() {
    showDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {});

        dateInput = value;
      }
    });
  }
}
