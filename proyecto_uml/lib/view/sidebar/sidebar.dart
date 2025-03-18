import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_uml/controllers/despacho/despacho_controller_list.dart';
import 'package:proyecto_uml/controllers/retencion_documental/retencion_documental_controller_list.dart';
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
  SidebarState createState() => SidebarState();
}

class SidebarState extends State<Sidebar> {
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
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
                onTap: () {
                  final despachoController = Provider.of<DespachoListaController>(
                    context,
                    listen: false,
                  );
                  widget.onItemSelected(
                    FormDespacho(
                      title: "Registro de despacho",
                      controladorDespacho: despachoController,
                    ),
                  );
                },
              ),
              SidebarSubItem(
                title: 'Serie',
                icon: Icons.numbers,
                onTap: () {
                  final retencionDocumentaController =
                      Provider.of<RetencionDocumentalControllerList>(context, listen: false);
                  widget.onItemSelected(
                    FormSerie(
                      title: "Registro de Serie",
                      controllerRetencionDocumental: retencionDocumentaController,
                    ),
                  );
                },
              ),

              SidebarSubItem(
                title: 'Tipo documental',
                icon: Icons.document_scanner_outlined,
                onTap: () {
                  final retencionDocumentaController =
                      Provider.of<RetencionDocumentalControllerList>(context, listen: false);
                  widget.onItemSelected(
                    FormDocumental(
                      title: "Registro de documental",
                      controladorRetencionDocumental: retencionDocumentaController,
                    ),
                  );
                },
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
                onTap: () {
                  widget.onItemSelected(FormExpediente(title: "Registro de Expediente"));
                },
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
