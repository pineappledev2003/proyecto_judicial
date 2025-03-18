import 'package:flutter/cupertino.dart';
import 'package:proyecto_uml/models/cuaderno.dart';
import 'package:proyecto_uml/models/despacho_judicial.dart';
import 'package:proyecto_uml/models/expediente.dart';
import 'package:proyecto_uml/models/persona.dart';
import 'package:proyecto_uml/models/serie.dart';
import 'package:proyecto_uml/models/subserie.dart';


class ControllerExpedienteMap extends ChangeNotifier {
  final Map<String, Expediente> _expedientesRegistrados = {};

  void registrarExpediente(
    DespachoJudicial despachoJudicial,
    String numeroRadicacionProceso,
    Serie serie,
    SubSerie subSerie,
    List<Persona> personasTipoA,
    List<Persona> personasTipoB,
    Map<String, Cuaderno> cuadernos,
    bool expedienteFisico,
    bool documentoFisico,
  ) {
    Expediente nuevoExpediente = Expediente(
      despachoJudicial: despachoJudicial,
      numeroRadicacionProceso: numeroRadicacionProceso,
      serie: serie,
      subSerie: subSerie,
      personaTipoA: personasTipoA,
      personaTipoB: personasTipoB,
      cuadernos: cuadernos,
      expedienteFisico: expedienteFisico,
      documentoFisico: documentoFisico,
    );

    _expedientesRegistrados[numeroRadicacionProceso] = nuevoExpediente;
    notifyListeners();
  }

  List<Expediente> obtenerListaExpediente() {
    return _expedientesRegistrados.values.toList();
  }

  void mostrarMapExpedientesEnConsola() {
    _expedientesRegistrados.forEach((key, expediente) {
      print('Despacho Judicial: ${expediente.obtenerDespachoJudicial.obtenerNombreDespacho}');
      print('Número de Radicación: ${expediente.obtenerNumeroRadicacionProceso}');
      print('Serie: ${expediente.obtenerSerie.obtenerDescripcionSerie}');
      print('SubSerie: ${expediente.obtenerSubSerie.obtenerDescripcionSubSerie}');

      print(
        'Personas Tipo A: ${expediente.obtenerPersonaTipoA.map((p) => p.obtenerNombrePersona).toList()}',
      );
      print(
        'Personas Tipo B: ${expediente.obtenerPersonaTipoB.map((p) => p.obtenerNombrePersona).toList()}',
      );

      print('Cuadernos:');
      expediente.obtenerListaCuaderno.forEach((key, value) {
        print('$key: ${value.obtenerNombreCuaderno}, descripcion: ${value.obtenerDescripcion}');
      });
      print('Expediente Físico: ${expediente.obtenerExpedienteFisico}');
      print('Documento Físico: ${expediente.obtenerDocumentoFisico}');
      print('-----------------------------');
    });
  }

  void mostrarExpedientePorRadicacion(String numeroRadicacion) {
    if (_expedientesRegistrados.containsKey(numeroRadicacion)) {
      Expediente expedienteEncontrado = _expedientesRegistrados[numeroRadicacion]!;

      print(
        'Despacho Judicial: ${expedienteEncontrado.obtenerDespachoJudicial.obtenerNombreDespacho}',
      );
      print('Número de Radicación: ${expedienteEncontrado.obtenerNumeroRadicacionProceso}');
      print('Serie: ${expedienteEncontrado.obtenerSerie.obtenerDescripcionSerie}');
      print('SubSerie: ${expedienteEncontrado.obtenerSubSerie.obtenerDescripcionSubSerie}');

      print(
        'Personas Tipo A: ${expedienteEncontrado.obtenerPersonaTipoA.map((p) => p.obtenerNombrePersona).toList()}',
      );
      print(
        'Personas Tipo B: ${expedienteEncontrado.obtenerPersonaTipoB.map((p) => p.obtenerNombrePersona).toList()}',
      );

      print('Cuadernos:');
      expedienteEncontrado.obtenerListaCuaderno.forEach((key, value) {
        print('$key: ${value.obtenerNombreCuaderno}, descripcion: ${value.obtenerDescripcion}');
      });
      print('Expediente Físico: ${expedienteEncontrado.obtenerExpedienteFisico}');
      print('Documento Físico: ${expedienteEncontrado.obtenerDocumentoFisico}');
      print('-----------------------------');
    } else {
      print('No se encontró un expediente con el número de radicación $numeroRadicacion');
    }
  }
}