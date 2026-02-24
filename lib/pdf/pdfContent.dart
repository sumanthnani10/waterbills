import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../objects/dc.dart';
import '../objects/invoice.dart';
import '../utils.dart';

class PdfContent {
  Font? poppinsBold;
  Font? poppins;

  PdfContent._() {}

  static PdfContent instance = PdfContent._();

  factory PdfContent() {
    instance = PdfContent._();
    return instance;
  }

  init() async {
    if (poppins == null) {
      poppins = await PdfGoogleFonts.poppinsRegular();
    }
    if (poppinsBold == null) {
      poppinsBold = await PdfGoogleFonts.poppinsBold();
    }
  }

  Future<List<Widget>> dcsListContent(List<DC> dcs) async {
    await init();
    List<List<DC>> dcs_ = [];
    int maxRows = 44, n = 0, index = 1;
    while (n < dcs.length) {
      dcs_ += [
        dcs.sublist(n, (n + maxRows > dcs.length ? dcs.length : n + maxRows))
      ];
      n += maxRows;
      if (maxRows == 44) maxRows = 47;
    }
    return List<Widget>.generate(dcs_.length, (j) {
          dcs = dcs_[j];
          return Theme(
              data: ThemeData(defaultTextStyle: TextStyle(font: poppins)),
              child: Column(children: [
                if (j == 0)
                  Column(children: [
                    Center(
                        child: Text("${dcs[0].company!.name}",
                            style: TextStyle(font: poppinsBold, fontSize: 14))),
                    Center(
                        child: Text("${dcs[0].product!.name}",
                            style: TextStyle(font: poppinsBold, fontSize: 12))),
                    Container(
                        margin: EdgeInsets.fromLTRB(16, 4, 16, 8),
                        color: PdfColors.black,
                        height: 1,
                        width: 500)
                  ]),
                Table(
                    border: TableBorder.all(
                      color: PdfColors.black,
                    ),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                          TableRow(
                            children: [
                              Center(
                                  child: Text("S. No.",
                                      style: TextStyle(font: poppinsBold))),
                              Center(
                                  child: Text("DC No.",
                                      style: TextStyle(font: poppinsBold))),
                              Center(
                                  child: Text("Date",
                                      style: TextStyle(font: poppinsBold))),
                              Center(
                                  child: Text("Vehicle",
                                      style: TextStyle(font: poppinsBold))),
                              Center(
                                  child: Text("Quantity",
                                      style: TextStyle(font: poppinsBold))),
                              Center(
                                  child: Text("Price",
                                      style: TextStyle(font: poppinsBold))),
                              Center(
                                  child: Text("Amount",
                                      style: TextStyle(font: poppinsBold))),
                            ],
                          ),
                        ] +
                        List<TableRow>.generate(dcs.length, (i) {
                          DC dc = dcs[i];
                          return TableRow(children: [
                            Center(child: Text("${index++}")),
                            Center(child: Text("${dc.name}")),
                            Center(child: Text("${dc.date}")),
                            Center(child: Text("${dc.vehicle}")),
                            Center(child: Text("${dc.quantity}")),
                            Center(child: Text("${dc.invoice!.price}")),
                            Center(child: Text("${dc.amount}")),
                          ]);
                        }) +
                        ((j + 1 == dcs_.length && dcs_.last.length < maxRows)
                            ? [
                                TableRow(children: [
                                  Center(child: Text("")),
                                  Center(child: Text("")),
                                  Center(child: Text("")),
                                  Center(
                                      child: Text("Total",
                                          style: TextStyle(font: poppinsBold))),
                                  Center(
                                      child: Text("${dcs[0].invoice!.quantity}",
                                          style: TextStyle(font: poppinsBold))),
                                  Center(child: Text("")),
                                  Center(
                                      child: Text("${dcs[0].invoice!.amount}",
                                          style: TextStyle(font: poppinsBold))),
                                ])
                              ]
                            : []))
              ]));
        }) +
        (dcs_.last.length >= maxRows
            ? <Widget>[
                Theme(
                    data: ThemeData(defaultTextStyle: TextStyle(font: poppins)),
                    child: Table(
                        border: TableBorder.all(
                          color: PdfColors.black,
                        ),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            children: [
                              Center(
                                  child: Text("S. No.",
                                      style: TextStyle(font: poppinsBold))),
                              Center(
                                  child: Text("DC No.",
                                      style: TextStyle(font: poppinsBold))),
                              Center(
                                  child: Text("Date",
                                      style: TextStyle(font: poppinsBold))),
                              Center(
                                  child: Text("Vehicle",
                                      style: TextStyle(font: poppinsBold))),
                              Center(
                                  child: Text("Quantity",
                                      style: TextStyle(font: poppinsBold))),
                              Center(
                                  child: Text("Price",
                                      style: TextStyle(font: poppinsBold))),
                              Center(
                                  child: Text("Amount",
                                      style: TextStyle(font: poppinsBold))),
                            ],
                          ),
                          TableRow(children: [
                            Center(child: Text("")),
                            Center(child: Text("")),
                            Center(child: Text("")),
                            Center(
                                child: Text("Total",
                                    style: TextStyle(font: poppinsBold))),
                            Center(
                                child: Text("${dcs[0].invoice!.quantity}",
                                    style: TextStyle(font: poppinsBold))),
                            Center(child: Text("")),
                            Center(
                                child: Text("${dcs[0].invoice!.amount}",
                                    style: TextStyle(font: poppinsBold))),
                          ])
                        ]))
              ]
            : <Widget>[]);
  }

  Future<Widget> invoiceContent(Invoice invoice) async {
    await init();
    PdfColor blue = PdfColor.fromHex("2e75b5");
    final ByteData bytes = await rootBundle.load("assets/srinivas sign.png");
    final Uint8List byteList = bytes.buffer.asUint8List();
    return Theme(
        data: ThemeData(defaultTextStyle: TextStyle(font: poppins)),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " ",
                        style: TextStyle(
                            color: blue, fontSize: 10, font: poppinsBold),
                      ),
                      Text(
                        "SRINIVAS ENTERPRISES",
                        style: TextStyle(
                            color: blue, fontSize: 18, font: poppinsBold),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "GST No.: 36AGLPB6730F1ZL",
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "12-80/2, Srinagar colony, Patancheru",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        "Hyderabad, Telangana, 502319",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        "Phone: 8801707182",
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.all(2),
                        alignment: Alignment.centerLeft,
                        color: blue,
                        child: Text(
                          " BILL TO",
                          style: TextStyle(
                              color: PdfColors.white,
                              font: poppinsBold,
                              fontSize: 11),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${invoice.company!.name}",
                        style: TextStyle(fontSize: 11, font: poppinsBold),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "GST No.: ${invoice.company!.gstNumber}",
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${invoice.company!.address}",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
                Flexible(
                    child: Center(
                        child: Text(
                  "INVOICE",
                  style: TextStyle(font: poppinsBold, fontSize: 16),
                ))),
                Flexible(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      alignment: Alignment.center,
                                      color: blue,
                                      child: Text(
                                        "INVOICE#",
                                        style: TextStyle(
                                            color: PdfColors.white,
                                            font: poppinsBold,
                                            fontSize: 11),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${invoice.name}",
                                        style: TextStyle(
                                            font: poppinsBold, fontSize: 11),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      color: blue,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "DATE",
                                        style: TextStyle(
                                            color: PdfColors.white,
                                            font: poppinsBold,
                                            fontSize: 11),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${invoice.date}",
                                        style: TextStyle(
                                            font: poppinsBold, fontSize: 11),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      alignment: Alignment.center,
                                      color: blue,
                                      child: Text(
                                        "PO NUMBER",
                                        style: TextStyle(
                                            color: PdfColors.white,
                                            font: poppinsBold,
                                            fontSize: 11),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${invoice.product!.poNum}",
                                        style: TextStyle(fontSize: 11),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      color: blue,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "PO DATE",
                                        style: TextStyle(
                                            color: PdfColors.white,
                                            font: poppinsBold,
                                            fontSize: 11),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${invoice.product!.poDate}",
                                        style: TextStyle(fontSize: 11),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      alignment: Alignment.center,
                                      color: blue,
                                      child: Text(
                                        "DC No.s",
                                        style: TextStyle(
                                            color: PdfColors.white,
                                            font: poppinsBold,
                                            fontSize: 11),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      alignment: Alignment.center,
                                      child: Text("${invoice.dcRange}",
                                          style: TextStyle(fontSize: 11),
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      color: blue,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Dates",
                                        style: TextStyle(
                                            color: PdfColors.white,
                                            font: poppinsBold,
                                            fontSize: 11),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${invoice.dateRange}",
                                        style: TextStyle(fontSize: 11),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Table(
              columnWidths: {
                0: FractionColumnWidth(0.4),
              },
              children: [
                TableRow(
                    decoration: BoxDecoration(
                      color: blue,
                    ),
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                        child: Text(
                          "DESCRIPTION",
                          style: TextStyle(
                              fontSize: 10,
                              font: poppinsBold,
                              color: PdfColors.white),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                        child: Text(
                          "HSN CODE",
                          style: TextStyle(
                              fontSize: 10,
                              font: poppinsBold,
                              color: PdfColors.white),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                        child: Text(
                          "QUANTITY (Litres)",
                          style: TextStyle(
                              fontSize: 10,
                              font: poppinsBold,
                              color: PdfColors.white),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                        child: Text(
                          "PRICE",
                          style: TextStyle(
                              fontSize: 10,
                              font: poppinsBold,
                              color: PdfColors.white),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                        child: Text(
                          "AMOUNT",
                          style: TextStyle(
                              fontSize: 10,
                              font: poppinsBold,
                              color: PdfColors.white),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: Text(
                      "${invoice.product!.name}",
                      style: TextStyle(fontSize: 11, color: PdfColors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: Text(
                      "${invoice.product!.hsn}",
                      style: TextStyle(fontSize: 11, color: PdfColors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: Text(
                      "${invoice.quantity}",
                      style: TextStyle(fontSize: 11, color: PdfColors.black),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: Text(
                      "${invoice.product!.price}",
                      style: TextStyle(fontSize: 11, color: PdfColors.black),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: Text(
                      "${invoice.amount}",
                      style: TextStyle(fontSize: 11, color: PdfColors.black),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ]),
              ],
            ),
            SizedBox(
              height: 160,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            border: Border.symmetric(horizontal: BorderSide())),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Amount In Words: ",
                              style: TextStyle(
                                  fontSize: 11,
                                  decoration: TextDecoration.underline),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "${Utils.getPriceInWords("${invoice.total}")}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ))),
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border(bottom: BorderSide(color: blue))),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    alignment: Alignment.center,
                                    color: blue,
                                    child: Text(
                                      "SUBTOTAL",
                                      style: TextStyle(
                                          color: PdfColors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      Utils.getPriceWithCommas(
                                          "${invoice.amount}"),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ))),
                    Flexible(
                        child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border(bottom: BorderSide(color: blue))),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    alignment: Alignment.center,
                                    color: blue,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "GST(18%)",
                                          style: TextStyle(
                                              color: PdfColors.white,
                                              fontSize: 10),
                                        ),
                                        Text(
                                          " CGST: 9%, SGST: 9%",
                                          style: TextStyle(
                                              color: PdfColors.white,
                                              fontSize: 8),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      Utils.getPriceWithCommas(
                                          "${invoice.gstAmount}"),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ))),
                    Flexible(
                        child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border(bottom: BorderSide(color: blue))),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    alignment: Alignment.center,
                                    color: blue,
                                    child: Text(
                                      "GRAND TOTAL",
                                      style: TextStyle(
                                          color: PdfColors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Rs.${Utils.getPriceWithCommas("${invoice.total}")}",
                                      style: TextStyle(
                                          font: poppinsBold, fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ))),
                  ],
                )),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image(MemoryImage(byteList), width: 70),
                  Text(
                    "Signature",
                    style: TextStyle(font: poppinsBold, fontSize: 12),
                  ),
                ],
              ),
            ),
            Text(
              "Thank you for the business\nIf you have any questions about this invoice, please contact\nB.Srinivas, +91 8801707182, srinivasbejugam2@gmail.com",
              style: TextStyle(fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ],
        )));
  }
}
