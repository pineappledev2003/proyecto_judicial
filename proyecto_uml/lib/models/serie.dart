import 'package:proyecto_uml/models/sub_serie.dart';

class Serie {
  String? _codigo;
  String? _descripcion;

  //Map<String, SubSerie> _subSeries = {};

  List<SubSerie> _subSeries = [];

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

  // Método para obtener una subserie por su código
  SubSerie? obtenerSubseriePorCodigo(String codigoSubSerie) {
    try {
      return _subSeries.firstWhere((subSerie) => subSerie._codigo == codigoSubSerie);
    } catch (e) {
      return null; // Si no se encuentra la subserie, retorna null
    }
  }

  bool contieneSubserie(SubSerie subserie) {
    // Verificar si ya existe una subserie con el mismo código
    return _subSeries.any((s) => s._codigo == subserie._codigo);
  }

  void agregarSubserie(SubSerie subSerie) {
    //_subSeries[subSerie.obtenerCodigo] = subSerie;
    _subSeries.add(subSerie);
  }

  void mostarSubSerie() {
    for (var subserie in _subSeries) {
      print("Subserie: ${subserie._codigo} - ${subserie._descripcion}");
    }
  }
}
