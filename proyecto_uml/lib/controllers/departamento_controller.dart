import 'package:flutter/material.dart';
import 'package:proyecto_uml/models/ciudad.dart';
import 'package:proyecto_uml/models/departamento.dart';
import 'package:proyecto_uml/utils/notification.dart';


class DepartamentoController extends ChangeNotifier {
  
  DepartamentoController(){
    _cargarDepartamentosIniciales();
  }

  List<Departamento> _departamentos = [];

  void agregarDepartamento(Departamento departamento) {
    bool existeDepartamento = _departamentos.any(
      (dep) => dep.obtenerNombreDepartamento == departamento.obtenerNombreDepartamento,
    );

    if (existeDepartamento) {
      Notificacion.mostrar("Departamento ya existe", isError: true);
      return;
    }

    _departamentos.add(departamento);
    notifyListeners();
  }

  List<Departamento> get obtenerDepartamentos {
    return List.unmodifiable(_departamentos);
  }

  void agregarCiudadADepartamento(Departamento departamentos, List<Ciudad> ciudad) {
    // Busqueda de departamento
    Departamento? departamento = _departamentos.firstWhere(
      (buscarDep) => buscarDep.obtenerNombreDepartamento == departamentos.obtenerNombreDepartamento,
      orElse: () => throw Exception("Departamento no encontrado "),
    );

    // Agrega la ciudad al departamento encontrado
    departamento.obtenerListaCiudades.addAll(ciudad);
    notifyListeners();
  }

  List<Ciudad> obtenerCiudadesPorDepartamento(Departamento departamento) {
    return List.unmodifiable(departamento.obtenerListaCiudades);
  }

 void _cargarDepartamentosIniciales() {
  // Crear instancias de departamentos
  List<Departamento> departamentos = [
    Departamento(nombreDepartamento: "Antioquia"),
    Departamento(nombreDepartamento: "Cundinamarca"),
    Departamento(nombreDepartamento: "Valle del Cauca"),
    Departamento(nombreDepartamento: "Atlántico"),
    Departamento(nombreDepartamento: "Cesar"),
  ];

  // Agregar los departamentos a la lista
  _departamentos.addAll(departamentos);

  // Agregar ciudades a cada departamento usando el objeto directamente
  agregarCiudadADepartamento(departamentos[0], [
    Ciudad(nombreCiudad: "Medellín"),
    Ciudad(nombreCiudad: "Envigado"),
    Ciudad(nombreCiudad: "Itagüí"),
    Ciudad(nombreCiudad: "Bello"),
    Ciudad(nombreCiudad: "Rionegro"),
    Ciudad(nombreCiudad: "Turbo"),
  ]);

  agregarCiudadADepartamento(departamentos[1], [
    Ciudad(nombreCiudad: "Bogotá"),
    Ciudad(nombreCiudad: "Soacha"),
    Ciudad(nombreCiudad: "Zipaquirá"),
    Ciudad(nombreCiudad: "Chía"),
    Ciudad(nombreCiudad: "Fusagasugá"),
    Ciudad(nombreCiudad: "Girardot"),
  ]);

  agregarCiudadADepartamento(departamentos[2], [
    Ciudad(nombreCiudad: "Cali"),
    Ciudad(nombreCiudad: "Palmira"),
    Ciudad(nombreCiudad: "Tuluá"),
    Ciudad(nombreCiudad: "Buenaventura"),
    Ciudad(nombreCiudad: "Buga"),
    Ciudad(nombreCiudad: "Cartago"),
  ]);

  agregarCiudadADepartamento(departamentos[3], [
    Ciudad(nombreCiudad: "Barranquilla"),
    Ciudad(nombreCiudad: "Soledad"),
    Ciudad(nombreCiudad: "Malambo"),
    Ciudad(nombreCiudad: "Puerto Colombia"),
    Ciudad(nombreCiudad: "Sabanalarga"),
    Ciudad(nombreCiudad: "Galapa"),
  ]);

  agregarCiudadADepartamento(departamentos[4], [
    Ciudad(nombreCiudad: "Aguachica"),
    Ciudad(nombreCiudad: "Astrea"),
    Ciudad(nombreCiudad: "Paz"),
    Ciudad(nombreCiudad: "Bosconia"),
    Ciudad(nombreCiudad: "San Diego"),
    Ciudad(nombreCiudad: "Valledupar"),
  ]);

  notifyListeners();
}

}
