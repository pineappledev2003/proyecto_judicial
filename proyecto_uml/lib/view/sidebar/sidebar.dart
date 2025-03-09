import 'package:flutter/material.dart';
import 'package:proyecto_uml/view/content/form_consulta.dart';
import 'package:proyecto_uml/view/content/form_despacho.dart';
import 'package:proyecto_uml/view/content/form_documental.dart';
import 'package:proyecto_uml/view/content/form_registro.dart';
import 'package:proyecto_uml/view/content/form_serie.dart';
import 'package:proyecto_uml/view/sidebar/widgets/sidebar_item.dart';
import 'package:proyecto_uml/view/sidebar/widgets/siderbar_subitem.dart';

class Sidebar extends StatefulWidget {
  final Function(Widget) onItemSelected;

  const Sidebar({super.key, required this.onItemSelected});

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.indigo[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 15),
                Icon(Icons.balance_sharp, size: 45, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  "Consejo Superior",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
          SidebarItem(
            title: 'Administración', 
            icon: Icons.add_moderator_outlined,
            suboptions: [
              SidebarSubItem(
                title: 'Despacho',
                icon: Icons.house_outlined,
                onTap: () => widget.onItemSelected(FormDespacho(title: "Registro de despacho")),
              ),
              SidebarSubItem(
                title: 'Serie/Subserie',
                icon: Icons.numbers,
                onTap: () => widget.onItemSelected(FormSerie(title: "Registro de Serie y Subserie")),
              ),
              SidebarSubItem(
                title: 'Tipo documental',
                icon: Icons.document_scanner_outlined,
                onTap: () => widget.onItemSelected(FormDocumental(title: "Registro de documental")),
              ),
            ],
          ),
          SidebarItem(
            title: 'Gestión', 
            icon: Icons.folder_shared_rounded,
            suboptions: [
              SidebarSubItem(
                title: 'Expediente',
                icon: Icons.picture_as_pdf_rounded,
                onTap: () => widget.onItemSelected(FormExpediente(title: "Registro de Expediente")),
              ),
              SidebarSubItem(
                title: 'Consulta',
                icon: Icons.search,
                onTap: () => widget.onItemSelected(FormConsulta(title: "Registro de despacho")),
              ),
            ],
          ),
        ],
      ),
    ); 
  }
}
