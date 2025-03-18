class Ciudad {
  String? _nombreCiudad;

  Ciudad({required String nombreCiudad}) {
    _nombreCiudad = nombreCiudad;
  }

  set cambiarNombre(String nuevoNombre) {
    _nombreCiudad = nuevoNombre;
  }

  String get obtenerNombreCiudad {
    return _nombreCiudad!;
  }
}
