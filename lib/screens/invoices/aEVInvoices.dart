import 'package:flutter/material.dart';
import 'package:waterbills/objects/company.dart';
import 'package:waterbills/objects/invoice.dart';
import 'package:waterbills/screens/aEVLayout.dart';

import '../../objects/product.dart';
import '../../utils.dart';

class AVEInvoiceScreen extends StatefulWidget {
  final Invoice invoice;
  final bool view, add, edit;

  const AVEInvoiceScreen(
      {required this.invoice,
      this.view = false,
      this.add = false,
      this.edit = false,
      Key? key})
      : super(key: key);

  @override
  _AVEInvoiceScreenState createState() =>
      _AVEInvoiceScreenState(this.invoice, this.view, this.add, this.edit);
}

class _AVEInvoiceScreenState extends State<AVEInvoiceScreen> {
  Invoice invoice;
  final bool view, add, edit;

  _AVEInvoiceScreenState(this.invoice, this.view, this.add, this.edit);

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  List<dynamic> companies = Companies.instance.list;
  List<String?> paymentStatuses = ["Pending", "Partially Paid", "Paid"];
  List<dynamic> products = [];
  List<int> months = List<int>.generate(12, (index) => index + 1),
      years = List<int>.generate(20, (index) => 2020 + index);
  Company? selectedCompany;
  Product? selectedProduct;
  TextEditingController? nameC, dateC, priceC, notesC;

  @override
  void initState() {
    super.initState();
    selectedProduct = Products.instance.map[invoice.productID];
    selectedCompany = Companies.instance.map[selectedProduct!.companyID];
    if (edit) {
      invoice = Invoice.fromJson(invoice.toJson());
      invoice.companyID = selectedProduct!.companyID;
      invoice.company = selectedCompany;
    }
    products = Products.instance.list
        .where((element) => element.companyID == invoice.companyID)
        .toList();
    nameC = new TextEditingController(text: invoice.name);
    dateC = new TextEditingController(text: invoice.date);
    priceC = new TextEditingController(text: "${invoice.price}");
    notesC = new TextEditingController(text: "${invoice.notes}");
  }

  setName() {
    DateTime billDate =
        Utils.setMonthLastDate(DateTime(invoice.year!, invoice.month!));
    dateC!.text = Utils.formatDate(billDate)!;
    nameC!.text =
        "${selectedProduct!.prefix}${invoice.year}${Utils.digitsFormat(invoice.month!)}";
  }

  @override
  Widget build(BuildContext context) {
    return AVEScreenLayout(
      title: "${view ? "View" : add ? "Add" : "Edit"} Invoice",
      add: add,
      edit: edit,
      view: view,
      addOrEditCall: () async {
        Utils.showLoadingDialog(
            context, edit ? "Applying Changes.." : "Adding...");
        if (invoice.productID != "") {
          Invoice newObject = Invoice.fromJson({
            "id": invoice.id,
            "name": nameC!.text.trim(),
            "date": dateC!.text.trim(),
            "price": double.parse(priceC!.text),
            "month": invoice.month,
            "year": invoice.year,
            "product": invoice.productID,
            "date_range": invoice.dateRange,
            "dcRange": invoice.dcRange,
            "quantity": invoice.quantity,
            "amount": invoice.amount,
            "gst_amt": invoice.gstAmount,
            "total": invoice.total,
            "payment": invoice.payment,
            "notes": notesC!.text,
          });
          var r = await Invoices.instance.upsert(newObject, edit);
          Navigator.pop(context);
          if (r == null) {
            Navigator.pop(context);
          } else {
            Utils.showErrorDialog(context, "Error", "$r");
          }
        } else {
          Navigator.pop(context);
          Utils.showErrorDialog(
              context, "Missing", "Select a Product for this Invoice.");
        }
      },
      goToEdit: () async {
        await Navigator.push(
            context,
            Utils.createRoute(
                AVEInvoiceScreen(invoice: invoice, edit: true), Utils.UTD));
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
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (view)
                        Flexible(
                          child: TextFormField(
                            initialValue: "${invoice.month}",
                            decoration: InputDecoration(
                                labelText: "Month",
                                enabled: false,
                                border: InputBorder.none),
                          ),
                        ),
                      if (!view) Text("Month:"),
                      if (!view)
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: DropdownButton(
                              value: invoice.month,
                              onChanged: (month) {
                                setState(() {
                                  invoice.month = month;
                                  setName();
                                  setName();
                                });
                              },
                              items: List.generate(months.length, (i) {
                                return DropdownMenuItem(
                                  child: Text('${Utils.months[months[i]][0]}'),
                                  value: months[i],
                                );
                              }),
                              isExpanded: true,
                            ),
                          ),
                        ),
                      SizedBox(width: 16),
                      if (view)
                        Flexible(
                          child: TextFormField(
                            initialValue: "${invoice.year}",
                            decoration: InputDecoration(
                                labelText: "Year",
                                enabled: false,
                                border: InputBorder.none),
                          ),
                        ),
                      if (!view) Text("Year:"),
                      if (!view)
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: DropdownButton(
                              value: invoice.year,
                              onChanged: (year) {
                                setState(() {
                                  invoice.year = year;
                                  setName();
                                });
                              },
                              items: List.generate(years.length, (i) {
                                return DropdownMenuItem(
                                  child: Text('${years[i]}'),
                                  value: years[i],
                                );
                              }),
                              isExpanded: true,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: dateC,
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Date",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!edit)
                      Flexible(
                        child: TextFormField(
                          initialValue: "${invoice.payment}",
                          decoration: InputDecoration(
                              labelText: "Payment Status",
                              enabled: false,
                              border: InputBorder.none),
                        ),
                      ),
                    if (edit)
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment",
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 12),
                            ),
                            DropdownButton(
                              hint: Text("Payment Status"),
                              value: invoice.payment,
                              onChanged: (status) {
                                setState(() {
                                  invoice.payment = status;
                                });
                              },
                              items: List.generate(paymentStatuses.length, (i) {
                                return DropdownMenuItem(
                                  child: Text('${paymentStatuses[i]}'),
                                  value: paymentStatuses[i],
                                );
                              }),
                              isExpanded: true,
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      flex: 2,
                      child: TextFormField(
                        controller: notesC,
                        textCapitalization: TextCapitalization.words,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: "Notes",
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
                      initialValue: "${invoice.company!.name}",
                      decoration: InputDecoration(
                          labelText: "Company",
                          enabled: false,
                          border: InputBorder.none),
                    ),
                  ),
                if (edit)
                  DropdownButton(
                    value: invoice.companyID,
                    onChanged: (companyId) {
                      setState(() {
                        invoice.companyID = companyId;
                        invoice.productID = "";
                        selectedCompany = Companies.instance.map[companyId];
                        selectedProduct = null;
                        products = Products.instance.list
                            .where((element) => element.companyID == companyId)
                            .toList();
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
                if (view || add)
                  Flexible(
                    child: TextFormField(
                      initialValue: "${invoice.product!.name}",
                      decoration: InputDecoration(
                          labelText: "Product",
                          enabled: false,
                          border: InputBorder.none),
                    ),
                  ),
                if (edit)
                  DropdownButton(
                    value: invoice.productID,
                    onChanged: (productId) {
                      setState(() {
                        invoice.productID = productId;
                        selectedProduct = Products.instance.map[productId];
                      });
                    },
                    items: [
                          DropdownMenuItem(
                            child: Text('Select Product'),
                            value: "",
                          )
                        ] +
                        List.generate(products.length, (i) {
                          return DropdownMenuItem(
                            child: Text('${products[i].name}'),
                            value: products[i].id,
                          );
                        }),
                    isExpanded: true,
                  ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: nameC,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                      labelText: "Invoice Name",
                      enabled: !view,
                      border: view ? InputBorder.none : UnderlineInputBorder()),
                ),
                SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: TextFormField(
                          initialValue: "${invoice.quantity}",
                          maxLines: null,
                          decoration: InputDecoration(
                              labelText: "Quantity",
                              enabled: false,
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(width: 16),
                      if (!Utils.restricted!)
                        Flexible(
                          child: TextFormField(
                            initialValue: "\u20b9${invoice.amount}",
                            maxLines: null,
                            decoration: InputDecoration(
                                labelText: "Total",
                                enabled: false,
                                border: InputBorder.none),
                          ),
                        ),
                      SizedBox(width: 16),
                      if (!Utils.restricted!)
                        Flexible(
                          child: TextFormField(
                            initialValue:
                                "${selectedProduct!.gst! ? "\u20b9${invoice.gstAmount}" : "No GST"}",
                            maxLines: null,
                            decoration: InputDecoration(
                                labelText: "GST Amount",
                                enabled: false,
                                border: InputBorder.none),
                          ),
                        ),
                      SizedBox(width: 16),
                      if (!Utils.restricted!)
                        Flexible(
                          child: TextFormField(
                            initialValue: "\u20b9${invoice.total}",
                            maxLines: null,
                            decoration: InputDecoration(
                                labelText: "Grand Total",
                                enabled: false,
                                border: InputBorder.none),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: TextFormField(
                          initialValue: "${invoice.dateRange} ",
                          maxLines: null,
                          decoration: InputDecoration(
                              labelText: "Dates",
                              enabled: false,
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(width: 16),
                      Flexible(
                        child: TextFormField(
                          initialValue: "${invoice.dcRange} ",
                          maxLines: null,
                          decoration: InputDecoration(
                              labelText: "DCs",
                              enabled: false,
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
