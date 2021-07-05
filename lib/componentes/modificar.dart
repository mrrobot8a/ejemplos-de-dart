import 'package:flutter/material.dart';
import 'package:flutter_application_1/componentes/listas.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path_provider/path_provider.dart';

class Modificar extends StatefulWidget {
  final Cliente cliente;
  Modificar(this.cliente, {Key key}) : super(key: key);

  @override
  _ModificarState createState() => _ModificarState();
}

class _ModificarState extends State<Modificar> {
  String name, academico, telefono, foto, nacionalidad, correo;

  TextEditingController controladornombre;
  TextEditingController controladoracademico;
  TextEditingController controladortelefono;
  TextEditingController controladornacionalidad;
  TextEditingController controladorcorreo;
  TextEditingController controladorfoto;
  GlobalKey<FormState> keyForm = new GlobalKey();
  File imageFile;
  var edadvieja;
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
    Cliente c = widget.cliente;

    controladornombre = TextEditingController(text: c.nombre);
    controladoracademico = TextEditingController(text: c.nombre);
    controladortelefono = TextEditingController(text: c.nombre);
    controladornacionalidad = TextEditingController(text: c.nombre);
    controladorcorreo = TextEditingController(text: c.nombre);
    imageFile = c.foto;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Modificar Contacto'),
        ),
        body: new Form(
          key: keyForm,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 3.5 + 20,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.asset(
                            'assets/re.jpg',
                            fit: BoxFit.fill,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.white70.withOpacity(0.1),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 20,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    //
                    Positioned(
                      top: MediaQuery.of(context).size.height / 3 - 30,
                      left: MediaQuery.of(context).size.width / 3 - 150,
                      right: MediaQuery.of(context).size.height / 6 - 150,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50)),
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
                              TextFormField(
                                controller: controladornombre,

                                keyboardType: TextInputType.name,
                                style: TextStyle(
                                    fontWeight: FontWeight
                                        .bold), // Probar todos los teclados
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0)),
                                    fillColor: Colors.white70,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    labelText: 'Nombre completo',
                                    // suffix: Icon(Icons.access_alarm),
                                    suffix: GestureDetector(
                                      child: Icon(Icons.close),
                                      onTap: () {
                                        controladornombre.clear();
                                      },
                                    )
                                    //probar suffix
                                    ),

                                /// validator: validateName,
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: controladoracademico,

                                keyboardType: TextInputType.name,
                                style: TextStyle(
                                    fontWeight: FontWeight
                                        .bold), // Probar todos los teclados
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0)),
                                    fillColor: Colors.white70,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.book,
                                      color: Colors.black,
                                    ),
                                    labelText: 'Estudio academico',
                                    // suffix: Icon(Icons.access_alarm),
                                    suffix: GestureDetector(
                                      child: Icon(Icons.close),
                                      onTap: () {
                                        //   controladorano.clear();
                                      },
                                    )
                                    //probar suffix
                                    ),

                                /// validator: validateName,
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: controladortelefono,

                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontWeight: FontWeight
                                        .bold), // Probar todos los teclados
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0)),
                                    fillColor: Colors.white70,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.call,
                                      color: Colors.black,
                                    ),
                                    labelText: 'Telefono',
                                    // suffix: Icon(Icons.access_alarm),
                                    suffix: GestureDetector(
                                      child: Icon(Icons.close),
                                      onTap: () {
                                        //   controladorano.clear();
                                      },
                                    )
                                    //probar suffix
                                    ),

                                /// validator: validateName,
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: controladornacionalidad,

                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    fontWeight: FontWeight
                                        .bold), // Probar todos los teclados
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0)),
                                    fillColor: Colors.white70,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.work,
                                      color: Colors.black,
                                    ),
                                    labelText: 'Nacionalidad',
                                    // suffix: Icon(Icons.access_alarm),
                                    suffix: GestureDetector(
                                      child: Icon(Icons.close),
                                      onTap: () {
                                        //   controladorano.clear();
                                      },
                                    )
                                    //probar suffix
                                    ),

                                /// validator: validateName,
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: controladorcorreo,

                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontWeight: FontWeight
                                        .bold), // Probar todos los teclados
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0)),
                                    fillColor: Colors.white70,
                                    filled: true,
                                    labelText: 'Gmail',
                                    prefixIcon: Icon(
                                      Icons.alternate_email,
                                      color: Colors.black,
                                    ),
                                    // suffix: Icon(Icons.access_alarm),
                                    suffix: GestureDetector(
                                      child: Icon(Icons.close),
                                      onTap: () {
                                        //   controladorano.clear();
                                      },
                                    )
                                    //probar suffix
                                    ),

                                /// validator: validateName,
                                textAlign: TextAlign.left,
                              ),
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
                                        name = controladornombre.text;
                                        academico = controladoracademico.text;
                                        telefono = controladortelefono.text;

                                        nacionalidad =
                                            controladornacionalidad.text;
                                        correo = controladorcorreo.text;

                                        if (name.isNotEmpty) {
                                          Navigator.pop(
                                              context,
                                              Cliente(
                                                nombre: name,
                                                academico: academico,
                                                telefono: telefono,
                                                nacionalidad: nacionalidad,
                                                correo: correo,
                                                foto: imageFile,
                                              ));
                                        }
                                        ;
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.black,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 3 - 120,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
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
                                        border: Border.all(color: Colors.black),
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
                      right: 265,
                      top: MediaQuery.of(context).size.height / 2 - 135,
                      child: MaterialButton(
                          onPressed: () {
                            _showChoiceDialog(context);
                          },
                          padding: EdgeInsets.all(10),
                          shape: CircleBorder(),
                          color: Colors.white,
                          child: Icon(OMIcons.photoCamera)),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //
        ),
      ),
    );
  }

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
      return Image.asset('assets/re.jpg');
    } else {
      print(imageFile);
      return Image.file(imageFile, width: 400, height: 400);
    }
  }

  save() {
    if (keyForm.currentState.validate()) {
      print("Nombre ${controladornombre.text}");

      keyForm.currentState.reset();
      return 1;
    }
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
}

class TextBox extends StatelessWidget {
  final label;
  const TextBox({
    this.label,
    Key key,
    @required this.controlador,
  }) : super(key: key);

  final TextEditingController controlador;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: TextField(
          controller: controlador,
          decoration: InputDecoration(
              filled: true,
              labelText: this.label,
              // suffix: Icon(Icons.access_alarm),
              suffix: GestureDetector(
                child: Icon(Icons.close),
                onTap: () {
                  controlador.clear();
                },
              )
              //probar suffix
              ),
          onSubmitted: (String nombres) {
            // cajatexto(context, nombres);
          }),
    );
  }
}
