import 'package:flutter/material.dart';
import 'package:prefusuarios/shared_prefs/shared_preferences.dart';

import 'package:prefusuarios/widgets/drawer_menu.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = 'settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final prefs = UserPreferences();
  int _genero = 1;
  bool _colorSecundario = false;
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    prefs.setUltimaPagina(SettingsScreen.routeName); // Guardar la última página abierta
  }

  Future<void> _loadPreferences() async {
    int genero = await prefs.genero;
    bool colorSecundario = await prefs.colorSecundario;
    String nombreUsuario = await prefs.nombreUsuario;

    setState(() {
      _genero = genero;
      _colorSecundario = colorSecundario;
      _textController.text = nombreUsuario;
    });
  }

  void _setSelectedRadio(int value) {
    setState(() {
      _genero = value;
      prefs.setGenero(value); // Guardar en Flutter Secure Storage
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
        backgroundColor: _colorSecundario ? Colors.teal : Colors.red,
      ),
      drawer: DrawerMenu(),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Settings',
              style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          SwitchListTile(
            value: _colorSecundario,
            title: Text('Color secundario'),
            onChanged: (value) {
              setState(() {
                _colorSecundario = value;
                prefs.setColorSecundario(value); // Guardar en Flutter Secure Storage
              });
            },
          ),
          RadioListTile(
            value: 1,
            title: Text('Masculino'),
            groupValue: _genero,
            onChanged: (value) => _setSelectedRadio(value as int),
          ),
          RadioListTile(
            value: 2,
            title: Text('Femenino'),
            groupValue: _genero,
            onChanged: (value) => _setSelectedRadio(value as int),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona usando el teléfono',
              ),
              onChanged: (value) {
                prefs.setNombreUsuario(value); // Guardar en Flutter Secure Storage
              },
            ),
          ),
        ],
      ),
    );
  }
}
