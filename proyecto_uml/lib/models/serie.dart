import 'package:proyecto_uml/models/subserie.dart';

class Serie {
  String? _codigoSerie;
  String? _descripcionSerie;
  Map<String, SubSerie>? _subSeries;

  Serie({
    required String codigoSerie,
    required String descripcionSerie,
    Map<String, SubSerie>? subSeries,
  }) {
    _codigoSerie = codigoSerie;
    _descripcionSerie = descripcionSerie;
    _subSeries = subSeries ?? {};
  }

  set cambiarCodigoSerie(String nuevoCodigoSerie) {
    _codigoSerie = nuevoCodigoSerie;
  }

  set cambiarDescripcionSerie(String nuevaDescripcionSerie) {
    _descripcionSerie = nuevaDescripcionSerie;
  }

  String get obtenerCodigoSerie {
    return _codigoSerie!;
  }

  String get obtenerDescripcionSerie {
    return _descripcionSerie!;
  }

  Map<String, SubSerie> get obtenerSubSerie {
    return _subSeries!;
  }

  void agregarSubSerie(SubSerie subSerie) {
    _subSeries![subSerie.obtenerCodigoSubSerie] = subSerie;
  }
}
