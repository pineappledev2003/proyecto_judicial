import 'package:flutter/material.dart';
import 'package:proyecto_uml/view/custom_widgets/boxlist.dart';
import 'package:proyecto_uml/view/custom_widgets/button.dart';
import 'package:proyecto_uml/view/custom_widgets/input.dart';
import 'package:proyecto_uml/utils/notification.dart';

class FormDocumento extends StatefulWidget {
  final String title;

  const FormDocumento({super.key, required this.title});

  @override
  _FormDocumentoState createState() => _FormDocumentoState();
}

class _FormDocumentoState extends State<FormDocumento> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _fechaInicioController = TextEditingController();
  final TextEditingController _fechaFinController = TextEditingController();
  final TextEditingController _numero1Controller = TextEditingController();
  final TextEditingController _numero2Controller = TextEditingController();
  final TextEditingController _numero3Controller = TextEditingController();
  final TextEditingController _numero4Controller = TextEditingController();
  final TextEditingController _input1Controller = TextEditingController();
  final TextEditingController _input2Controller = TextEditingController();
  final TextEditingController _input3Controller = TextEditingController();
  final TextEditingController _observacionesController = TextEditingController();

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
          SizedBox(height: 20.0),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
          child: 
          BoxList(
                  items: ['Opción 1', 'Opción 2', 'Opción 3'],
                  hint: 'Nombre - Tipo documental',
                  onChanged: (value) {
                    print('Seleccionaste: $value');
                  },
                )),
          Row(
            children: [
              Expanded(child: CustomInput(label: "Fecha de Creación", controller: _fechaInicioController)),
              Expanded(child: CustomInput(label: "Fecha de Incorporación", controller: _fechaFinController)),
            ],
          ),
          Row(
            children: [
              Expanded(child: CustomInput(label: "Orden", controller: _numero1Controller)),
              Expanded(child: CustomInput(label: "N° de Páginas", controller: _numero2Controller)),
              Expanded(child: CustomInput(label: "Página de Inicio", controller: _numero3Controller)),
              Expanded(child: CustomInput(label: "Página de Fin", controller: _numero4Controller)),
            ],
          ),
          Row(
            children: [
              Expanded(child: CustomInput(label: "Formato", controller: _input1Controller)),
              Expanded(child: CustomInput(label: "Tamaño", controller: _input2Controller)),
              Expanded(child: CustomInput(label: "Origen", controller: _input3Controller)),
            ],
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 0),
          child: BoxList(
            items: ['Cuaderno 1', 'Cuaderno 2', 'Cuaderno 3'],
            hint: 'Cuaderno',
            onChanged: (value) {
              print('Seleccionaste: $value');
            },
          )),
          CustomInput(label: "Observaciones", controller: _observacionesController),
          CustomButton(text: "Registrar", onPressed: _handleSubmit),
        ],
      ),
    );
  }
}
