import 'package:flutter/cupertino.dart';
import 'package:proyecto_uml/models/persona.dart';

class ControllerPersonaMap extends ChangeNotifier {
  final Map<String, Persona> _personasRegistradas = {};

  void registrarPersona(
    String tipoDocumento,
    String numeroDocumento,
    String nombrePersona,
    String rol,
    String tipoPersona,
  ) {
    if (_personasRegistradas.containsKey(numeroDocumento)) {
      throw ArgumentError("El numero de documento ya existe");
    }
    Persona nuevaPersona = Persona(
      tipoDocumento: tipoDocumento,
      numeroDocumento: numeroDocumento,
      nombrePersona: nombrePersona,
      rol: rol,
      tipoPersona: tipoPersona,
    );

    _personasRegistradas[numeroDocumento] = nuevaPersona;
    notifyListeners();
  }

  Persona? obtenerPersona(String numeroDocumento) {
    return _personasRegistradas[numeroDocumento];
  }

  List<Persona> obtenerTodasLasPersonas() {
    return _personasRegistradas.values.toList();
  }

  List<Persona> filtrarPorRolA() {
    List<String> rolesParteA = ["Demandado", "Procesado", "Accionado"];
    return _personasRegistradas.values
        .where((persona) => rolesParteA.contains(persona.obtenerRol))
        .toList();
  }

  List<Persona> filtrarPorRolB() {
    List<String> rolesParteB = ["Demandante", "Denunciante", "Accionante"];
    return _personasRegistradas.values
        .where((persona) => rolesParteB.contains(persona.obtenerRol))
        .toList();
  }

  void limpiarPersonas() {
    _personasRegistradas.clear();
    notifyListeners();
  }
}
