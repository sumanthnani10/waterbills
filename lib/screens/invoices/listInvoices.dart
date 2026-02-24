import 'package:flutter/material.dart';
import 'package:waterbills/objects/invoice.dart';
import 'package:waterbills/objects/product.dart';
import 'package:waterbills/screens/dcs/listDCs.dart';
import 'package:waterbills/screens/listLayout.dart';

import '../../objects/company.dart';
import '../../utils.dart';
import 'aEVInvoices.dart';

class ListInvoiceScreen extends StatefulWidget {
  final String? productID, companyID;

  const ListInvoiceScreen(this.productID, this.companyID, {Key? key})
      : super(key: key);

  @override
  _ListInvoiceScreenState createState() => _ListInvoiceScreenState();
}

class _ListInvoiceScreenState extends State<ListInvoiceScreen> {
  List invoices = [];
  Company? selectedCompany;
  Product? selectedProduct;
  DateTime nowBillDate =
      Utils.setMonthLastDate(DateTime.now().subtract(const Duration(days: 30)));

  @override
  void initState() {
    super.initState();
    selectedCompany = Companies.instance.map[widget.companyID];
    selectedProduct = Products.instance.map[widget.productID];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadList();
    });
  }

  loadList([reload = false]) async {
    Utils.showLoadingDialog(context, "Loading...");
    if (reload) {
      await Invoices.instance.getCollection();
      Utils.updateObjects();
    }
    invoices = Invoices.instance.list
        .where((prod) => prod.productID == widget.productID)
        .toList();
    Navigator.pop(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListScreenLayout(
      title: "Invoices",
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                  child: Text(
                    "${selectedCompany!.name}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
                  child: Text(
                    "${selectedProduct!.name}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                  margin: const EdgeInsets.fromLTRB(8, 8, 64, 8),
                )
              ] +
              List<Widget>.generate(
                  invoices.length,
                  (i) => InkWell(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            Utils.createRoute(
                                ListDCScreen(invoices[i].id, widget.productID,
                                    widget.companyID),
                                Utils.DTU));
                        loadList();
                      },
                      child: InvoiceCard(
                        invoices[i],
                        goToView: () async {
                          await Navigator.push(
                              context,
                              Utils.createRoute(
                                  AVEInvoiceScreen(
                                    invoice: invoices[i],
                                    view: true,
                                  ),
                                  Utils.RTL));
                          loadList();
                        },
                      ))),
        ),
      ),
      addScreen: AVEInvoiceScreen(
          invoice: Invoice.fromJson({
            "name":
                "${selectedProduct!.prefix}${nowBillDate.year}${Utils.digitsFormat(nowBillDate.month)}",
            "date": Utils.formatDate(nowBillDate),
            "price": selectedProduct!.price,
            "month": nowBillDate.month,
            "year": nowBillDate.year,
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
            ))
      ],
      onReload: () => loadList(true),
    );
  }
}

class InvoiceCard extends StatelessWidget {
  final Invoice invoice;
  final VoidCallback? goToView;

  InvoiceCard(this.invoice, {@required this.goToView, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.indigo),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(Icons.request_page_outlined, color: Colors.white),
          SizedBox(
            width: 8,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  "${invoice.name}",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        Utils.restricted!
                            ? "${invoice.quantity}L"
                            : "${invoice.quantity}L x \u20b9${invoice.price} = \u20b9${invoice.total} ${invoice.product!.gst! ? "(With GST)" : ""}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Text(
                  "${invoice.dcsCount} DCs",
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
                    color: Colors.white,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
