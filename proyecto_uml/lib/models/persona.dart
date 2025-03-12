class Persona {
  String? _tipoDocumento;
  String? _numeroDocumento;
  String? _nombrePersona;
  String? _rol;
  String? _tipoPersona;

  Persona({
    required String tipoDocumento,
    required String numeroDocumento,
    required String nombrePersona,
    required String rol,
    required String tipoPersona,
  }) {
    _tipoDocumento = tipoDocumento;
    _numeroDocumento = numeroDocumento;
    _nombrePersona = nombrePersona;
    _rol = rol;
    _tipoPersona = tipoPersona;
  }

  set cambiarTipoDocumento(String nuevoTipoDocumento) {
    _tipoDocumento = nuevoTipoDocumento;
  }

  set cambiarNumeroDocumento(String nuevoDocumento) {
    _numeroDocumento = nuevoDocumento;
  }

  set cambiarNombrePersona(String nuevoNombrePersona) {
    _nombrePersona = nuevoNombrePersona;
  }

  set cambiarRol(String nuevoRol) {
    _rol = nuevoRol;
  }

  set cambiarTipoPersona(String nuevoTipoPersona) {
    _tipoPersona = nuevoTipoPersona;
  }

  String get obtenerTipoDocumento {
    return _tipoDocumento!;
  }

  String get obtenerNumeroDocumento {
    return _numeroDocumento!;
  }

  String get obtenerNombrePersona {
    return _nombrePersona!;
  }

  String get obtenerRol {
    return _rol!;
  }

  String get obtenerTipoPersona {
    return _tipoPersona!;
  }
}
