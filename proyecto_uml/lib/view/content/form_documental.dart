import 'package:flutter/material.dart';
import 'package:proyecto_uml/controllers/retencion_documental/retencion_documental_controller_list.dart';
import 'package:proyecto_uml/controllers/retencion_documental/retencion_documental_controller_map.dart';
import 'package:proyecto_uml/models/serie.dart';
import 'package:proyecto_uml/models/subserie.dart';
import 'package:proyecto_uml/models/tipo_documental.dart';
import 'package:proyecto_uml/utils/notification.dart';
import 'package:proyecto_uml/view/custom_widgets/boxlist.dart';
import 'package:proyecto_uml/view/custom_widgets/button.dart';
import 'package:proyecto_uml/view/custom_widgets/input.dart';
import 'package:proyecto_uml/widgets/counter_controls.dart';
import 'package:validatorless/validatorless.dart';

class FormDocumental extends StatefulWidget {
  final String title;
  final dynamic controladorRetencionDocumental;

  const FormDocumental({
    super.key,
    required this.title,
    required this.controladorRetencionDocumental,
  });

  @override
  FormDocumentalState createState() => FormDocumentalState();
}

class FormDocumentalState extends State<FormDocumental> {
  final _formKey = GlobalKey<FormState>();
  Serie? _seleccionarCodigoSerie;
  SubSerie? _seleccionarCodigoSubSerie;

  List<Serie> _codigoSerieList = [];
  List<SubSerie> _codigoSubSerieList = [];

  List<String>? _tipoDocumental = [];
  List<TextEditingController> _tipoDocumentalControllers = [];
  List<TipoDocumental> _tipoDocumentaleTemporales = [];

  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = 1;
    _tipoDocumentalControllers.add(TextEditingController());
  }

  void _handleSubmit() {
    Notificacion.mostrar("Registro guardado correctamente");
  }

  @override
  Widget build(BuildContext context) {

    switch (widget.controladorRetencionDocumental) {
      case RetencionDocumentalControllerList controlador:
        _codigoSerieList = controlador.obtenerListaSerieEnLista;
        break;
      case RetencionDocumentalMapaController controlador:
        _codigoSerieList = controlador.obtenerListaSerieEnMapa.values.toList();
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.title, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: BoxList(
                      items:
                          _codigoSerieList.map((serie) {
                            return DropdownMenuItem(
                              value: serie,
                              child: Text(
                                "Codigo: ${serie.obtenerCodigoSerie} - Descripcion: ${serie.obtenerDescripcionSerie}",
                              ),
                            );
                          }).toList(),
                      hint: 'Serie',
                      value: _seleccionarCodigoSerie,
                      onChanged: (value) {
                        setState(() {
                          _seleccionarCodigoSerie = value;
                          _codigoSubSerieList =
                              _seleccionarCodigoSerie?.obtenerSubSerie.values.toList() ?? [];
                          _seleccionarCodigoSubSerie = null;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: BoxList(
                      items:
                          _codigoSubSerieList.map((subserie) {
                            return DropdownMenuItem(
                              value: subserie,
                              child: Text(
                                "Codigo: ${subserie.obtenerCodigoSubSerie} - Descripcion: ${subserie.obtenerDescripcionSubSerie}",
                              ),
                            );
                          }).toList(),
                      hint: 'Subserie',
                      value: _seleccionarCodigoSubSerie,
                      onChanged: (value) {
                        setState(() {
                          _seleccionarCodigoSubSerie = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (_seleccionarCodigoSerie != null && _seleccionarCodigoSubSerie != null) ...[
              counterControles(increment, decrement, refresh),
              Text(
                "Nombres Tipo Documentales",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: count,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        SizedBox(height: 20.0),

                        CustomInput(
                          label: "Nombre",
                          controller: _tipoDocumentalControllers[index],
                          validator: Validatorless.multiple([
                            Validatorless.required("Este campo es requerido"),
                            Validatorless.regex(
                              RegExp(r'^[a-zA-Z\s]+$'),
                              "Solo se permiten letras y espacios",
                            ),
                          ]),
                        ),
                      ],
                    );
                  },
                ),
              ),
              CustomButton(
                text: "Registrar",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    try {
                      _tipoDocumental!.clear();

                      for (var i = 0; i < count; i++) {
                        _tipoDocumental!.add(_tipoDocumentalControllers[i].text.trim());
                      }

                      Set<String> tipoDocumentalUnicos = {};
                      for (var codigo in _tipoDocumental!) {
                        if (!tipoDocumentalUnicos.add(codigo)) {
                          Notificacion.mostrar(
                            "Error: Hay tipo documentales repetidos",
                            isError: true,
                          );
                          return;
                        }
                      }

                      setState(() {
                        _tipoDocumentaleTemporales.clear();

                        for (var i = 0; i < _tipoDocumental!.length; i++) {
                          _tipoDocumentaleTemporales.add(
                            TipoDocumental(tipoDocumental: _tipoDocumental![i]),
                          );
                        }
                      });

                      switch (widget.controladorRetencionDocumental) {
                        case RetencionDocumentalControllerList controlador:
                          controlador.agregarTipoDocumental(
                            _seleccionarCodigoSerie!.obtenerCodigoSerie,
                            _seleccionarCodigoSubSerie!.obtenerCodigoSubSerie,
                            _tipoDocumentaleTemporales,
                          );
                          controlador.mostrarListadoList();
                          _handleSubmit();
                          break;
                        case RetencionDocumentalMapaController controlador:
                          controlador.agregarTipoDocumental(
                            _seleccionarCodigoSerie!.obtenerCodigoSerie,
                            _seleccionarCodigoSubSerie!.obtenerCodigoSubSerie,
                            _tipoDocumentaleTemporales,
                          );
                          controlador.mostrarListaMap();
                          _handleSubmit();
                          break;
                      }

                      setState(() {
                        for (var controller in _tipoDocumentalControllers) {
                          controller.clear();
                        }
                      });
                    } on ArgumentError catch (e) {
                      Notificacion.mostrar("Error: ${e.message}", isError: true);
                    } catch (e) {
                      Notificacion.mostrar("Ocurrió un error inesperado: $e", isError: true);
                    }
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  void increment() {
    setState(() {
      count++;
      _tipoDocumentalControllers.add(TextEditingController());
    });
  }

  void decrement() {
    if (count > 1) {
      setState(() {
        count--;
        _tipoDocumentalControllers.removeLast();
      });
    }
  }

  void refresh() {
    setState(() {
      count = 1;
    });
  }
}
