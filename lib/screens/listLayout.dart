import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waterbills/screens/appbar.dart';

import '../utils.dart';

class ListScreenLayout extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onReload;
  final Widget? body, addScreen;

  const ListScreenLayout(
      {this.title,
      this.actions,
      this.onReload,
      this.body,
      this.addScreen,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenAppBar(
        title: title,
        actions: actions!,
      ),
      body: body,
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (Utils.restricted! && title != "DCs") {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Restricted")));
            return;
          }
          await Navigator.push(
              context, Utils.createRoute(addScreen, Utils.RTL));
          onReload!();
        },
        backgroundColor: Colors.cyan,
        child: Icon(Icons.add),
      ),
    );
  }
}
