import 'package:flutter/material.dart';
import 'package:proyecto_uml/models/cuaderno.dart';
import 'package:proyecto_uml/models/documentos.dart';
import 'package:proyecto_uml/models/expediente.dart';
import 'package:proyecto_uml/models/tipo_documental.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_uml/utils/notification.dart';
import 'package:proyecto_uml/view/custom_widgets/boxlist.dart';
import 'package:proyecto_uml/view/custom_widgets/button.dart';
import 'package:proyecto_uml/view/custom_widgets/input.dart';
import 'package:validatorless/validatorless.dart';

class FormDocumento extends StatefulWidget {
  final String? title;
  final Expediente expediente;
  const FormDocumento({super.key, this.title, required this.expediente});

  @override
  FormDocumentoState createState() => FormDocumentoState();
}

class FormDocumentoState extends State<FormDocumento> {
  final _formKey = GlobalKey<FormState>();
  TipoDocumental? _tipoDocumentos;
  DateTime? _fechaIncorporacionExpediente;
  int? _ordenDocumento;
  int? _numeroPaginas;
  int? _paginaInicio;
  int? _paginaFin;
  String? _selectedFormato;
  String? _tamano;
  String? _selectedOrigen;
  String? _observaciones;

  List<TipoDocumental> _tiposDocumentales = [];
  final TextEditingController _fechaIncorporacionController = TextEditingController();

  List<Cuaderno> _cuadernosLista = [];
  Cuaderno? _cuadernoSeleccionado;
  TextEditingController _fechaController = TextEditingController();

  void _handleSubmit() {
    Notificacion.mostrar("Registro guardado correctamente");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tiposDocumentales = widget.expediente.obtenerTiposDocumentales();
    _cuadernosLista = widget.expediente.obtenerCuadernos();
    _fechaIncorporacionExpediente = DateTime.now();
    _fechaIncorporacionController.text = DateFormat(
      "dd/MM/yyyy",
    ).format(_fechaIncorporacionExpediente!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title!,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
              child: Row(
                children: [
                  Expanded(
                    child: BoxList(
                      items:
                          _tiposDocumentales.map((tipo) {
                            return DropdownMenuItem(
                              value: tipo, // Aquí asignamos el objeto completo, no solo el string
                              child: Text(tipo.obtenerTipoDocumental),
                            );
                          }).toList(),
                      hint: 'Nombre - Tipo documental',
                      value: _tipoDocumentos,
                      onChanged: (value) {
                        setState(() {
                          _tipoDocumentos = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 0),
              child: BoxList(
                items:
                    _cuadernosLista.map((cuaderno) {
                      return DropdownMenuItem(
                        value: cuaderno,
                        child: Text(
                          "${cuaderno.obtenerNombreCuaderno} -- ${cuaderno.obtenerDescripcion}",
                        ),
                      );
                    }).toList(),
                hint: 'Cuaderno',
                value: _cuadernoSeleccionado,
                onChanged: (value) {
                  setState(() {
                    _cuadernoSeleccionado = value;
                    _actualizarOrdenDocumento();
                    _calcularPaginaInicio();
                  });
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomInput(
                    label: "Fecha de Incorporación",
                    controller: _fechaIncorporacionController,
                    readOnly: true,
                  ),
                ),
                Expanded(
                  child: CustomInput(
                    label: "Fecha de Creación",
                    controller: _fechaController,
                    filled: true,
                    readOnly: true,
                    onTap: () {
                      _selectData();
                    },
                    validator: Validatorless.multiple([
                      Validatorless.required("Este campo es requerido"),
                    ]),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomInput(
                    label: "Orden",
                    readOnly: true,
                    controller: TextEditingController(text: _ordenDocumento?.toString() ?? ""),
                  ),
                ),
                Expanded(
                  child: CustomInput(
                    label: "N° de Páginas",
                    onChanged: (value) {
                      setState(() {
                        _numeroPaginas = int.tryParse(value);
                        _calcularPaginaFin();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CustomInput(
                    label: "Página de Inicio",
                    controller: TextEditingController(text: _paginaInicio?.toString() ?? ""),
                    readOnly: true,
                  ),
                ),

                Expanded(
                  child: CustomInput(
                    label: "Página de Fin",
                    controller: TextEditingController(text: _paginaFin?.toString() ?? ""),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: BoxList(
                    items: [
                      DropdownMenuItem(value: "PDF", child: Text("PDF")),
                      DropdownMenuItem(value: "DOCX", child: Text("DOCX")),
                      DropdownMenuItem(value: "TXT", child: Text("TXT")),
                      DropdownMenuItem(value: "JPG", child: Text("JPG")),
                    ],

                    hint: 'Formato',
                    value: _selectedFormato,
                    onChanged: (value) {
                      setState(() {
                        _selectedFormato = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CustomInput(
                    label: "Tamaño (MB / KB)",
                    onSaved: (value) {
                      _tamano = value;
                    },
                    validator: Validatorless.multiple([
                      Validatorless.required("Este campo es requerido"),
                    ]),
                  ),
                ),
                Expanded(
                  child: BoxList(
                    items: [
                      DropdownMenuItem(value: "Electronico", child: Text("Electronico")),
                      DropdownMenuItem(value: "Digitalizado", child: Text("Digitalizado")),
                    ],

                    hint: 'Origen',
                    value: _selectedOrigen,
                    onChanged: (value) {
                      setState(() {
                        _selectedOrigen = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            CustomInput(
              label: "Observaciones",
              onSaved: (value) {
                _observaciones = value;
              },
            ),
            CustomButton(
              text: "Registrar",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // Crear un nuevo documento
                  Documentos nuevoDocumento = Documentos(
                    nombreDocumento: _tipoDocumentos!,
                    fechaIncorporacionExpediente: _fechaIncorporacionExpediente!,
                    fechaCreacionDocumento: DateFormat("dd/MM/yyyy").parse(_fechaController.text),
                    ordenDocumentos: _ordenDocumento!,
                    numeroPaginas: _numeroPaginas!,
                    paginaInicio: _paginaInicio!,
                    paginaFin: _paginaFin!,
                    formato: _selectedFormato!,
                    tamano: _tamano!,
                    origen: _selectedOrigen!,
                    cuaderno: _cuadernoSeleccionado!,
                    observaciones: _observaciones ?? "",
                  );

                  _cuadernoSeleccionado!.agregarDocumento(nuevoDocumento);

                  _handleSubmit();

                  _formKey.currentState!.reset();

                  setState(() {
                    _tipoDocumentos = null;
                    _fechaController.clear();
                    _ordenDocumento = null;
                    _paginaInicio = null;
                    _paginaFin = null;
                    _selectedFormato = null;
                    _selectedOrigen = null;
                    _cuadernoSeleccionado = null;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectData() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      setState(() {
        _fechaController.text = DateFormat("dd/MM/yyyy").format(_picked);
      });
    }
  }

  void _actualizarOrdenDocumento() {
    if (_cuadernoSeleccionado != null) {
      List<Documentos> documentos = _cuadernoSeleccionado!.obtenerDocumentos();

      documentos.sort(
        (a, b) =>
            a.obtenerfechaIncorporacionExpediente.compareTo(b.obtenerfechaIncorporacionExpediente),
      );

      setState(() {
        _ordenDocumento = documentos.length + 1;
      });
    }
  }

  void _calcularPaginaInicio() {
    if (_cuadernoSeleccionado != null) {
      List<Documentos> documentos = _cuadernoSeleccionado!.obtenerDocumentos();

      if (documentos.isEmpty) {
        _paginaInicio = 1;
      } else {
        Documentos ultimoDocumento = documentos.last;
        _paginaInicio = ultimoDocumento.obtenerpaginaFin + 1;
      }
    }
  }

  void _calcularPaginaFin() {
    if (_numeroPaginas != null && _paginaInicio != null) {
      _paginaFin = _paginaInicio! + _numeroPaginas! - 1;
    } else {
      _paginaFin = null;
    }
  }
}
