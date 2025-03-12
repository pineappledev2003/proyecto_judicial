import 'package:flutter/cupertino.dart';
import 'package:proyecto_uml/models/cuaderno.dart';
import 'package:proyecto_uml/models/despacho_judicial.dart';
import 'package:proyecto_uml/models/expediente.dart';
import 'package:proyecto_uml/models/persona.dart';
import 'package:proyecto_uml/models/serie.dart';
import 'package:proyecto_uml/models/subserie.dart';

class ControllerExpediente extends ChangeNotifier {
  List<Expediente> _expedienteRegistrados = [];

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
    print('Registrando Expediente:');
    print('Despacho Judicial: ${despachoJudicial.obtenerNombreDespacho}');
    print('Número de Radicación: $numeroRadicacionProceso');
    print('Serie: ${serie.obtenerDescripcionSerie}');
    print('SubSerie: ${subSerie.obtenerDescripcionSubSerie}');
    print('Personas Tipo A: ${personasTipoA.map((p) => p.obtenerNombrePersona).toList()}');
    print('Personas Tipo B: ${personasTipoB.map((p) => p.obtenerNombrePersona).toList()}');
    print('Cuadernos:');
    cuadernos.forEach((key, value) {
      print('$key: ${value.obtenerNombreCuaderno}, descripcion: ${value.obtenerDescripcion}');
    });
    print('Expediente Físico: $expedienteFisico');
    print('Documento Físico: $documentoFisico');

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

  // void mostrarListaExpedientesEnConsola() {
  //   for (var expediente in _expedienteRegistrados) {
  //     print(
  //       'Despacho Judicial: ${expediente.obtenerDespachoJudicial?.obtenerNombreDespacho ?? "N/A"}',
  //     );
  //     print('Número de Radicación: ${expediente.obtenerNumeroRadicacionProceso ?? "N/A"}');
  //     print('Serie: ${expediente.obtenerSerie?.obtenerDescripcionSerie ?? "N/A"}');
  //     print('SubSerie: ${expediente.obtenerSubSerie?.obtenerDescripcionSubSerie ?? "N/A"}');

  //     print(
  //       'Personas Tipo A: ${expediente.obtenerPersonaTipoA != null ? expediente.obtenerPersonaTipoA.map((persona) => persona.obtenerNombrePersona).join(", ") : "N/A"}',
  //     );
  //     print(
  //       'Personas Tipo B: ${expediente.obtenerPersonaTipoB != null ? expediente.obtenerPersonaTipoB.map((persona) => persona.obtenerNombrePersona).join(", ") : "N/A"}',
  //     );

  //     print('Cuadernos: ${expediente.obtenerListaCuaderno?.keys.join(", ") ?? "N/A"}');
  //     print('Expediente Físico: ${expediente.obtenerExpedienteFisico ?? "N/A"}');
  //     print('Documento Físico: ${expediente.obtenerDocumentoFisico ?? "N/A"}');
  //     print('-----------------------------');
  //   }
  // }
}
