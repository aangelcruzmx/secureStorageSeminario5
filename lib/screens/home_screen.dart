import 'package:flutter/material.dart';
import 'package:prefusuarios/shared_prefs/shared_preferences.dart';
import 'package:prefusuarios/widgets/drawer_menu.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final prefs = UserPreferences();
  int _genero = 1;
  bool _colorSecundario = false;
  String _nombreUsuario = '';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    prefs.setUltimaPagina(HomeScreen.routeName);
  }

  Future<void> _loadPreferences() async {
    int genero = await prefs.genero;
    bool colorSecundario = await prefs.colorSecundario;
    String nombreUsuario = await prefs.nombreUsuario;

    setState(() {
      _genero = genero;
      _colorSecundario = colorSecundario;
      _nombreUsuario = nombreUsuario;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: _colorSecundario ? Colors.teal : Colors.red,
      ),
      drawer: DrawerMenu(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Género: ${_genero == 1 ? 'Masculino' : 'Femenino'}'),
          Divider(),
          Text('Nombre: $_nombreUsuario'),
        ],
      ),
    );
  }
}
