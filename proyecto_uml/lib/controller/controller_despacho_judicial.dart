import 'package:proyecto_uml/models/ciudad.dart';
import 'package:proyecto_uml/models/depacho_judicial.dart';
import 'package:proyecto_uml/models/departamento.dart';

class ControllerDespachoJudicial {
  // Mi controlador va a recbir una lista de departamentos esto debido a que en departamento_data.dart ya devuelvo una lista de departamentos con sus ciudades
  // yo lo que necesito es que mi controlador pueda recibir esa lista para luego poder sacar el departamento y las ciudades que lo conforman

  // por esta razon se declara una lista de departamentos
  List<Departamento> _departamentos;

  ControllerDespachoJudicial(this._departamentos);

  List<DespachoJudicial> _despachosJudicialesRegistrado = [];

  void registarDespacho(
    String codigoDespacho,
    Departamento departamento,
    Ciudad ciudad,
    String nombreDespachoJudicial,
    String categoria,
  ) {
    DespachoJudicial despacho = DespachoJudicial(
      codigoDespacho: codigoDespacho,
      departamento: departamento,
      ciudad: ciudad,
      nombreDespachoJudicial: nombreDespachoJudicial,
      categoria: categoria,
    );

    _despachosJudicialesRegistrado.add(despacho);
  }

  // Este metodo recibe un objeto "Departamento" como parametro en lugar de una lista de departamentos
  // La razon es que ya tenemos el objeto "Departamento" especifico del cual queremos obtener las ciudades
  // Esto simplifica el proceso y hace el codigo mas eficiente, evitando la necesidad de buscar el departamento
  // en una lista cada vez que necesitamos sus ciudades

  List<Ciudad> obtenerCiudadesPorDepartamento(Departamento departamento) {
    return departamento.obtenerListaCiudades;
  }

  List<Departamento> obtenerDepartamentos() {
    return _departamentos;
  }
}
