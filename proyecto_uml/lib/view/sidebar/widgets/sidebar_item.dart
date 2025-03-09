import 'package:flutter/material.dart';
import 'package:proyecto_uml/view/sidebar/widgets/siderbar_subitem.dart';

class SidebarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<SidebarSubItem> suboptions;

  const SidebarItem({super.key, required this.title, required this.icon, required this.suboptions, });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      children: suboptions.map((sub) => ListTile(
        leading: Icon(sub.icon, color: Colors.white70),
        title: Text(sub.title, style: TextStyle(color: Colors.white70)),
        onTap: sub.onTap,
      )).toList(),
    );
  }
}

