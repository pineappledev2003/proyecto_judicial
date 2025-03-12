import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_uml/controller/controller_retencion_documental.dart';
import 'package:proyecto_uml/models/serie.dart';
import 'package:proyecto_uml/models/subserie.dart';
import 'package:proyecto_uml/models/tipo_docuemental.dart';
import 'package:validatorless/validatorless.dart';

class RegistrarTipoDocumental extends StatefulWidget {
  const RegistrarTipoDocumental({super.key});

  @override
  State<RegistrarTipoDocumental> createState() => _RegistrarTipoDocumentalState();
}

class _RegistrarTipoDocumentalState extends State<RegistrarTipoDocumental> {
  final _formKey = GlobalKey<FormState>();
  Serie? _SeleccionarcodigoSerie;
  SubSerie? _SeleccionarcodigoSubSerie;

  List<Serie> _codigoSerie = [];
  List<SubSerie> _codigoSubSerie = [];

  String? _tipoDocumental;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ControllerRetencionDocumental>(context);

    _codigoSerie = controller.obtenerListaSeries.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text("REGISTAR TIPO DOCUMENTAL"), centerTitle: true),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            if (_codigoSerie.isEmpty) ...[
              Text("No hay series registradas"),
            ] else ...[
              DropdownButton<Serie>(
                hint: Text("Seleccione codigo serie"),
                value: _SeleccionarcodigoSerie,
                items:
                    _codigoSerie.map((Serie serie) {
                      return DropdownMenuItem(
                        value: serie,
                        child: Text(
                          "Codigo: ${serie.obtenerCodigoSerie} - Descripcion: ${serie.obtenerDescripcionSerie}",
                        ),
                      );
                    }).toList(),

                onChanged: (newValue) {
                  setState(() {
                    _SeleccionarcodigoSerie = newValue!;
                    _codigoSubSerie = _SeleccionarcodigoSerie!.obtenerMapSubSerie.values.toList();
                  });
                },
              ),
              if (_SeleccionarcodigoSerie != null) ...[
                if (_codigoSubSerie.isEmpty) ...[
                  const Text("No hay subseries registradas para esta serie"),
                ] else ...[
                  DropdownButton<SubSerie>(
                    hint: Text("Seleccione codigo serie"),
                    value: _SeleccionarcodigoSubSerie,
                    items:
                        _codigoSubSerie.map((SubSerie subSerie) {
                          return DropdownMenuItem(
                            value: subSerie,
                            child: Text(
                              "Codigo: ${subSerie.obtenerCodigoSubSerie} - Descripcion: ${subSerie.obtenerDescripcionSubSerie}",
                            ),
                          );
                        }).toList(),

                    onChanged: (newValue) {
                      setState(() {
                        _SeleccionarcodigoSubSerie = newValue!;
                      });
                    },
                  ),

                  if (_SeleccionarcodigoSubSerie != null) ...[
                    TextFormField(
                      decoration: InputDecoration(label: Text("INGRESAR EL TIPO DOCUMENTAL")),
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) {
                        _tipoDocumental = newValue;
                      },
                      validator: Validatorless.multiple([
                        Validatorless.required("Este campo es requerido"),
                      ]),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          TipoDocuemental nuevoTipoDocumental = TipoDocuemental(
                            nombreTipoDocumental: _tipoDocumental!,
                          );

                          controller.agregarTipoDocuemental(
                            _SeleccionarcodigoSerie!.obtenerCodigoSerie,
                            _SeleccionarcodigoSubSerie!.obtenerCodigoSubSerie,
                            nuevoTipoDocumental,
                          );

                          controller.mostrar();
                        }
                      },
                      child: const Text("REGISTAR TIPO DOCUMENTAL"),
                    ),
                  ],
                ],
              ],
            ],
          ],
        ),
      ),
    );
  }
}
