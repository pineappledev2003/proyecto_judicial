import 'package:flutter/material.dart';
import 'package:proyecto_uml/view/custom_widgets/boxlist.dart';
import 'package:proyecto_uml/view/custom_widgets/button.dart';
import 'package:proyecto_uml/view/custom_widgets/input.dart';
import 'package:proyecto_uml/utils/notification.dart';


class FormSubSerie extends StatefulWidget {
  final String title;

  const FormSubSerie({super.key, required this.title});

  @override
  _FormSubSerieState createState() => _FormSubSerieState();
}

class _FormSubSerieState extends State<FormSubSerie> {
  final TextEditingController _codigoSerieController = TextEditingController();
  final TextEditingController _codigoSubserieController = TextEditingController();
  final TextEditingController _descSubserieController = TextEditingController();

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
           Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BoxList(
                    items: ['Opción 1', 'Opción 2', 'Opción 3'],
                    hint: 'Serie',
                    onChanged: (value) {
                      print('Seleccionaste: $value');
                    },
                  ),
                ),
          CustomInput(label: "Código de Subserie", controller: _codigoSubserieController),
          CustomInput(label: "Descripción de Subserie", controller: _descSubserieController),
          CustomButton(text: "Registrar", onPressed: _handleSubmit),
        ],
      ),
    );
  }
}