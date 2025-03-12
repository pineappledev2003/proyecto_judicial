import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_uml/controller/controller_persona.dart';
import 'package:validatorless/validatorless.dart';

class RegistarPersona extends StatefulWidget {
  const RegistarPersona({super.key});

  @override
  State<RegistarPersona> createState() => _RegistarPersonaState();
}

class _RegistarPersonaState extends State<RegistarPersona> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedTipoDocumento;
  String? _numeroDocumento;
  String? _nombrePersona;
  String? _selectedRol;
  String? _selectedTipoPersona;
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

  @override
  Widget build(BuildContext context) {
    final controllerPersona = Provider.of<ControllerPersona>(context);
    TextEditingController controllerTipoPersona = TextEditingController(text: _selectedTipoPersona);
    return Scaffold(
      appBar: AppBar(title: const Text("REGISTAR PERSONA"), centerTitle: true),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField(
              isExpanded: true,
              value: _selectedTipoDocumento,
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
                  (String docJurica) => DropdownMenuItem(value: docJurica, child: Text(docJurica)),
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
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(label: Text("INGRESAR EL NUMERO DOCUMENTO")),
              keyboardType: TextInputType.text,
              maxLength: 15,
              onSaved: (newValue) {
                _numeroDocumento = newValue;
              },
              validator: Validatorless.multiple([
                Validatorless.required("Este campo es requerido"),
              ]),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(label: Text("INGRESAR EL NOMBRE")),
              keyboardType: TextInputType.text,
              maxLength: 15,
              onSaved: (newValue) {
                _nombrePersona = newValue;
              },
              validator: Validatorless.multiple([
                Validatorless.required("Este campo es requerido"),
              ]),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              value: _selectedRol,
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
              // rolesParteA.map((String rol) {
              //       return DropdownMenuItem(value: rol, child: Text(rol));
              //     }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRol = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: "Tipo de Persona"),
              controller: controllerTipoPersona,
              enabled: false,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  controllerPersona.registarPersona(
                    _selectedTipoDocumento!,
                    _numeroDocumento!,
                    _nombrePersona!,
                    _selectedRol!,
                    _selectedTipoPersona!,
                  );

                  for (var buscarPersona in controllerPersona.obtenerPersona()) {
                    print("Tipo documento: ${buscarPersona.obtenerTipoDocumento}");
                    print("Numero Documento: ${buscarPersona.obtenerNumeroDocumento}");
                    print("Nombre Persona: ${buscarPersona.obtenerNombrePersona}");
                    print("Rol: ${buscarPersona.obtenerRol}");
                    print("Tipo Persona: ${buscarPersona.obtenerTipoPersona}");
                  }
                }
              },
              child: const Text("REGISTRAR"),
            ),
          ],
        ),
      ),
    );
  }
}
