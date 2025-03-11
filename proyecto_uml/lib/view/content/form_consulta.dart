import 'package:flutter/material.dart';
import 'package:proyecto_uml/view/custom_widgets/button.dart';
import 'package:proyecto_uml/view/custom_widgets/input.dart';
import 'package:proyecto_uml/utils/notification.dart';

class FormConsulta extends StatefulWidget {
  final String title;

  const FormConsulta({super.key, required this.title});

  @override
  _FormConsultaState createState() => _FormConsultaState();
}

class _FormConsultaState extends State<FormConsulta> {
  final TextEditingController _nombreController = TextEditingController();

  void _handleSubmit() {
    Notificacion.mostrar("Registro guardado correctamente");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: CustomInput(label: "N° de Expediente", controller: _nombreController)),
              SizedBox(width: 10),
              CustomButton(text: "Buscar", onPressed: _handleSubmit),
            ],
          ),
        ],
      ),
    );
  }
}
