

import 'package:proyecto_uml/models/documentos.dart';

class Cuaderno {
  String? _nombreCuaderno;
  String? _descripcion;
  List<Documentos> _documentos = [];

  Cuaderno({required String nombreCuaderno, required String descripcion , required  List<Documentos> documentos}) {
    _nombreCuaderno = nombreCuaderno;
    _descripcion = descripcion;
    _documentos = documentos;
  }

  set cambiarNombreCuaderno(String nuevoNombreCuaderno) {
    _nombreCuaderno = nuevoNombreCuaderno;
  }

  set cambiarDescripcionCuaderno(String nuevaDescripcion) {
    _descripcion = nuevaDescripcion;
  }

  String get obtenerNombreCuaderno {
    return _nombreCuaderno!;
  }

  String get obtenerDescripcion {
    return _descripcion!;
  }

  void agregarDocumento(Documentos documento) {
    _documentos.add(documento);
  }

  List<Documentos> obtenerDocumentos() {
    return _documentos;
  }
}
