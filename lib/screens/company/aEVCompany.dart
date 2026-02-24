import 'package:flutter/material.dart';
import 'package:waterbills/objects/company.dart';
import 'package:waterbills/screens/aEVLayout.dart';

import '../../utils.dart';

class AVECompanyScreen extends StatefulWidget {
  final Company? company;
  final bool view, add, edit;

  const AVECompanyScreen(
      {this.company,
      this.view = false,
      this.add = false,
      this.edit = false,
      Key? key})
      : super(key: key);

  @override
  _AVECompanyScreenState createState() =>
      _AVECompanyScreenState(this.company, this.view, this.add, this.edit);
}

class _AVECompanyScreenState extends State<AVECompanyScreen> {
  final Company? company;
  final bool? view, add, edit;

  _AVECompanyScreenState(this.company, this.view, this.add, this.edit);

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController? nameC, addressC, gstNumC, mailsC;

  @override
  void initState() {
    super.initState();
    nameC = new TextEditingController(text: company!.name);
    addressC = new TextEditingController(text: company!.address);
    gstNumC = new TextEditingController(text: company!.gstNumber);
    mailsC = new TextEditingController(text: company!.mailTo!.join(", "));
  }

  @override
  Widget build(BuildContext context) {
    return AVEScreenLayout(
      title: "${view! ? "View" : add! ? "Add" : "Edit"} Company",
      add: add!,
      edit: edit!,
      view: view!,
      addOrEditCall: () async {
        Utils.showLoadingDialog(
            context, edit! ? "Applying Changes.." : "Adding...");
        Company newObject = Company.fromJson({
          "id": company!.id,
          "name": nameC!.text.trim(),
          "address": addressC!.text.trim(),
          "gst_no": gstNumC!.text.toUpperCase().trim(),
          "mail_to": mailsC!.text.toLowerCase().split(", "),
        });
        var r = await Companies.instance.upsert(newObject, edit);
        Navigator.pop(context);
        if (r == null) {
          Navigator.pop(context);
        } else {
          Utils.showErrorDialog(context, "Error", "$r");
        }
      },
      goToEdit: () async {
        await Navigator.push(
            context,
            Utils.createRoute(
                AVECompanyScreen(company: company, edit: true), Utils.UTD));
        Navigator.pop(context);
      },
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: nameC,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      labelText: "Company Name",
                      enabled: !view!,
                      border: view! ? InputBorder.none : UnderlineInputBorder()),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: addressC,
                  textInputAction: TextInputAction.newline,
                  textCapitalization: TextCapitalization.words,
                  maxLines: null,
                  decoration: InputDecoration(
                      labelText: "Address",
                      enabled: !view!,
                      border: view! ? InputBorder.none : UnderlineInputBorder()),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: gstNumC,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                      labelText: "GST Number",
                      enabled: !view!,
                      border: view! ? InputBorder.none : UnderlineInputBorder()),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: mailsC,
                  maxLines: null,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                      labelText: "Mail Addresses",
                      enabled: !view!,
                      border: view! ? InputBorder.none : UnderlineInputBorder()),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
