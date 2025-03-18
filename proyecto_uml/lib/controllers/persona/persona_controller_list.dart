import 'package:flutter/cupertino.dart';
import 'package:proyecto_uml/models/persona.dart';

class ControllerPersonaList extends ChangeNotifier {
  final List<Persona> _personasRegistradas = [];

  void registarPersona(
    String tipoDocumento,
    String numeroDocumento,
    String nombrePersona,
    String rol,
    String tipoPersona,
  ) {
    bool existe = _personasRegistradas.any(
      (buscarNumeroDoc) => buscarNumeroDoc.obtenerNumeroDocumento == numeroDocumento,
    );
    if (existe) {
      throw ArgumentError("Esta numero de cedula ya existe");
    }
    Persona nuevaPersona = Persona(
      tipoDocumento: tipoDocumento,
      numeroDocumento: numeroDocumento,
      nombrePersona: nombrePersona,
      rol: rol,
      tipoPersona: tipoPersona,
    );

    _personasRegistradas.add(nuevaPersona);
    notifyListeners();
  }

  List<Persona> obtenerPersona() {
    return _personasRegistradas;
  }

  List<Persona> filtarPorRolA() {
    List<String> rolesParteA = ["Demandado", "Procesado", "Accionado"];
    return _personasRegistradas
        .where((persona) => rolesParteA.contains(persona.obtenerRol))
        .toList();
  }

  List<Persona> filtarPorRolB() {
    List<String> rolesParteB = ["Demandante", "Denunciante", "Accionante"];
    return _personasRegistradas
        .where((persona) => rolesParteB.contains(persona.obtenerRol))
        .toList();
  }

  void limpiarPersonas() {
    _personasRegistradas.clear();
    notifyListeners();
  }
}
