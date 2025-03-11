import 'package:flutter/material.dart';
import 'package:proyecto_uml/view/content/form_persona.dart';
import 'package:proyecto_uml/view/custom_widgets/boxlist.dart';
import 'package:proyecto_uml/view/custom_widgets/button.dart';
import 'package:proyecto_uml/view/custom_widgets/input.dart';
import 'package:proyecto_uml/utils/notification.dart';


class FormExpediente extends StatefulWidget {
  final String title;

  const FormExpediente({super.key, required this.title});

  @override
  _FormExpedienteState createState() => _FormExpedienteState();
}

class _FormExpedienteState extends State<FormExpediente> {
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();

  void _handleSubmit() {
    Notificacion.mostrar("Registro guardado correctamente");
  }

  void _handlePersonas() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 300,
            width:500,
            child: FormPersona(title: "Registro de personas"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cerrar"),
            ),
          ],
        );
      },
    );
  }

bool _expfisico = false; 
bool _docfisico = false;

@override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.title, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        SizedBox(height: 20.0),
        CustomInput(label: "Número de radicado", controller: _categoriaController),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: BoxList(
                  items: ['Opción 1', 'Opción 2', 'Opción 3'],
                  hint: 'Despacho Judicial',
                  onChanged: (value) {
                    print('Seleccionaste: $value');
                  },
                ),
              ),
            ),
            CustomButton(text: "Personas", onPressed: _handlePersonas),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: BoxList(
                  items: ['Opción 1', 'Opción 2', 'Opción 3'],
                  hint: 'Serie',
                  onChanged: (value) {
                    print('Seleccionaste: $value');
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: BoxList(
                  items: ['Opción 1', 'Opción 2', 'Opción 3'],
                  hint: 'Subserie',
                  onChanged: (value) {
                    print('Seleccionaste: $value');
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("¿Expediente físico?", style: TextStyle(fontSize: 16)),
            SizedBox(width: 10),
            Switch(
              activeColor: Colors.indigo,
              value: _expfisico,
              onChanged: (value) {
                setState(() {
                  _expfisico = value;
                });
              },
            ),
            Text("¿Documento físico?", style: TextStyle(fontSize: 16)),
            SizedBox(width: 10),
            Switch(
              activeColor: Colors.indigo,
              value: _docfisico,
              onChanged: (value) {
                setState(() {
                  _docfisico = value;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 20.0),
        CustomButton(text: "Registrar", onPressed: _handleSubmit),
      ],
    ),
  );
}
}