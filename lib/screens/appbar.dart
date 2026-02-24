import 'package:flutter/material.dart';

class ScreenAppBar extends StatelessWidget implements PreferredSize {
  final String? title;
  final List<Widget>? actions;

  final Map<String, Color> colors = {
    "Companies": Colors.purple,
    "Products": Colors.cyan,
    "Invoices": Colors.blue,
    "DCs": Colors.indigo,
  };

  ScreenAppBar({this.title, this.actions, Key? key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title!,
        style: const TextStyle(color: Colors.white),
      ),
      elevation: 0,
      backgroundColor: colors[title] ?? Colors.green,
      actions: actions,
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
