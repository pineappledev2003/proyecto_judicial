import 'package:proyecto_uml/models/subserie.dart';

class Serie {
  String? _codigoSerie;
  String? _descripcionSerie;
  Map<String, SubSerie> _subSeries = {};

  Serie({required String codigoSerie, required String descripcionSerie}) {
    _codigoSerie = codigoSerie;
    _descripcionSerie = descripcionSerie;
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

  void agregarSubSerie(SubSerie subSerie) {
    _subSeries[subSerie.obtenerCodigoSubSerie] = subSerie;
  }

  Map<String, SubSerie> get obtenerMapSubSerie {
    return _subSeries;
  }
}
