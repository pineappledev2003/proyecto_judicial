import 'package:flutter/cupertino.dart';
import 'package:proyecto_uml/models/cuaderno.dart';
import 'package:proyecto_uml/models/documentos.dart';
import 'package:proyecto_uml/models/tipo_documental.dart';


class DocumentosControllerList extends ChangeNotifier {
  List<Documentos> _documentoRegistrados = [];

  void agregarDocumento({
    TipoDocumental? tipoDocumento,
    DateTime? fechaIncorporacionExpediente,
    DateTime? fechaCreacionDocumento,
    int? ordenDocumento,
    int? numeroPaginas,
    int? paginaInicio,
    int? paginaFin,
    String? formato,
    String? tamano,
    String? origen,
    Cuaderno? cuaderno,
    String? observaciones,
  }) {
    Documentos nuevoDocumento = Documentos(
      nombreDocumento: tipoDocumento!,
      fechaIncorporacionExpediente: fechaIncorporacionExpediente!,
      fechaCreacionDocumento: fechaCreacionDocumento!,
      ordenDocumentos: ordenDocumento!,
      numeroPaginas: numeroPaginas!,
      paginaInicio: paginaInicio!,
      paginaFin: paginaFin!,
      formato: formato!,
      tamano: tamano!,
      origen: origen!,
      cuaderno: cuaderno!,
      observaciones: observaciones!,
    );

    _documentoRegistrados.add(nuevoDocumento);
  }

  List<Documentos> obtenerDocumentosDeExpediente() {
    return _documentoRegistrados;
  }

  
}