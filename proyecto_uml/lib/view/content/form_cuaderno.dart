import 'package:flutter/material.dart';
import 'package:proyecto_uml/models/cuaderno.dart';
import 'package:proyecto_uml/models/documentos.dart';
import 'package:proyecto_uml/models/expediente.dart';

class FormDocumentosCuaderno extends StatefulWidget {
  final String title;
  final Cuaderno cuaderno;
  final Expediente expediente;
  const FormDocumentosCuaderno({
    super.key,
    required this.title,
    required this.cuaderno,
    required this.expediente,
  });

  @override
  FormDocumentosCuadernoState createState() => FormDocumentosCuadernoState();
}

class FormDocumentosCuadernoState extends State<FormDocumentosCuaderno> {

  @override
  Widget build(BuildContext context) {
    List<Documentos> documentos = widget.cuaderno.obtenerDocumentos();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            "Datos Expediente",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
          DataTable(
            border: TableBorder.all(color: Colors.grey),
            dataRowMinHeight: 50, // Altura mínima de la fila
            dataRowMaxHeight: double.infinity, // Permite expansión ilimitada
            columns: [
              DataColumn(label: Text('Radicado')),
              DataColumn(label: Text('Despacho')),
              DataColumn(label: Text('Serie')),
              DataColumn(label: Text('SubSerie')),
              DataColumn(label: Text('Demandado(s)')),
              DataColumn(label: Text('Demandante(s)')),
              DataColumn(label: Text('Cuadernos')),
              DataColumn(label: Text('Exp. Físico')),
              DataColumn(label: Text('Doc. Físico')),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(Text(widget.expediente.obtenerNumeroRadicacionProceso)),
                  DataCell(Text(widget.expediente.obtenerDespachoJudicial.obtenerNombreDespacho)),
                  DataCell(Text(widget.expediente.obtenerSerie.obtenerDescripcionSerie)),
                  DataCell(Text(widget.expediente.obtenerSubSerie.obtenerDescripcionSubSerie)),
                  DataCell(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          widget.expediente.obtenerPersonaTipoA.map((persona) {
                            return Text("- ${persona.obtenerNombrePersona}");
                          }).toList(),
                    ),
                  ),

                  DataCell(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          widget.expediente.obtenerPersonaTipoB.map((persona) {
                            return Text("- ${persona.obtenerNombrePersona}");
                          }).toList(),
                    ),
                  ),

                  DataCell(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          widget.expediente.obtenerListaCuaderno.values.map((cuaderno) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "- ${cuaderno.obtenerNombreCuaderno}: ${cuaderno.obtenerDescripcion}",
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                    ),
                  ),

                  DataCell(Text(widget.expediente.obtenerExpedienteFisico ? 'Sí' : 'No')),
                  DataCell(Text(widget.expediente.obtenerDocumentoFisico ? 'Sí' : 'No')),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          documentos.isEmpty
              ? Center(
                child: Text(
                  "No Hay Documento",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
              )
              : Expanded(
                child: ListView.builder(
                  itemCount: documentos.length,
                  itemBuilder: (context, index) {
                    final doc = documentos[index];
                    return DataTable(
                      border: TableBorder.all(color: Colors.grey),
                      columns: [
                        DataColumn(label: Text('Tipo Documental')),
                        DataColumn(label: Text('Fecha Creación')),
                        DataColumn(label: Text('Fecha Incorporación')),
                        DataColumn(label: Text('Orden')),
                        DataColumn(label: Text('Páginas')),
                        DataColumn(label: Text('Formato')),
                        DataColumn(label: Text('Tamaño')),
                        DataColumn(label: Text('Origen')),
                        DataColumn(label: Text('Observaciones')),
                      ],
                      rows: [
                       DataRow(
                        cells: [
                        DataCell(Text(doc.obtenernombreDocumento.obtenerTipoDocumental)),
                        DataCell(Text("${doc.obtenerfechaCreacionDocumento}")),
                        DataCell(Text("${doc.obtenerfechaIncorporacionExpediente}")),
                        DataCell(Text("${doc.obtenerOrdenDocumento}")),
                        DataCell(Text("${doc.obtenerpaginaInicio} - ${doc.obtenerpaginaFin}")),
                        DataCell(Text(doc.obtenerformato)),
                        DataCell(Text(doc.obtenertamano)),
                        DataCell(Text(doc.obtenerorigen)),
                        DataCell(Text(doc.obtenerobservaciones)),
                       ])
                      ],
                    );
                  },
                ),
              ),
        ],
      ),
    );
  }
}
