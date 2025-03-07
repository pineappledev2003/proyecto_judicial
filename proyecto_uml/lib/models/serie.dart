import 'package:proyecto_uml/models/sub_serie.dart';

class Serie {
  String? _codigo;
  String? _descripcion;

  List<SubSerie> _subSerie = [];

  Serie({required String codigo, required String descripcion}) {
    _codigo = codigo;
    _descripcion = descripcion;
  }

  set cambiarCodigo(String nuevoCodigo) {
    _codigo = nuevoCodigo;
  }

  set cambiarDescripcion(String nuevaDescripcion) {
    _descripcion = nuevaDescripcion;
  }

  String get obtenerCodigo {
    return _codigo!;
  }

  String get obtenerDescripicion {
    return _descripcion!;
  }

  void agregarSubserie(SubSerie subSerie) {
    _subSerie.add(subSerie);
  }

  void mostarSubSerie() {
    print("SubSeries de la serie $_codigo :");
    for (var busquedaSerie in _subSerie) {
      print("${busquedaSerie.obtenerCodigo}, ${busquedaSerie.obtenerDescripicion}");
    }
  }
}
