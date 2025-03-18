import 'package:flutter/material.dart';
import 'package:proyecto_uml/models/serie.dart';
import 'package:proyecto_uml/models/subserie.dart';
import 'package:proyecto_uml/models/tipo_documental.dart';


class RetencionDocumentalMapaController extends ChangeNotifier {
  Map<String, Serie> _seriesRegistradasMapa = {};

  void agregarSerie(String codigoSerie, String descripicionSerie) {
    if (_seriesRegistradasMapa.containsKey(codigoSerie)) {
      throw ArgumentError("La serie con código $codigoSerie ya existe.");
    }

    Serie nuevaSerie = Serie(
      codigoSerie: codigoSerie,
      descripcionSerie: descripicionSerie,
      subSeries: {},
    );

    _seriesRegistradasMapa[codigoSerie] = nuevaSerie;
    notifyListeners();
  }

  void agregarSubSerie(String codigoSerie, List<SubSerie> subSeries) {
    Serie? serieEncontrada = _seriesRegistradasMapa[codigoSerie];

    if (serieEncontrada == null) {
      throw ArgumentError("La serie con código $codigoSerie no existe.");
    }

    for (var buscarSubSerie in subSeries) {
      if (!serieEncontrada.obtenerSubSerie.containsKey(buscarSubSerie.obtenerCodigoSubSerie)) {
        serieEncontrada.agregarSubSerie(buscarSubSerie);
      } else {
        throw ArgumentError(
          "La SubSerie con código ${buscarSubSerie.obtenerCodigoSubSerie} ya existe.",
        );
      }
    }

    notifyListeners();
  }

  void agregarTipoDocumental(
    String codigoSerie,
    String codigoSubSerie,
    List<TipoDocumental> tiposDocumentales,
  ) {
    Serie? serieEncontrada = _seriesRegistradasMapa[codigoSerie];

    if (serieEncontrada == null) {
      throw ArgumentError("La serie con código $codigoSerie no existe.");
    }

    SubSerie? subSerieEncontrada = serieEncontrada.obtenerSubSerie[codigoSubSerie];

    if (subSerieEncontrada == null) {
      throw ArgumentError(
        "La SubSerie con código $codigoSubSerie no existe en la serie $codigoSerie.",
      );
    }

    for (var tipoDoc in tiposDocumentales) {
      subSerieEncontrada.agregarTipoDocumental(tipoDoc);
    }
    notifyListeners();
  }

  Map<String, Serie> get obtenerListaSerieEnMapa {
    return _seriesRegistradasMapa;
  }

  void mostrarListaMap() {
    print("\n📂 **Tabla de Retención Documental (MAP):**");
    if (_seriesRegistradasMapa.isEmpty) {
      print("No hay serie registradas");
      return;
    }

    _seriesRegistradasMapa.forEach((codigoSerie, serie) {
      print(
        "Codigo Serie: ${serie.obtenerCodigoSerie} (Descripcion: ${serie.obtenerDescripcionSerie})",
      );

      serie.obtenerSubSerie.forEach((codigoSubSerie, subserie) {
        print(
          "Codigo subSerie: ${subserie.obtenerCodigoSubSerie} (Descripcion: ${subserie.obtenerDescripcionSubSerie})",
        );

        for (var tipoDoc in subserie.obtenerTiposDocumentales) {
          print("Tipo documental: ${tipoDoc.obtenerTipoDocumental}");
        }
      });
    });
  }
}
