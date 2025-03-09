import 'package:flutter/material.dart';
import 'package:proyecto_uml/view/custom_widgets/boxlist.dart';
import 'package:proyecto_uml/view/custom_widgets/button.dart';
import 'package:proyecto_uml/view/custom_widgets/input.dart';
import 'package:proyecto_uml/utils/notification.dart';


class FormDespacho extends StatefulWidget {
  final String title;

  const FormDespacho({super.key, required this.title});

  @override
  _FormDespachoState createState() => _FormDespachoState();
}

class _FormDespachoState extends State<FormDespacho> {
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();

  void _handleSubmit() {
    Notificacion.mostrar("Registro guardado correctamente");
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
          CustomInput(label: "Código", controller: _codigoController),
          CustomInput(label: "Nombre", controller: _nombreController),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BoxList(
                    items: ['Opción 1', 'Opción 2', 'Opción 3'],
                    hint: 'Departamento',
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
                    hint: 'Municipio',
                    onChanged: (value) {
                      print('Seleccionaste: $value');
                    },
                  ),
                ),
              ),
            ],
          ),
          CustomInput(label: "Categoría", controller: _categoriaController),
          CustomButton(text: "Registrar", onPressed: _handleSubmit),
        ],
      ),
    );
  }
}