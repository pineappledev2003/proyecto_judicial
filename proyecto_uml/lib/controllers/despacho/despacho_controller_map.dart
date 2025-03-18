import 'package:flutter/material.dart';
import 'package:proyecto_uml/models/ciudad.dart';
import 'package:proyecto_uml/models/departamento.dart';
import 'package:proyecto_uml/models/despacho_judicial.dart';

class DespachoMapaController extends ChangeNotifier {
  final Map<String, DespachoJudicial> _despachoJudicialesRegistradoMapa = {};

  void registrarDespacho(String codigoDespacho, Departamento departamento, Ciudad ciudad, String nombreDespachoJudicial, String categoria) {
    if (_despachoJudicialesRegistradoMapa.containsKey(codigoDespacho)) {
      throw Exception("El código de despacho ya está registrado.");
    }
    DespachoJudicial despacho = DespachoJudicial(
      codigoDespacho: codigoDespacho,
      departamento: departamento,
      ciudad: ciudad,
      nombreDespachoJudicial: nombreDespachoJudicial,
      categoria: categoria,
    );
    _despachoJudicialesRegistradoMapa[codigoDespacho] = despacho;
    notifyListeners();
  }

  Map<String, DespachoJudicial> obtenerMapaDespacho() {
    return _despachoJudicialesRegistradoMapa;
  }

  void mostrarMapaDespachoMapa() {
    print("Listado de Despacho (Modo Map)");
    print("-------------------------------------------------------");
    _despachoJudicialesRegistradoMapa.forEach((key, despacho) {
      print("Codigo Despacho: ${despacho.obtenerCodigoDespacho}");
      print("Ciudad: ${despacho.obtenerCiudad.obtenerNombreCiudad}");
      print("Departamento: ${despacho.obtenerDepartamento.obtenerNombreDepartamento}");
      print("Nombre: ${despacho.obtenerNombreDespacho}");
      print("Categoria: ${despacho.obtenerCategoria}");
      print("-------------------------------------------------------");
    });
  }
}
