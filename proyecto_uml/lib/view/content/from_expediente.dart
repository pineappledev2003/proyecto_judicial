import 'package:flutter/material.dart';
import 'package:proyecto_uml/view/custom_widgets/button.dart';


class FormExpediente extends StatelessWidget {
  final Map<String, dynamic> expediente;

  const FormExpediente({super.key, required this.expediente});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle del Expediente")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DataTable(
              columns: const [
                DataColumn(label: Text("Número de Radicado")),
                DataColumn(label: Text("Serie")),
                DataColumn(label: Text("Subserie")),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text(expediente['numeroRadicado'].toString())),
                  DataCell(Text(expediente['serie'] ?? "N/A")),
                  DataCell(Text(expediente['subserie'] ?? "N/A")),
                ]),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(text: "Ingresar cuadernos", onPressed: (){}),
                CustomButton(text: "Ingresar documentos", onPressed: (){}),
                CustomButton(text: "Descargar EXCEL", onPressed: (){})
              ],
            ),
            const SizedBox(height: 20),
            const Text("Documentos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text("Nombre del Documento")),
                  ],
                  rows: expediente['documentos'].map<DataRow>((doc) {
                    return DataRow(cells: [
                      DataCell(Text(doc['nombre'] ?? "Sin nombre")),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
