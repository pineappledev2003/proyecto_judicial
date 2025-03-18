import 'package:flutter/cupertino.dart';
import 'package:proyecto_uml/models/cuaderno.dart';

class ControllerCuadernoList extends ChangeNotifier {
  final List<Cuaderno> _cuadernosRegistrados = [];

  void registrarCuaderno(String nombre, String descripcion) {
    Cuaderno nuevoCuaderno = Cuaderno(
      nombreCuaderno: nombre,
      descripcion: descripcion,
      documentos: [],
    );
    _cuadernosRegistrados.add(nuevoCuaderno);
    notifyListeners();
  }

  List<Cuaderno> get obtenerListaCuaderno {
    return List.unmodifiable(_cuadernosRegistrados);
  }
}
