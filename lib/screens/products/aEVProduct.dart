import 'package:flutter/material.dart';
import 'package:waterbills/objects/company.dart';
import 'package:waterbills/objects/product.dart';
import 'package:waterbills/screens/aEVLayout.dart';

import '../../utils.dart';

class AVEProductScreen extends StatefulWidget {
  final Product? product;
  final bool view, add, edit;

  const AVEProductScreen(
      {this.product,
      this.view = false,
      this.add = false,
      this.edit = false,
      Key? key})
      : super(key: key);

  @override
  _AVEProductScreenState createState() =>
      _AVEProductScreenState(this.product, this.view, this.add, this.edit);
}

class _AVEProductScreenState extends State<AVEProductScreen> {
  final Product? product;
  final bool view, add, edit;

  _AVEProductScreenState(this.product, this.view, this.add, this.edit);

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  List companies = Companies.instance.list;
  Company? selectedCompany;
  TextEditingController? nameC, prefixC, hsnC, priceC, poNumC, poDateC;

  @override
  void initState() {
    super.initState();
    selectedCompany = Companies.instance.map[product!.companyID];
    nameC = new TextEditingController(text: product!.name);
    prefixC = new TextEditingController(text: product!.prefix);
    hsnC = new TextEditingController(text: product!.hsn);
    priceC = new TextEditingController(text: "${product!.price}");
    poNumC = new TextEditingController(text: "${product!.poNum}");
    poDateC = new TextEditingController(text: "${product!.poDate}");
  }

  @override
  Widget build(BuildContext context) {
    return AVEScreenLayout(
      title: "${view ? "View" : add ? "Add" : "Edit"} Product",
      add: add,
      edit: edit,
      view: view,
      addOrEditCall: () async {
        Utils.showLoadingDialog(
            context, edit ? "Applying Changes.." : "Adding...");
        if (product!.companyID != "") {
          Product newObject = Product.fromJson({
            "id": product!.id,
            "name": nameC!.text.trim(),
            "company": product!.companyID,
            "prefix": prefixC!.text.toUpperCase().trim(),
            "hsn": hsnC!.text.trim(),
            "gst": product!.gst,
            "price": double.parse(priceC!.text),
            "poNum": poNumC!.text,
            "poDate": poDateC!.text,
          });
          var r = await Products.instance
              .upsert(newObject, edit, newObject.prefix, "prefix");
          Navigator.pop(context);
          if (r == null) {
            Navigator.pop(context);
          } else {
            Utils.showErrorDialog(context, "Error", "$r");
          }
        } else {
          Navigator.pop(context);
          Utils.showErrorDialog(
              context, "Missing", "Select a Company for this Product.");
        }
      },
      goToEdit: () async {
        await Navigator.push(
            context,
            Utils.createRoute(
                AVEProductScreen(product: product, edit: true), Utils.UTD));
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
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: nameC,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      labelText: "Product Name",
                      enabled: !view,
                      border: view ? InputBorder.none : UnderlineInputBorder()),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: prefixC,
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                            labelText: "Prefix",
                            enabled: !view,
                            border: view
                                ? InputBorder.none
                                : UnderlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: hsnC,
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "HSN Number",
                            enabled: !view,
                            border: view
                                ? InputBorder.none
                                : UnderlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    if (!Utils.restricted!)
                      Flexible(
                        child: TextFormField(
                          controller: priceC,
                          maxLines: null,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Price",
                              prefixText: "\u20b9",
                              enabled: !view,
                              border: view
                                  ? InputBorder.none
                                  : UnderlineInputBorder()),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: poNumC,
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "PO #",
                            enabled: !view,
                            border: view
                                ? InputBorder.none
                                : UnderlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: poDateC,
                        maxLines: null,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "PO Date",
                            enabled: !view,
                            border: view
                                ? InputBorder.none
                                : UnderlineInputBorder()),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                if (view || add)
                  Flexible(
                    child: TextFormField(
                      initialValue: "${product!.company!.name}",
                      decoration: InputDecoration(
                          labelText: "Company",
                          enabled: false,
                          border: InputBorder.none),
                    ),
                  ),
                if (edit)
                  DropdownButton(
                    value: product!.companyID,
                    onChanged: (companyId) {
                      setState(() {
                        product!.companyID = companyId;
                      });
                    },
                    items: [
                          DropdownMenuItem(
                            child: Text('Select Company'),
                            value: "",
                          )
                        ] +
                        List.generate(companies.length, (i) {
                          return DropdownMenuItem(
                            child: Text('${companies[i].name}'),
                            value: companies[i].id,
                          );
                        }),
                    isExpanded: true,
                  ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      Checkbox(
                          value: product!.gst,
                          onChanged: (v) {
                            if (!view) {
                              setState(() {
                                product!.gst = v;
                              });
                            }
                          }),
                      InkWell(
                          onTap: () {
                            if (!view) {
                              setState(() {
                                product!.gst = !product!.gst!;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("GST Bill?"),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
