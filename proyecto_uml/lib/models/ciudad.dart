// ignore_for_file: file_names

class Ciudad {
  String? _nombreCiudad;

  Ciudad({required String nombreCiudad}) {
    _nombreCiudad = _validarNombreCiudad(nombreCiudad);
  }

  set cambiarNombre(String nuevoNombreCiudad) {
    _nombreCiudad = _validarNombreCiudad(nuevoNombreCiudad);
  }

  String get obtenerNombreCiudad {
    return _nombreCiudad!;
  }

  String _validarNombreCiudad(String nombreCiudad) {
    if (nombreCiudad.isEmpty) {
      throw ArgumentError("El nombre de la ciudad no puede estar vacio");
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(nombreCiudad)) {
      throw ArgumentError("El nombre de la ciudad solo debe contener letras y espacio");
    }

    return nombreCiudad;
  }
}
