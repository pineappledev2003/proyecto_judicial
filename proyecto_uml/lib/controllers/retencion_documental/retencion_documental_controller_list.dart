import 'package:flutter/material.dart';
import 'package:proyecto_uml/models/serie.dart';
import 'package:proyecto_uml/models/subserie.dart';
import 'package:proyecto_uml/models/tipo_documental.dart';


class RetencionDocumentalControllerList extends ChangeNotifier {
  List<Serie> _seriesRegistradasLista = [];

  void agregarSerie(String codigoSerie, String descripcionSerie) {
    if (_seriesRegistradasLista.any((serie) => serie.obtenerCodigoSerie == codigoSerie)) {
      throw ArgumentError("La serie con código $codigoSerie ya existe.");
    }

    Serie nuevaSerie = Serie(
      codigoSerie: codigoSerie,
      descripcionSerie: descripcionSerie,
      subSeries: {},
    );

    _seriesRegistradasLista.add(nuevaSerie);
    notifyListeners();
  }

  void agregarSubSerie(String codigoSerie, List<SubSerie> subSeries) {
    Serie? serieEncontrada = _seriesRegistradasLista.firstWhere(
      (serie) => serie.obtenerCodigoSerie == codigoSerie,
      orElse: () => throw ArgumentError("La serie con código $codigoSerie no existe."),
    );

    for (var nuevaSubSerie in subSeries) {
      if (serieEncontrada.obtenerSubSerie.containsKey(nuevaSubSerie.obtenerCodigoSubSerie)) {
        throw ArgumentError(
          "La SubSerie con código ${nuevaSubSerie.obtenerCodigoSubSerie} ya existe.",
        );
      }

      serieEncontrada.agregarSubSerie(nuevaSubSerie);
    }

    notifyListeners();
  }

  void agregarTipoDocumental(
    String codigoSerie,
    String codigoSubSerie,
    List<TipoDocumental> tipoDocumentales,
  ) {
    Serie? serieEncontrada = _seriesRegistradasLista.firstWhere(
      (serie) => serie.obtenerCodigoSerie == codigoSerie,
      orElse: () => throw ArgumentError("La serie con código $codigoSerie no existe."),
    );

    SubSerie? subSerieEncontrada = serieEncontrada.obtenerSubSerie[codigoSubSerie];

    if (subSerieEncontrada == null) {
      throw ArgumentError(
        "La SubSerie con código $codigoSubSerie no existe en la serie $codigoSerie.",
      );
    }

    for (var tipoDoc in tipoDocumentales) {
      subSerieEncontrada.agregarTipoDocumental(tipoDoc);
    }
    notifyListeners();
  }

  List<Serie> get obtenerListaSerieEnLista{
    return _seriesRegistradasLista;
  }

  void mostrarListadoList() {
    print("\n📂 **Tabla de Retención Documental (LIST):**");
    for (var serie in _seriesRegistradasLista) {
      print("📂 Serie: ${serie.obtenerCodigoSerie} - ${serie.obtenerDescripcionSerie}");

      if (serie.obtenerSubSerie.isEmpty) {
        print("   └ No tiene subseries.");
      } else {
        for (var subSerie in serie.obtenerSubSerie.values) {
          print(
            "   📁 SubSerie: ${subSerie.obtenerCodigoSubSerie} - ${subSerie.obtenerDescripcionSubSerie}",
          );

          if (subSerie.obtenerTiposDocumentales.isEmpty) {
            print("      └ No tiene tipos documentales.");
          } else {
            for (var tipoDocumental in subSerie.obtenerTiposDocumentales) {
              print("      📄 Tipo Documental: ${tipoDocumental.obtenerTipoDocumental}");
            }
          }
        }
      }
    }
  }
}
