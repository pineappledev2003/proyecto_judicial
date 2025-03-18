
import 'package:proyecto_uml/models/cuaderno.dart';
import 'package:proyecto_uml/models/tipo_documental.dart';

class Documentos {
 TipoDocumental? _nombreDocumento;
  DateTime? _fechaIncorporacionExpediente;
  DateTime? _fechaCreacionDocumento;
  int? _ordenDocumento;
  int? _numeroPaginas;
  int? _paginaInicio;
  int? _paginaFin;
  String? _formato;
  String? _tamano;
  String? _origen;
  Cuaderno? _cuaderno;
  String? _observaciones;

  Documentos({
    required TipoDocumental nombreDocumento,
    required DateTime fechaIncorporacionExpediente,
    required DateTime fechaCreacionDocumento,
    required int ordenDocumentos,
    required int numeroPaginas,
    required int paginaInicio,
    required int paginaFin,
    required String formato,
    required String tamano,
    required String origen,
    required Cuaderno cuaderno,
    required String observaciones,
  }) {
    _nombreDocumento = nombreDocumento;
    _fechaIncorporacionExpediente = fechaIncorporacionExpediente;
    _fechaCreacionDocumento = fechaCreacionDocumento;
    _ordenDocumento = ordenDocumentos;
    _numeroPaginas = numeroPaginas;
    _paginaInicio = paginaInicio;
    _paginaFin = paginaFin;
    _formato = formato;
    _tamano = tamano;
    _origen = origen;
    _cuaderno = cuaderno;
    _observaciones = observaciones;
  }

  TipoDocumental get obtenernombreDocumento {
    return _nombreDocumento!;
  }

  DateTime get obtenerfechaCreacionDocumento {
    return _fechaCreacionDocumento!;
  }

  DateTime get obtenerfechaIncorporacionExpediente {
    return _fechaIncorporacionExpediente!;
  }

  int get obtenerOrdenDocumento {
    return _ordenDocumento!;
  }

  int get obtenernumeroPaginas {
    return _numeroPaginas!;
  }

  int get obtenerpaginaInicio {
    return _paginaInicio!;
  }

  int get obtenerpaginaFin {
    return _paginaFin!;
  }

  String get obtenerformato {
    return _formato!;
  }

  String get obtenertamano {
    return _tamano!;
  }

  String get obtenerorigen {
    return _origen!;
  }

  Cuaderno get obtenercuaderno {
    return _cuaderno!;
  }

  String get obtenerobservaciones {
    return _observaciones!;
  }

  // Setters
  set cambiarnombreDocumento(TipoDocumental? nuevoTipoDocumental) {
    _nombreDocumento = nuevoTipoDocumental;
  }

  set cambiarfechaCreacionDocumento(DateTime? nuevaFechaCreacionDocuemnto) {
    _fechaCreacionDocumento = nuevaFechaCreacionDocuemnto;
  }

  set cambiarfechaIncorporacionExpediente(DateTime? nuevaFechaIncorporacionExpediente) {
    _fechaIncorporacionExpediente = nuevaFechaIncorporacionExpediente;
  }

  set cambiarordenDocumento(int nuevoOrdenDocumento) {
    _ordenDocumento = nuevoOrdenDocumento;
  }

  set cambiarnumeroPaginas(int nuevoNumeroPaginas) {
    _numeroPaginas = nuevoNumeroPaginas;
  }

  set cambiarpaginaInicio(int nuevaPaginaInicio) {
    _paginaInicio = nuevaPaginaInicio;
  }

  set cambiarpaginaFin(int nuevaPaginaFin) {
    _paginaFin = nuevaPaginaFin;
  }

  set cambiarformato(String nuevoFormato) {
    _formato = nuevoFormato;
  }

  set cambiartamano(String nuevoTamano) {
    _tamano = nuevoTamano;
  }

  set cambiarorigen(String nuevoOrigen) {
    _origen = nuevoOrigen;
  }

  set cambiarcuaderno(Cuaderno nuevoCuaderno) {
    _cuaderno = nuevoCuaderno;
  }

  set cambiarobservaciones(String nuevaObservaciones) {
    _observaciones = nuevaObservaciones;
  }
}
