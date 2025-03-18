import 'package:flutter/material.dart';
import 'package:proyecto_uml/models/ciudad.dart';
import 'package:proyecto_uml/models/departamento.dart';
import 'package:proyecto_uml/models/despacho_judicial.dart';


class DespachoListaController extends ChangeNotifier {
  List<DespachoJudicial> _despachosJudicialesRegistrados = [];

  void registrarDespacho(String codigoDespacho, Departamento departamento, Ciudad ciudad, String nombreDespachoJudicial, String categoria) {
    bool existe = _despachosJudicialesRegistrados.any((d) => d.obtenerCodigoDespacho == codigoDespacho);
    if (existe) {
      throw Exception("El código de despacho ya está registrado.");
    }
    DespachoJudicial despacho = DespachoJudicial(
      codigoDespacho: codigoDespacho,
      departamento: departamento,
      ciudad: ciudad,
      nombreDespachoJudicial: nombreDespachoJudicial,
      categoria: categoria,
    );
    _despachosJudicialesRegistrados.add(despacho);
    notifyListeners();
  }

  List<DespachoJudicial> obtenerListaDespacho() {
    return _despachosJudicialesRegistrados;
  }

  void mostrarListaDespachoList() {
    print("Listado de Despacho (Modo List)");
    print("-------------------------------------------------------");
    for (var despacho in _despachosJudicialesRegistrados) {
      print("Codigo Despacho: ${despacho.obtenerCodigoDespacho}");
      print("Ciudad: ${despacho.obtenerCiudad.obtenerNombreCiudad}");
      print("Departamento: ${despacho.obtenerDepartamento.obtenerNombreDepartamento}");
      print("Nombre: ${despacho.obtenerNombreDespacho}");
      print("Categoria: ${despacho.obtenerCategoria}");
      print("-------------------------------------------------------");
    }
  }
}
