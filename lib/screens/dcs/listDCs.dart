import 'package:flutter/material.dart';
import 'package:waterbills/objects/invoice.dart';
import 'package:waterbills/objects/product.dart';
import 'package:waterbills/screens/listLayout.dart';

import '../../objects/company.dart';
import '../../objects/dc.dart';
import '../../pdf/pdf.dart';
import '../../utils.dart';
import 'aEVDCs.dart';

class ListDCScreen extends StatefulWidget {
  final String? invoiceID, productID, companyID;

  const ListDCScreen(this.invoiceID, this.productID, this.companyID, {Key? key})
      : super(key: key);

  @override
  _ListDCScreenState createState() => _ListDCScreenState();
}

class _ListDCScreenState extends State<ListDCScreen> {
  List<DC> dcs = [];

  Company? selectedCompany;
  Product? selectedProduct;
  Invoice? selectedInvoice;

  DateTime nowBillDate =
      Utils.setMonthLastDate(DateTime.now().subtract(const Duration(days: 30)));

  @override
  void initState() {
    super.initState();
    selectedCompany = Companies.instance.map[widget.companyID];
    selectedProduct = Products.instance.map[widget.productID];
    selectedInvoice = Invoices.instance.map[widget.invoiceID];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadList();
    });
  }

  loadList([reload = false]) async {
    Utils.showLoadingDialog(context, "Loading...");
    if (reload) {
      await DCs.instance.getCollection();
      Utils.updateObjects();
    }
    dcs = DCs.instance.list
        .where((dc) => dc.invoiceID == widget.invoiceID)
        .toList();
    selectedCompany = Companies.instance.map[widget.companyID];
    selectedProduct = Products.instance.map[widget.productID];
    selectedInvoice = Invoices.instance.map[widget.invoiceID];
    Navigator.pop(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListScreenLayout(
      title: "DCs",
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                  child: Text(
                    "${selectedCompany!.name}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Text(
                    "${selectedProduct!.name}",
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Text(
                    "${Utils.months[selectedInvoice!.month!][0]}-${selectedInvoice!.year} | ${selectedInvoice!.name}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                  margin: const EdgeInsets.fromLTRB(8, 8, 64, 8),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "Quantity: ${selectedInvoice!.quantity} Litres",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          Utils.restricted!
                              ? ""
                              : "Amount: \u20b9${selectedInvoice!.amount}\nGST: \u20b9${selectedInvoice!.gstAmount}\nTotal: \u20b9${selectedInvoice!.total}",
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ] +
              List<Widget>.generate(
                  dcs.length,
                  (i) => InkWell(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            Utils.createRoute(
                                AVEDCScreen(
                                  dc: dcs[i],
                                  view: true,
                                ),
                                Utils.DTU));
                        loadList();
                      },
                      child: DCCard(
                        dcs[i],
                        goToView: () async {
                          await Navigator.push(
                              context,
                              Utils.createRoute(
                                  AVEDCScreen(
                                    dc: dcs[i],
                                    view: true,
                                  ),
                                  Utils.RTL));
                          loadList();
                        },
                      ))),
        ),
      ),
      addScreen: AVEDCScreen(
          dc: DC.fromJson({
            "invoice": widget.invoiceID,
            "product": widget.productID,
            "company": widget.companyID,
          }),
          add: true),
      actions: [
        TextButton.icon(
            onPressed: () => loadList(true),
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            label: Text(
              "Reload",
              style: const TextStyle(color: Colors.white),
            )),
        if (!Utils.restricted!)
          TextButton.icon(
              onPressed: () async {
                Utils.showLoadingDialog(context, "Sharing");
                await PDF.instance.generateCombinedPDF(dcs);
                Navigator.pop(context);
                // Navigator.push(context, Utils.createRoute(Test(selectedInvoice),Utils.UTD));
              },
              icon: Icon(
                Icons.share,
                size: 14,
                color: Colors.white,
              ),
              label: Text(
                "Share",
                style: const TextStyle(color: Colors.white),
              ))
      ],
      onReload: () => loadList(true),
    );
  }
}

class DCCard extends StatelessWidget {
  final DC dc;
  final VoidCallback? goToView;

  DCCard(this.dc, {@required this.goToView, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.purple),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(Icons.fire_truck, color: Colors.white),
          SizedBox(
            width: 8,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  "${dc.name}",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Flexible(
                child: Text(
                  Utils.restricted!
                      ? "${dc.quantity}L\n${dc.vehicle} | ${dc.date}"
                      : "${dc.quantity}L x \u20b9${dc.invoice!.price} = \u20b9${dc.amount}\n${dc.vehicle} | ${dc.date}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          Spacer(),
          Align(
            alignment: Alignment.topCenter,
            child: InkWell(
                onTap: goToView,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
                  child: Icon(
                    Icons.remove_red_eye,
                    color: Colors.purple,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
