import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waterbills/screens/appbar.dart';
import 'package:waterbills/utils.dart';

class AVEScreenLayout extends StatelessWidget {
  final String? title;
  final VoidCallback? addOrEditCall, goToEdit;
  final Widget? body;
  final bool view, add, edit;
  final List<Widget> actions;

  const AVEScreenLayout(
      {@required this.title,
      @required this.addOrEditCall,
      @required this.goToEdit,
      @required this.body,
      this.view = false,
      this.add = false,
      this.edit = false,
      this.actions = const <Widget>[],
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenAppBar(
        title: title,
        actions: <Widget>[
              if (edit || add)
                TextButton.icon(
                    onPressed: addOrEditCall,
                    icon: Icon(
                      edit ? Icons.edit : Icons.add,
                      color: Colors.white,
                      size: 14,
                    ),
                    label: Text(
                      edit ? "Apply Changes" : "Add New",
                      style: const TextStyle(color: Colors.white),
                    )),
          if (view && !Utils.restricted!)
                TextButton.icon(
                    onPressed: goToEdit,
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 14,
                    ),
                    label: Text(
                      "Edit",
                      style: const TextStyle(color: Colors.white),
                    ))
            ] +
            actions,
      ),
      body: body,
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
    );
  }
}
