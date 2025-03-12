class TipoDocuemental {
  String? _nombreTipoDocumental;

  TipoDocuemental({required String nombreTipoDocumental}) {
    _nombreTipoDocumental = nombreTipoDocumental;
  }

  set cambiarNombreTipoDocumental(String nuevoNombreTipoDocumental) {
    _nombreTipoDocumental = nuevoNombreTipoDocumental;
  }

  String get obtenerNombreTipoDocumental {
    return _nombreTipoDocumental!;
  }
}
