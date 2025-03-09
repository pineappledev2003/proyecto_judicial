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
          title: Text("Registro de personas"),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 300,
              maxWidth: 500,
              minHeight: 300,
              maxHeight: 600,
            ),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.title, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          SizedBox(height: 20.0,),
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
          Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BoxList(
                    items: ['Opción 1', 'Opción 2', 'Opción 3'],
                    hint: 'Tipo documental',
                    onChanged: (value) {
                      print('Seleccionaste: $value');
                    },
                  ),
                ),
              ),
          
          CustomButton(text: "Registrar", onPressed: _handleSubmit),
        ],
      ),
    );
  }
}