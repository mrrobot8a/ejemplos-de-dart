import 'package:flutter/material.dart';
import 'package:flutter_application_1/componentes/listas.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:flutter_application_1/componentes/Paciente.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:convert';

void main() => runApp(TextoEjercicio());

class TextoEjercicio extends StatefulWidget {
  @override
  _TextoEjercicioState createState() => _TextoEjercicioState();
}

class _TextoEjercicioState extends State<TextoEjercicio> {
  static final String uploadEndPoint =
      'http://localhost/flutter_test/upload_image.php';
  String errMessage = 'Error Uploading Image';
  List<Cliente> _clientesadd = [];
  List<String> _lista = ["+65", "+91"];
  List<String> _listaEstadoServicio = ["activo", "Inactvo"];
  String _vista = 'seleccionar una opcion';
  String _Estadoservicio = 'Selecionar una opcion ';
  List<String> _colors = ['', 'red', 'green', 'blue', 'orange'];

  String _selectedCountryCode;
  String _color = '';

  TextEditingController controladornombre;
  TextEditingController controladorcorreo;
  TextEditingController controladorContrasena;
  TextEditingController controladorEstado;
  TextEditingController controladorEstadoServicio;
  TextEditingController controladorUsuario;

  DateTime dateInput;
  GlobalKey<FormState> keyForm = new GlobalKey();
  var hola;
  var fechabuena = '';
  Future<File> imageFile;
  String base64Image;
  File tmpFile;
  Future<File> picture;
  _openGallery(BuildContext context) async {
    picture = ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
      print(imageFile);
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    picture = ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _fileFromImageUrl();
    controladornombre = TextEditingController();
    controladorcorreo = TextEditingController();
    controladorContrasena = TextEditingController();
    controladorEstado = TextEditingController();
    controladorEstadoServicio = TextEditingController();
    controladorUsuario = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alert',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Listar'),
        ),
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
                      top: MediaQuery.of(context).size.height / 9 - 30,
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
                              TextFormField(
                                controller: controladornombre,

                                keyboardType: TextInputType.name,
                                style: TextStyle(
                                    fontWeight: FontWeight
                                        .bold), // Probar todos los teclados
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue[50],
                                            width: 1.0)),
                                    fillColor: Colors.white70,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.blue,
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
                                controller: controladorUsuario,

                                keyboardType: TextInputType.name,
                                style: TextStyle(
                                    fontWeight: FontWeight
                                        .bold), // Probar todos los teclados
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1.0)),
                                    fillColor: Colors.white70,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    ),
                                    labelText: 'UserName',
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
                                controller: controladorcorreo,

                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                    fontWeight: FontWeight
                                        .bold), // Probar todos los teclados
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1.0)),
                                    fillColor: Colors.white70,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.account_box,
                                      color: Colors.blue,
                                    ),
                                    labelText: 'Correo',
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
                                controller: controladorContrasena,

                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontWeight: FontWeight
                                        .bold), // Probar todos los teclados
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1.0)),
                                    fillColor: Colors.white70,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.blue,
                                    ),
                                    labelText: 'Contrasena',
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
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 70),
                                child: DropdownButtonFormField(
                                  items: _lista.map((String a) {
                                    return DropdownMenuItem(
                                        value: a, child: Text(a));
                                  }).toList(),
                                  onChanged: (_value) => {
                                    _vista = _value,
                                    print(_vista),
                                  },
                                  hint: Text('Seleccione Estado'),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 70),
                                child: DropdownButtonFormField(
                                  items: _listaEstadoServicio.map((String a) {
                                    return DropdownMenuItem(
                                        value: a, child: Text(a));
                                  }).toList(),
                                  onChanged: (_value) => {
                                    _Estadoservicio = _value,
                                    print(_vista),
                                  },
                                  hint: Text('Seleccione Estado Servicio'),
                                ),
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
                                                academico:
                                                    controladorUsuario.text,
                                                telefono:
                                                    controladorContrasena.text,
                                                nacionalidad:
                                                    controladorEstado.text,
                                                correo:
                                                    controladorEstadoServicio
                                                        .text,
                                                foto: tmpFile,
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
                    Positioned(
                      top: MediaQuery.of(context).size.height / 12 - 120,
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
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                        border:
                                            Border.all(color: Colors.lightBlue),
                                      ),
                                      //color: Colors.blue,
                                      child: showImage(),
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
                      top: MediaQuery.of(context).size.height / 4 - 160,
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
        'https://lh5.googleusercontent.com/pro+xy/9vqIPeIeHQHyGEo43DlSgD-DUtidieclv56O6UoAcYNGPXGNnZwFJL2V7oSodehCB1YT28jit7pMSVjNTnrBOnlBxW0CiRmOeH22FlPockzEbfdQPHLkDMPcgMwWdNfVHF1r2QpUk6W_aY_J87A9lFtYKMHf8_xhkMB7l_4=s0-d');

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(join(documentDirectory.path, 'imagetest.png'));

    file.writeAsBytesSync(response.bodyBytes);

    tmpFile = file;

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
    if (tmpFile == null) {
      return Image.file(tmpFile);
    } else {
      print(imageFile);
      return Image.file(tmpFile, width: 400, height: 400);
    }
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return ClipRRect(
            borderRadius: BorderRadius.circular(108.0),
            child: _decideImageView(),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return _decideImageView();
        }
      },
    );
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

}

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: Container(
        color: Colors.blueAccent,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF56ccf2),
              ),
              accountName: Text("User Name Goes"),
              accountEmail: Text("emailaddress@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/vector-gratis/ilustracion-hospital_53876-81075.jpg?size=338&ext=jpg'),
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.android
                        ? Colors.black
                        : Colors.white,
              ),
            ),
            ListTile(
              title: Text('Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
              contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
              trailing: Icon(
                Icons.arrow_right,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Paciente()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
