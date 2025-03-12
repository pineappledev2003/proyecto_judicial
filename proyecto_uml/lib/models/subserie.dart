import 'package:proyecto_uml/models/tipo_docuemental.dart';

class SubSerie {
  String? _codigoSubSerie;
  String? _descripcionSubSerie;
  List<TipoDocuemental> _tiposDocumentales = [];

  SubSerie({required String codigoSubSerie, required String descripcionSubSerie}) {
    _codigoSubSerie = codigoSubSerie;
    _descripcionSubSerie = descripcionSubSerie;
  }

  set cambiarCodigoSubSerie(String nuevoCodigoSubSerie) {
    _codigoSubSerie = nuevoCodigoSubSerie;
  }

  set cambiarDescripcionSubSerie(String nuevaDescripcionSubSerie) {
    _descripcionSubSerie = nuevaDescripcionSubSerie;
  }

  String get obtenerCodigoSubSerie {
    return _codigoSubSerie!;
  }

  String get obtenerDescripcionSubSerie {
    return _descripcionSubSerie!;
  }

  void agregarTipoDocumental(TipoDocuemental tipoDocumental) {
    _tiposDocumentales.add(tipoDocumental);
  }

  List<TipoDocuemental> get obtenerListaTipoDocumentales {
    return _tiposDocumentales;
  }
}
