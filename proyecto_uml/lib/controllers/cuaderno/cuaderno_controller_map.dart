import 'package:flutter/cupertino.dart';
import 'package:proyecto_uml/models/cuaderno.dart';

class ControllerCuadernoMap extends ChangeNotifier {
  final Map<String, Cuaderno> _cuadernosRegistrados = {};

  void registarCuaderno(String nombreCuaderno, String descripcionCuaderno) {
    Cuaderno nuevoCuaderno = Cuaderno(
      nombreCuaderno: nombreCuaderno,
      descripcion: descripcionCuaderno,
      documentos: [],
    );
    _cuadernosRegistrados[nombreCuaderno] = nuevoCuaderno;
    notifyListeners();
  }

  Map<String, Cuaderno> get obtenerListaCuaderno {
    return _cuadernosRegistrados;
  }
}
