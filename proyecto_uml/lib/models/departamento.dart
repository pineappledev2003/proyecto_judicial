import 'package:proyecto_uml/models/ciudad.dart';

class Departamento {
  String? _nombreDepartamento;
  List<Ciudad>? _ciudades = [];

  Departamento({required String nombreDepartamento, List<Ciudad>? ciudades}) {
    _nombreDepartamento = _validarNombreDepartamento(nombreDepartamento);
    if (ciudades != null) {
      _ciudades = ciudades;
    }
  }

  set cambiarNombreDepartamento(String nuevoNombreDepartamento) {
    _nombreDepartamento = _validarNombreDepartamento(nuevoNombreDepartamento);
  }

  String get obtenerNombreDepartamento {
    return _nombreDepartamento!;
  }

  List<Ciudad> get obtenerListaCiudades {
    return _ciudades!;
  }

  void agregarCiudad(List<Ciudad> ciudad) {
    _ciudades!.addAll(ciudad);
  }

  String _validarNombreDepartamento(String nombreDepartamento) {
    if (nombreDepartamento.isEmpty) {
      throw ArgumentError("El nombre del departamento no puede estar vacio");
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(nombreDepartamento)) {
      throw ArgumentError("El nombre del departamento solo debe contener letras y espacio");
    }

    return nombreDepartamento;
  }
}
