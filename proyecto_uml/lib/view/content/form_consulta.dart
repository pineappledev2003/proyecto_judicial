import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_uml/controllers/expediente/expediente_controller_list.dart';
import 'package:proyecto_uml/models/expediente.dart';
import 'package:proyecto_uml/view/content/form_cuaderno.dart';
import 'package:proyecto_uml/view/content/form_documento.dart';
import 'package:proyecto_uml/view/custom_widgets/button.dart';
import 'package:proyecto_uml/view/custom_widgets/input.dart';
import 'package:validatorless/validatorless.dart';

class FormConsulta extends StatefulWidget {
  final String title;

  const FormConsulta({super.key, required this.title});

  @override
  FormConsultaState createState() => FormConsultaState();
}

class FormConsultaState extends State<FormConsulta> {
  final _formKey = GlobalKey<FormState>();
  String? _numeroRadicacion;
  List<Expediente> _expedienteFiltrado = [];

  @override
  void initState() {
    super.initState();
    _expedienteFiltrado = [];
  }


  @override
  Widget build(BuildContext context) {
    final ControllerExpedienteList _controllerExpedienteList =
        Provider.of<ControllerExpedienteList>(context);
    List<Expediente> _expedientes = _controllerExpedienteList.obtenerListaExpediente();

    return Container(
      width: 400,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomInput(
                    label: "N° de Expediente",
                    onSaved: (value) {
                      _numeroRadicacion = value;
                    },
                    validator: Validatorless.multiple([
                      Validatorless.required("Este campo es requerido"),
                    ]),
                    onChanged: (value) {
                      setState(() {
                        _numeroRadicacion = value;
                        _expedienteFiltrado =
                            _expedientes.where((expediente) {
                              return expediente.obtenerNumeroRadicacionProceso.contains(value);
                            }).toList();
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                CustomButton(
                  text: "Buscar",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      setState(() {
                        // Si se hace clic en Buscar, se filtra según el número de radicación
                        _expedienteFiltrado =
                            _expedientes.where((expediente) {
                              return expediente.obtenerNumeroRadicacionProceso.contains(
                                _numeroRadicacion!,
                              );
                            }).toList();
                      });
                    }
                  },
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                itemCount:
                    _expedienteFiltrado.isEmpty
                        ? _expedientes.length
                        : _expedienteFiltrado.length, // Muestra todos si no hay filtro
                itemBuilder: (BuildContext context, int index) {
                  final expedienteIndex =
                      _expedienteFiltrado.isEmpty
                          ? _expedientes[index] // Si no hay filtro, mostrar todo
                          : _expedienteFiltrado[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: DataTable(
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
                            DataCell(Text(expedienteIndex.obtenerNumeroRadicacionProceso)),
                            DataCell(
                              Text(expedienteIndex.obtenerDespachoJudicial.obtenerNombreDespacho),
                            ),
                            DataCell(Text(expedienteIndex.obtenerSerie.obtenerDescripcionSerie)),
                            DataCell(
                              Text(expedienteIndex.obtenerSubSerie.obtenerDescripcionSubSerie),
                            ),
                            DataCell(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    expedienteIndex.obtenerPersonaTipoA.map((persona) {
                                      return Text("- ${persona.obtenerNombrePersona}");
                                    }).toList(),
                              ),
                            ),
                  
                            DataCell(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    expedienteIndex.obtenerPersonaTipoB.map((persona) {
                                      return Text("- ${persona.obtenerNombrePersona}");
                                    }).toList(),
                              ),
                            ),
                  
                            DataCell(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    expedienteIndex.obtenerListaCuaderno.values.map((cuaderno) {
                                      return Row(
                                        children: [
                                          Text(
                                            "- ${cuaderno.obtenerNombreCuaderno}: ${cuaderno.obtenerDescripcion}",
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.visibility),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) => FormDocumentosCuaderno(
                                                        title: "Visualizar Documentos",
                                                        expediente: expedienteIndex,
                                                        cuaderno: cuaderno,
                                                      ),
                                                ),
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.upload_file),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) => FormDocumento(
                                                        title: "Registar Documentos",
                                                        expediente: expedienteIndex,
                                                      ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    }).toList(),
                              ),
                            ),
                  
                            DataCell(Text(expedienteIndex.obtenerExpedienteFisico ? 'Sí' : 'No')),
                            DataCell(Text(expedienteIndex.obtenerDocumentoFisico ? 'Sí' : 'No')),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
