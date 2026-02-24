import 'package:flutter/foundation.dart';
import 'package:waterbills/objects/company.dart';
import 'package:waterbills/utils.dart';

import 'product.dart';
import 'wbobject.dart';

class Invoices extends WBCollection<Invoice> {
  Invoices._() {
    collectionName = "invoices";
    ref = fireInst.collection(collectionName!).withConverter<Invoice>(
        fromFirestore: (snap, _) => Invoice.fromJson(snap.data()!),
        toFirestore: (company, _) => company!.toJson());
  }

  static Invoices instance = Invoices._();

  factory Invoices() {
    if (instance.collectionName == '') {
      instance = Invoices._();
    }
    return instance;
  }
}

class Invoice extends WBObject {
  String? id,
      name,
      date,
      dateRange,
      dcRange,
      productID,
      payment,
      notes,
      companyID = "";
  double? price, quantity, total, gstAmount, amount;
  int? month, year;

  int dcsCount = 0;
  Company? company;
  Product? product;

  Invoice({
    @required this.id,
    @required this.name,
    @required this.date,
    @required this.dateRange,
    @required this.productID,
    @required this.price,
    @required this.quantity,
    @required this.total,
    @required this.gstAmount,
    @required this.amount,
    @required this.month,
    @required this.year,
    @required this.dcRange,
    @required this.payment,
    @required this.notes,
    this.companyID,
  });

  factory Invoice.fromJson(Map<dynamic, dynamic> i) {
    Invoice o = Invoice(
        id: i["id"] ?? Utils.generateId("invoice_"),
        name: i["name"] ?? "",
        date: i["date"] ?? "",
        dateRange: i["date_range"] ?? "",
        productID: i["product"] ?? "",
        dcRange: i["dcRange"] ?? "",
        payment: i["payment"] ?? "Pending",
        notes: i["notes"] ?? "",
        price: (i["price"] ?? 0.0).toDouble(),
        quantity: (i["quantity"] ?? 0.0).toDouble(),
        total: (i["total"] ?? 0.0).toDouble(),
        gstAmount: (i["gst_amt"] ?? 0.0).toDouble(),
        amount: (i["amount"] ?? 0.0).toDouble(),
        month: i["month"] ?? 7,
        year: i["year"] ?? 2022,
        companyID: i["company"] ?? "");
    if (i["company"] != "") {
      o.company = Companies.instance.map[i["company"]];
      o.product = Products.instance.map[i["product"]];
    }
    return o;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "date": date,
      "date_range": dateRange,
      "product": productID,
      "dcRange": dcRange,
      "payment": payment,
      "notes": notes,
      "price": price,
      "quantity": quantity,
      "amount": amount,
      "gst_amt": gstAmount,
      "total": total,
      "month": month,
      "year": year,
    };
  }
}
