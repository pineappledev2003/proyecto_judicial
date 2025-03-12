class Cuaderno {
  String? _nombreCuaderno;
  String? _descripcion;

  Cuaderno({required String nombreCuaderno, required String descripcion}) {
    _nombreCuaderno = nombreCuaderno;
    _descripcion = descripcion;
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
}
