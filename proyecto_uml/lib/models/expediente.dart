import 'package:proyecto_uml/models/cuaderno.dart';
import 'package:proyecto_uml/models/despacho_judicial.dart';
import 'package:proyecto_uml/models/persona.dart';
import 'package:proyecto_uml/models/serie.dart';
import 'package:proyecto_uml/models/subserie.dart';

class Expediente {
  DespachoJudicial? _despachoJudicial;
  String? _numeroRadicacionProceso;
  Serie? _serie;
  SubSerie? _subSerie;
  List<Persona>? _personasTipoA;
  List<Persona>? _personasTipoB;
  Map<String, Cuaderno>? _cuadernos = {};
  bool? _expedienteFisico;
  bool? _documentoFisico;

  Expediente({
    required DespachoJudicial despachoJudicial,
    required String numeroRadicacionProceso,
    required Serie serie,
    required SubSerie subSerie,
    required List<Persona> personaTipoA,
    required List<Persona> personaTipoB,
    required Map<String, Cuaderno> cuadernos,
    required bool expedienteFisico,
    required bool documentoFisico,
  }) {
    _despachoJudicial = despachoJudicial;
    _numeroRadicacionProceso = numeroRadicacionProceso;
    _serie = serie;
    _subSerie = subSerie;
    _personasTipoA = personaTipoA;
    _personasTipoB = _personasTipoB;
    _cuadernos = cuadernos;
    _expedienteFisico = expedienteFisico;
    _documentoFisico = documentoFisico;
  }

  set cambiarExpedienteFisico(bool nuevoExpedienteFsico) {
    _expedienteFisico = nuevoExpedienteFsico;
  }

  set cambiarDocumentoFisico(bool nuevoDocumentoFisico) {
    _documentoFisico = nuevoDocumentoFisico;
  }

  set cambiarNumeroRadicacionProceso(String nuevoNumeroRadicacionProceso) {
    _numeroRadicacionProceso = nuevoNumeroRadicacionProceso;
  }

  DespachoJudicial get obtenerDespachoJudicial {
    return _despachoJudicial!;
  }

  String get obtenerNumeroRadicacionProceso {
    return _numeroRadicacionProceso!;
  }

  Serie get obtenerSerie {
    return _serie!;
  }

  SubSerie get obtenerSubSerie {
    return _subSerie!;
  }

  List<Persona> get obtenerPersonaTipoA {
    return _personasTipoA!;
  }

  List<Persona> get obtenerPersonaTipoB {
    return _personasTipoB!;
  }

  Map<String, Cuaderno> get obtenerListaCuaderno {
    return _cuadernos!;
  }

  bool get obtenerExpedienteFisico {
    return _expedienteFisico!;
  }

  bool get obtenerDocumentoFisico {
    return _documentoFisico!;
  }
}
