import 'package:proyecto_uml/models/serie.dart';
import 'package:proyecto_uml/models/tipo_documental.dart';

class SubSerie extends Serie {
  List<TipoDocumental> _tipoDocumentales = [];

  SubSerie({required super.codigo, required super.descripcion});

  void agregarTipoDocumentalSubSerie(TipoDocumental tipoDocumental) {
    _tipoDocumentales.add(tipoDocumental);
  }

  void mostrarTipoDocumental() {
    print("Tipo documental de la subserie: $obtenerCodigo ");
    for (var busquedaTipos in _tipoDocumentales) {
      print("Tipo: ${busquedaTipos.obtenerTipoDocumental}");
    }
  }
}
