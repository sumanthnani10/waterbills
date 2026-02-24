import 'package:flutter/foundation.dart';
import 'package:waterbills/objects/invoice.dart';
import 'package:waterbills/utils.dart';

import 'company.dart';
import 'product.dart';
import 'wbobject.dart';

class DCs extends WBCollection<DC> {
  DCs._() {
    collectionName = "dcs";
    ref = fireInst.collection(collectionName!).withConverter<DC>(
        fromFirestore: (snap, _) => DC.fromJson(snap.data()!),
        toFirestore: (dc, _) => dc.toJson());
  }

  static DCs instance = DCs._();

  factory DCs() {
    if (instance.collectionName == '') {
      instance = DCs._();
    }
    return instance;
  }

  @override
  getCollection() async {
    await super.getCollection();
    list.sort((a, b) => (b.name! <= a.name!) ? 1 : -1);
  }
}

class DC extends WBObject {
  String? id,
      date,
      time,
      invoiceID,
      productID = "",
      companyID = "",
      vehicle,
      remarks;
  double? quantity, amount;
  int? name;

  Company? company;
  Product? product;
  Invoice? invoice;

  DC({
    @required this.id,
    @required this.name,
    @required this.date,
    @required this.time,
    @required this.invoiceID,
    @required this.quantity,
    @required this.vehicle,
    @required this.remarks,
    @required this.amount,
    this.productID,
    this.companyID,
  });

  factory DC.fromJson(Map<dynamic, dynamic> i) {
    DC o = DC(
        id: i["id"] ?? Utils.generateId("dc_"),
        name: i["name"] ?? 0,
        date: i["date"] ?? "",
        time: i["time"] ?? "",
        invoiceID: i["invoice"] ?? "",
        remarks: i["remarks"] ?? "",
        vehicle: i["vehicle"] ?? "",
        quantity: (i["quantity"] ?? 0.0).toDouble(),
        amount: (i["amount"] ?? 0.0).toDouble(),
        companyID: i["company"] ?? "",
        productID: i["product"] ?? "");

    if (i["company"] != "") {
      o.company = Companies.instance.map[i["company"]];
      o.product = Products.instance.map[i["product"]];
      o.invoice = Invoices.instance.map[i["invoice"]];
    }

    return o;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "date": date,
      "time": time,
      "invoice": invoiceID,
      "vehicle": vehicle,
      "remarks": remarks,
      "quantity": quantity,
      "amount": amount,
    };
  }
}
