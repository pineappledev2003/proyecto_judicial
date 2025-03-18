import 'package:proyecto_uml/models/tipo_documental.dart';

class SubSerie {
  String? _codigoSubSerie;
  String? _descripcionSubSerie;
  List<TipoDocumental>? _tiposDocumentales;

  SubSerie({
    required String codigoSubSerie,
    required String descripcionSubSerie,
    List<TipoDocumental>? tipoDocumentales,
  }) {
    _codigoSubSerie = codigoSubSerie;
    _descripcionSubSerie = descripcionSubSerie;
    _tiposDocumentales = tipoDocumentales ?? [];
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

  List<TipoDocumental> get obtenerTiposDocumentales {
    return _tiposDocumentales!;
  }

  void agregarTipoDocumental(TipoDocumental tipoDocumental) {
    _tiposDocumentales!.add(tipoDocumental);
  }
}
