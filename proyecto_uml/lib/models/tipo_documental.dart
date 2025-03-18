class TipoDocumental {
  String? _tipoDocumental;

  TipoDocumental({required String tipoDocumental}){
    _tipoDocumental = tipoDocumental;
  }

  set cambiarTipoDocumental(String nuevoTipoDocumental){
    _tipoDocumental = nuevoTipoDocumental;
  }

  String get obtenerTipoDocumental{
    return _tipoDocumental!;
  }
}