import 'package:flutter/cupertino.dart';
import 'package:proyecto_uml/models/cuaderno.dart';
import 'package:proyecto_uml/models/despacho_judicial.dart';
import 'package:proyecto_uml/models/expediente.dart';
import 'package:proyecto_uml/models/persona.dart';
import 'package:proyecto_uml/models/serie.dart';
import 'package:proyecto_uml/models/subserie.dart';


class ControllerExpedienteList extends ChangeNotifier {
  final List<Expediente> _expedienteRegistrados = [];

  void registarExpediente(
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

    _expedienteRegistrados.add(nuevoExpediente);
    notifyListeners();
  }

  List<Expediente> obtenerListaExpediente() {
    return _expedienteRegistrados;
  }

  void mostrarListaExpedientesEnConsola() {
    for (var expediente in _expedienteRegistrados) {
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
        print('$key: descripcion: ${value.obtenerDescripcion}');
      });
      print('Expediente Físico: ${expediente.obtenerExpedienteFisico}');
      print('Documento Físico: ${expediente.obtenerDocumentoFisico}');
      print('-----------------------------');
    }
  }

  void mostrarExpedientePorRadicacion(String numeroRadicacion) {
    Expediente? expedienteEncontrado = _expedienteRegistrados.firstWhere(
      (expediente) => expediente.obtenerNumeroRadicacionProceso == numeroRadicacion,
    );

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
    print('expedienteEncontrado Físico: ${expedienteEncontrado.obtenerExpedienteFisico}');
    print('Documento Físico: ${expedienteEncontrado.obtenerDocumentoFisico}');
    print('-----------------------------');
  }
}
