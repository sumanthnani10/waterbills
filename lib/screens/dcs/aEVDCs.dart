import 'package:flutter/material.dart';
import 'package:waterbills/objects/invoice.dart';
import 'package:waterbills/objects/vehicle.dart';
import 'package:waterbills/screens/aEVLayout.dart';

import '../../objects/dc.dart';
import '../../objects/product.dart';
import '../../utils.dart';

class AVEDCScreen extends StatefulWidget {
  final DC dc;
  final bool view, add, edit;

  const AVEDCScreen(
      {required this.dc,
      this.view = false,
      this.add = false,
      this.edit = false,
      Key? key})
      : super(key: key);

  @override
  _AVEDCScreenState createState() =>
      _AVEDCScreenState(this.dc, this.view, this.add, this.edit);
}

class _AVEDCScreenState extends State<AVEDCScreen> {
  DC dc;
  final bool? view, add, edit;

  _AVEDCScreenState(this.dc, this.view, this.add, this.edit);

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  List<Vehicle> vehicles = Vehicles.instance.list;
  Product? selectedProduct;
  Invoice? selectedInvoice;
  DateTime? date;
  TimeOfDay? time;
  TextEditingController? nameC, quantityC, amountC, dateC, timeC, remarksC;

  @override
  void initState() {
    super.initState();
    if (edit!) {
      dc = DC.fromJson(dc.toJson());
    }
    selectedProduct = Products.instance.map[dc.productID];
    selectedInvoice = Invoices.instance.map[dc.invoiceID];
    if (add!) {
      date = DateTime(selectedInvoice!.year!, selectedInvoice!.month!);
      time = TimeOfDay(hour: 0, minute: 0);
      dc.date = "${Utils.formatDate(date!)}";
      dc.time =
          "${Utils.digitsFormat(time!.hourOfPeriod)}:${Utils.digitsFormat(time!.minute)}:00 ${time!.period.name.toUpperCase()}";
    } else {
      List<String?> splits = dc.date!.split("/");
      date = DateTime(
          int.parse(splits[2]!), int.parse(splits[1]!), int.parse(splits[0]!));
      splits = dc.time!.split(":");
      time = TimeOfDay(
          hour: (int.parse(splits[0]!) + (splits[2]!.contains("AM") ? 0 : 12)),
          minute: int.parse(splits[1]!));
    }
    nameC = new TextEditingController(text: "${dc.name}");
    quantityC = new TextEditingController(text: "${dc.quantity}");
    amountC = new TextEditingController(text: "${dc.amount}");
    dateC = new TextEditingController(text: "${dc.date}");
    timeC = new TextEditingController(text: "${dc.time}");
    remarksC = new TextEditingController(text: "${dc.remarks}");
  }

  @override
  Widget build(BuildContext context) {
    return AVEScreenLayout(
      title: "${view! ? "View" : add! ? "Add" : "Edit"} DC",
      actions: [
        if (view! && !Utils.restricted!)
          TextButton.icon(
              onPressed: () async {
                if (await Utils.showConfirmationDialog(context, "Delete",
                        "Do you want to delete DC No. ${dc.name} ?") ??
                    false) {
                  Utils.showLoadingDialog(context, "Deleting ${dc.name}");

                  await DCs.instance.delete(dc);
                  var r = await updateInvoice();

                  Navigator.pop(context);
                  if (r == null) {
                    Navigator.pop(context);
                  } else {
                    Utils.showErrorDialog(context, "Error", "$r");
                  }
                }
              },
              icon: Icon(
                Icons.delete,
                size: 14,
                color: Colors.white,
              ),
              label: Text(
                "Delete",
                style: const TextStyle(color: Colors.white),
              ))
      ],
      add: add!,
      edit: edit!,
      view: view!,
      addOrEditCall: () async {
        Utils.showLoadingDialog(
            context, edit! ? "Applying Changes.." : "Adding...");
        DC newObject = DC.fromJson({
          "id": dc.id,
          "name": int.parse(nameC!.text.trim()),
          "date": dc.date,
          "time": dc.time,
          "quantity": dc.quantity,
          "amount": dc.amount,
          "invoice": dc.invoiceID,
          "vehicle": dc.vehicle,
          "remarks": remarksC!.text,
        });
        var r = await DCs.instance.upsert(newObject, edit);

        if (r == null) {
          r = await updateInvoice();

          Navigator.pop(context);
          if (r == null) {
            if (add!)
              await Navigator.push(
                  context,
                  Utils.createRoute(
                      AVEDCScreen(
                        dc: DC.fromJson({
                          "name": newObject.name! + 1,
                          "invoice": dc.invoiceID,
                          "product": dc.productID,
                          "company": dc.companyID,
                        }),
                        add: true,
                      ),
                      Utils.RTL));
            Navigator.pop(context);
          } else {
            Utils.showErrorDialog(context, "Error", "$r");
          }
        } else {
          Utils.showErrorDialog(context, "Error", "$r");
        }
      },
      goToEdit: () async {
        await Navigator.push(context,
            Utils.createRoute(AVEDCScreen(dc: dc, edit: true), Utils.UTD));
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
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: nameC,
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                            labelText: "DC Number",
                            enabled: !view!,
                            border: view!
                                ? InputBorder.none
                                : UnderlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: quantityC,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        onChanged: (v) {
                          setState(() {
                            dc.quantity = double.parse(v);
                            dc.amount = (dc.quantity! * selectedInvoice!.price!)
                                .ceilToDouble();
                            amountC!.text = "${dc.amount}";
                            for (Vehicle veh in vehicles) {
                              if (dc.quantity! < veh.to!) {
                                dc.vehicle = veh.name;
                                break;
                              }
                            }
                          });
                        },
                        decoration: InputDecoration(
                            labelText: "Quantity",
                            enabled: !view!,
                            border: view!
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
                          controller: amountC,
                          onChanged: (v) {
                            dc.amount = double.parse(v);
                          },
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Amount",
                            enabled: !view!,
                            border:
                            view! ? InputBorder.none : UnderlineInputBorder(),
                            prefixText: "\u20b9",
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (view!)
                        Flexible(
                          child: TextFormField(
                            initialValue: "${dc.vehicle}",
                            decoration: InputDecoration(
                                labelText: "Vehicle No.",
                                enabled: false,
                                border: InputBorder.none),
                          ),
                        ),
                      if (!view!)
                        Flexible(
                          child: DropdownButton(
                            value: dc.vehicle,
                            onChanged: (vehicle) {
                              if (!view!) {
                                setState(() {
                                  dc.vehicle = vehicle;
                                });
                              }
                            },
                            items: [
                                  DropdownMenuItem(
                                    child: FittedBox(child: Text('Vehicle')),
                                    value: "",
                                  )
                                ] +
                                List.generate(vehicles.length, (i) {
                                  return DropdownMenuItem(
                                    child: FittedBox(
                                        child: Text('${vehicles[i].name}')),
                                    value: vehicles[i].name,
                                  );
                                }),
                            isExpanded: true,
                          ),
                        ),
                      SizedBox(width: 16),
                      Flexible(
                        child: InkWell(
                          onTap: () async {
                            date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(
                                        date!.year, date!.month, date!.day),
                                    firstDate: DateTime(2020, 10),
                                    lastDate: DateTime(selectedInvoice!.year!,
                                        selectedInvoice!.month! + 1)) ??
                                date;
                            setState(() {
                              dc.date = "${Utils.formatDate(date!)}";
                              dateC!.text = dc.date!;
                            });
                          },
                          child: TextFormField(
                            controller: dateC,
                            decoration: InputDecoration(
                                labelText: "Date",
                                enabled: false,
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Flexible(
                        child: InkWell(
                          onTap: () async {
                            time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                        hour: time!.hour,
                                        minute: time!.minute)) ??
                                time;
                            setState(() {
                              dc.time =
                                  "${Utils.digitsFormat(time!.hourOfPeriod)}:${Utils.digitsFormat(time!.minute)}:00 ${time!.period.name.toUpperCase()}";
                              timeC!.text = dc.time!;
                            });
                          },
                          child: TextFormField(
                            controller: timeC,
                            decoration: InputDecoration(
                                labelText: "Time",
                                enabled: false,
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: TextFormField(
                    controller: remarksC,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        labelText: "Remarks",
                        enabled: !view!,
                        border:
                            view! ? InputBorder.none : UnderlineInputBorder()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  updateInvoice() async {
    List<DC> dcs =
        DCs.instance.list.where((o) => o.invoiceID == dc.invoiceID).toList();

    selectedInvoice!.quantity = 0;
    selectedInvoice!.amount = 0;
    selectedInvoice!.dateRange = '${dcs.first.date} - ${dcs.last.date}';
    selectedInvoice!.dcRange = '${dcs.first.name}';

    for (int i = 0; i < dcs.length; i++) {
      DC o = dcs[i];
      selectedInvoice!.quantity = selectedInvoice!.quantity! + o.quantity!;
      selectedInvoice!.amount = selectedInvoice!.amount! + ((o.amount! > 0)
          ? o.amount!
          : (o.quantity! * selectedInvoice!.price!).ceilToDouble());
      if (i > 0) {
        DC p = dcs[i - 1];
        if (o.name! - 1 == p.name) {
          if (!selectedInvoice!.dcRange!.endsWith(' - ')) {
            selectedInvoice!.dcRange = selectedInvoice!.dcRange! + ' - ';
          }
          if (i == dcs.length - 1) selectedInvoice!.dcRange = selectedInvoice!.dcRange! + '${o.name}';
        } else {
          if (i > 1) {
            if (p.name! - 1 == dcs[i - 2].name)
              selectedInvoice!.dcRange = selectedInvoice!.dcRange! + '${p.name}';
          }
          selectedInvoice!.dcRange = selectedInvoice!.dcRange! + ', ${o.name}';
        }
      }
    }
    selectedInvoice!.gstAmount = 0;
    selectedInvoice!.total = selectedInvoice!.amount;
    if (selectedInvoice!.product!.gst!) {
      selectedInvoice!.gstAmount =
          (selectedInvoice!.amount! * 0.18).ceilToDouble();
      selectedInvoice!.total = (selectedInvoice!.amount! * 1.18).ceilToDouble();
    }

    return (await Invoices.instance.upsert(selectedInvoice, true));
  }
}
