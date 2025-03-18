import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_uml/controllers/persona/persona_controller_list.dart';
import 'package:proyecto_uml/utils/notification.dart';
import 'package:proyecto_uml/view/custom_widgets/boxlist.dart';
import 'package:proyecto_uml/view/custom_widgets/button.dart';
import 'package:proyecto_uml/view/custom_widgets/input.dart';
import 'package:validatorless/validatorless.dart';

class FormPersona extends StatefulWidget {
  final String title;
  
  const FormPersona({super.key, required this.title});

  @override
  FormPersonaState createState() => FormPersonaState();
}

class FormPersonaState extends State<FormPersona> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedTipoDocumento;
  String? _selectedTipoPersona;
  String? _numeroDocumento;
  String? _nombrePersona;
  String? _selectedRol;
  List<String> rolesParteA = ["Demandado", "Procesado", "Accionado"];
  List<String> rolesParteB = ["Demandante", "Denunciante", "Accionante"];
  final Map<String, String> documentosPersonaNatural = {
    "Cédula de Ciudadanía (CC)": "Persona Natural",
    "Tarjeta de Identidad (TI)": "Persona Natural",
    "Registro Civil (RC)": "Persona Natural",
    "Cédula de Extranjería (CE)": "Persona Natural",
    "Pasaporte (PA)": "Persona Natural",
    "Permiso Especial de Permanencia (PEP)": "Persona Natural",
    "Salvoconducto de Permanencia (SP)": "Persona Natural",
  };
  final Map<String, String> documentosPersonaJuridica = {
    "Número de Identificación Tributaria (NIT)": "Persona Jurídica",
    "Registro Único Tributario (RUT)": "Persona Jurídica",
  };
  final Map<String, String> documentosEntidadEstado = {
    "Identificación de Entidad Pública (IEP)": "Entidad del Estado",
  };

  void _handleSubmit() {
    Notificacion.mostrar("Registro guardado correctamente");
  }

  @override
  Widget build(BuildContext context) {
    final _controllerPersonaList = Provider.of<ControllerPersonaList>(context);
    TextEditingController controllerTipoPersona = TextEditingController(text: _selectedTipoPersona);
    return SizedBox(
      width: 400,
      height: 350,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.title, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: BoxList(
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(enabled: false, child: const Text("📌 Persona Natural")),
                    ...documentosPersonaNatural.keys.map(
                      (String docPersona) =>
                          DropdownMenuItem(value: docPersona, child: Text(docPersona)),
                    ),

                    //Divider
                    DropdownMenuItem(enabled: false, child: Divider()),

                    //Divider
                    DropdownMenuItem(enabled: false, child: const Text("🏢 Persona Juridica")),
                    ...documentosPersonaJuridica.keys.map(
                      (String docJurica) =>
                          DropdownMenuItem(value: docJurica, child: Text(docJurica)),
                    ),

                    //Divider
                    DropdownMenuItem(enabled: false, child: Divider()),

                    //Divider
                    DropdownMenuItem(enabled: false, child: const Text("🏛️ Entidad del estado")),
                    ...documentosEntidadEstado.keys.map(
                      (String docEntidad) =>
                          DropdownMenuItem(value: docEntidad, child: Text(docEntidad)),
                    ),
                  ],
                  hint: 'Tipo de documento',
                  value: _selectedTipoDocumento,
                  onChanged: (value) {
                    setState(() {
                      _selectedTipoDocumento = value;
                      if (documentosPersonaNatural.containsKey(value)) {
                        _selectedTipoPersona = documentosPersonaNatural[value];
                      }
                      if (documentosPersonaJuridica.containsKey(value)) {
                        _selectedTipoPersona = documentosPersonaJuridica[value];
                      }
                      if (documentosEntidadEstado.containsKey(value)) {
                        _selectedTipoPersona = documentosEntidadEstado[value];
                      }
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Selecciona un tipo de documento";
                    }
                    return null;
                  },
                ),
              ),
              CustomInput(
                label: "NúmeroDocumento",
                maxLength: 10,
                onSaved: (value) {
                  _numeroDocumento = value;
                },
                validator: Validatorless.multiple([
                  Validatorless.required("Este campo es requerido"),
                ]),
              ),
              CustomInput(
                label: "Nombre",
                onSaved: (value) {
                  _nombrePersona = value;
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BoxList(
                        items: [
                          DropdownMenuItem(enabled: false, child: const Text("📌 PARTE A")),
                          ...rolesParteA.map(
                            (String rolA) => DropdownMenuItem(value: rolA, child: Text(rolA)),
                          ),

                          //Divider
                          DropdownMenuItem(enabled: false, child: Divider()),

                          DropdownMenuItem(enabled: false, child: const Text("📌 PARTE B")),
                          ...rolesParteB.map(
                            (String rolB) => DropdownMenuItem(value: rolB, child: Text(rolB)),
                          ),
                        ],
                        value: _selectedRol,
                        hint: 'Roles',
                        onChanged: (value) {
                          setState(() {
                            _selectedRol = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Selecciona un Rol";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomInput(
                      label: "Tipo de Persona",
                      controller: controllerTipoPersona,
                      readOnly: true,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              CustomButton(
                text: "Registrar",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    try {
                      _controllerPersonaList.registarPersona(
                        _selectedTipoDocumento!,
                        _numeroDocumento!,
                        _nombrePersona!,
                        _selectedRol!,
                        _selectedTipoPersona!,
                      );

                      _handleSubmit();

                      for (var buscarPersona in _controllerPersonaList.obtenerPersona()) {
                        print("Tipo documento: ${buscarPersona.obtenerTipoDocumento}");
                        print("Numero Documento: ${buscarPersona.obtenerNumeroDocumento}");
                        print("Nombre Persona: ${buscarPersona.obtenerNombrePersona}");
                        print("Rol: ${buscarPersona.obtenerRol}");
                        print("Tipo Persona: ${buscarPersona.obtenerTipoPersona}");
                      }

                      _formKey.currentState!.reset();

                      setState(() {
                        _selectedTipoDocumento = null;
                        _selectedRol = null;
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
          ),
        ),
      ),
    );
  }
}
