import 'package:flutter/widgets.dart';
import 'package:proyecto_uml/models/serie.dart';
import 'package:proyecto_uml/models/subserie.dart';
import 'package:proyecto_uml/models/tipo_docuemental.dart';

class ControllerRetencionDocumental extends ChangeNotifier {
  Map<String, Serie> _series = {};

  void agregarSerie(Serie serie) {
    if (_series.containsKey(serie.obtenerCodigoSerie)) {
      print("La serie con codigo ${serie.obtenerCodigoSerie} ya existe");
      return;
    }
    _series[serie.obtenerCodigoSerie] = serie;
    print("Serie creada");
    notifyListeners();
  }

  Map<String, Serie> get obtenerListaSeries {
    return _series;
  }

  void agregarSubSerie(String codigoSerie, List<SubSerie> subSerie) {
    Serie? serie = _series[codigoSerie];

    if (serie == null) {
      print("La serie con codigo $codigoSerie no existe");
      return;
    }

    for (var buscarSubSerie in subSerie) {
      if (serie.obtenerMapSubSerie.containsKey(buscarSubSerie.obtenerCodigoSubSerie)) {
        print("La SubSerie con codigo ${buscarSubSerie.obtenerCodigoSubSerie} ya existe");
      } else {
        serie.agregarSubSerie(buscarSubSerie);
        print("SubSerie ${buscarSubSerie.obtenerCodigoSubSerie} agregada correctamente");
      }
    }
    notifyListeners();
  }

  void agregarTipoDocuemental(
    String codigoSerie,
    String codigoSubSerie,
    TipoDocuemental nombreTipoDocumental,
  ) {
    Serie? serie = _series[codigoSerie];

    if (serie == null) {
      print("La serie con codigo $codigoSerie no existe");
      return;
    }

    SubSerie? subSerie = serie.obtenerMapSubSerie[codigoSubSerie];

    if (subSerie == null) {
      print("La SubSerie con codigo ${codigoSubSerie} no existe en la Serie $codigoSerie");
      return;
    }

    subSerie.agregarTipoDocumental(nombreTipoDocumental);
    notifyListeners();
  }

  void mostrar() {
    print("\n📂 **Tabla de Retención Documental:**");
    if (_series.isEmpty) {
      print("No hay serie registradas");
      return;
    }

    _series.forEach((codigoSerie, serie) {
      print(
        "Codigo Serie: ${serie.obtenerCodigoSerie} (Descripcion: ${serie.obtenerDescripcionSerie})",
      );

      serie.obtenerMapSubSerie.forEach((codigoSubSerie, subserie) {
        print(
          "Codigo subSerie: ${subserie.obtenerCodigoSubSerie} (Descripcion: ${subserie.obtenerDescripcionSubSerie})",
        );

        for (var tipoDoc in subserie.obtenerListaTipoDocumentales) {
          print("Tipo documental: ${tipoDoc.obtenerNombreTipoDocumental}");
        }
      });
    });
  }
}
