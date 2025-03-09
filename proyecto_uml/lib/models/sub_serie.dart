import 'package:proyecto_uml/models/serie.dart';
import 'package:proyecto_uml/models/tipo_documental.dart';

class SubSerie extends Serie {
  final List<TipoDocumental> _tipoDocumentales = [];

  SubSerie({required super.codigo, required super.descripcion});

  void agregarTipoDocumental(TipoDocumental tipoDocumental) {
    _tipoDocumentales.add(tipoDocumental);
  }

  // void agregarTipoDocumentalSubSerie(List<TipoDocumental> tipoDocumental) {
  //   _tipoDocumentales.addAll(tipoDocumental);
  // }

  List<TipoDocumental> get obtenerTipoDocumentales {
    return _tipoDocumentales;
  }

  void mostrarTipoDocumental() {
    print("Tipo documental de la subserie: $obtenerCodigo ");
    for (var busquedaTipos in _tipoDocumentales) {
      print("Tipo: ${busquedaTipos.obtenerTipoDocumental}");
    }
  }
}
