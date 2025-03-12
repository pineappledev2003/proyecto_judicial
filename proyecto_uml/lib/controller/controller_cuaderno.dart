import 'package:flutter/cupertino.dart';
import 'package:proyecto_uml/models/cuaderno.dart';

class ControllerCuaderno extends ChangeNotifier {
  Map<String, Cuaderno> _cuadernosRegistrados = {};

  void registarCuaderno(Cuaderno cuaderno) {
    _cuadernosRegistrados[cuaderno.obtenerNombreCuaderno] = cuaderno;
    notifyListeners();
  }

  Map<String, Cuaderno> get obtenerListaCuaderno {
    return _cuadernosRegistrados;
  }
}
