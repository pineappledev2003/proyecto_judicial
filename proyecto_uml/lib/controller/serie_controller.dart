import 'package:proyecto_uml/models/serie.dart';
import 'package:proyecto_uml/models/sub_serie.dart';
import 'package:proyecto_uml/models/tipo_documental.dart';

class SerieController {
  final List<Serie> _series = [];

  SerieController() {
    _inicializarSeriesPredefinidas();
  }

  void _inicializarSeriesPredefinidas() {
    // Esta es la serie 1
    Serie accionesConstitucionales = Serie(codigo: "05", descripcion: "ACCIONES CONSTITUCIONALES");

    // Estas son las subSeries de la serie 1

    SubSerie accionesHabeasCorpus = SubSerie(
      codigo: "15",
      descripcion: "ACCIONES DE HABEAS CORPUS",
    );
    SubSerie accionesTutela = SubSerie(codigo: "25", descripcion: "ACCIONES DE TUTELA");

    //Agregamos las dos subseries a la serie 1

    accionesConstitucionales.agregarSubserie(accionesHabeasCorpus);
    accionesConstitucionales.agregarSubserie(accionesTutela);

    // Esta es la serie 2

    Serie expedientesProcesoJudiciales = Serie(
      codigo: "270",
      descripcion: "EXPEDIENTES DE PROCESO JUDICIALES",
    );

    // Esta es la subSerie de la serie 2

    SubSerie expedientesDeProcesoJudicialesPenalesLey906De2004 = SubSerie(
      codigo: "245",
      descripcion: "EXPEDINTES DE PROCESOS JUDICIALES PENALES LEY 906 DE 2004",
    );

    // Agregamos la subserie a la serie 2

    expedientesProcesoJudiciales.agregarSubserie(expedientesDeProcesoJudicialesPenalesLey906De2004);

    _series.add(accionesConstitucionales);
    _series.add(expedientesProcesoJudiciales);
  }

  Serie? obtenerSerieExistente(String codigoSerie) {
    // Utilizamos `firstWhere` y nos aseguramos que se maneje correctamente con `null`
    try {
      return _series.firstWhere((serie) => serie.obtenerCodigo == codigoSerie);
    } catch (e) {
      return null; // Si no se encuentra la serie, retorna null
    }
  }

  void agregarTipoDocumentalAUnaSubserie(
    String codigoSerie,
    String codigoSubSerie,
    TipoDocumental tipoDocumental,
  ) {
    Serie? serieExistente = obtenerSerieExistente(codigoSerie);

    if (serieExistente != null) {
      SubSerie? subSerieExistente = serieExistente.obtenerSubseriePorCodigo(codigoSubSerie);

      if (subSerieExistente != null) {
        subSerieExistente.agregarTipoDocumental(tipoDocumental);
      } else {
        print("Subserie no encontrada");
      }
    } else {
      print("Serie no encontrada");
    }
  }

  void agregarSerieConSubserie(
    String codigoSerie,
    String descripcionSerie,
    List<SubSerie> subseries,
  ) {
    // Buscar la serie existente
    Serie? serieExistente = obtenerSerieExistente(codigoSerie);

    if (serieExistente != null) {
      // Si la serie existe, agregamos las subseries solo si no están duplicadas
      for (var subserie in subseries) {
        // Verificar si la subserie ya existe
        if (!serieExistente.contieneSubserie(subserie)) {
          serieExistente.agregarSubserie(subserie);
        }
      }
    } else {
      // Si la serie no existe, creamos una nueva
      Serie nuevaSerie = Serie(codigo: codigoSerie, descripcion: descripcionSerie);

      // Agregamos las subseries a la nueva serie solo si no están duplicadas
      for (var subserie in subseries) {
        if (!nuevaSerie.contieneSubserie(subserie)) {
          nuevaSerie.agregarSubserie(subserie);
        }
      }

      // Agregamos la nueva serie a la lista
      _series.add(nuevaSerie);
    }
  }

  void mostrarSeries() {
    for (var serie in _series) {
      print('Serie: ${serie.obtenerCodigo} - ${serie.obtenerDescripicion}');
      serie.mostarSubSerie();
    }
  }
}
