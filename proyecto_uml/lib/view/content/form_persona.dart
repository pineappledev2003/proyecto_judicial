import 'package:flutter/material.dart';
import 'package:proyecto_uml/view/custom_widgets/boxlist.dart';
import 'package:proyecto_uml/view/custom_widgets/button.dart';
import 'package:proyecto_uml/view/custom_widgets/input.dart';
import 'package:proyecto_uml/utils/notification.dart';


class FormPersona extends StatefulWidget {
  final String title;

  const FormPersona({super.key, required this.title});

  @override
  _FormPersonaState createState() => _FormPersonaState();
}

class _FormPersonaState extends State<FormPersona> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  void _handleSubmit() {
    Notificacion.mostrar("Registro guardado correctamente");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400, 
      height: 350,  
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, 
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
                      items: ['Opción 1', 'Opción 2', 'Opción 3'],
                      hint: 'Tipo de documento',
                      onChanged: (value) {
                        print('Seleccionaste: $value');
                      },
                    ),
                  ),
                ),
                CustomInput(label: "Número", controller: _numeroController),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: BoxList(
                      items: ['Parte A', 'Parte B'],
                      hint: 'Parte procesal',
                      onChanged: (value) {
                        print('Seleccionaste: $value');
                      },
                    ),
                  ),
                ),
              ],
            ),
            CustomInput(label: "Nombre", controller: _nombreController),
            SizedBox(height: 10),
            CustomButton(text: "Registrar", onPressed: _handleSubmit),
          ],
        ),
      ),
    );
  }

}