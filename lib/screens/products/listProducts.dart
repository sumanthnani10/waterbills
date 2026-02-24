import 'package:flutter/material.dart';
import 'package:waterbills/objects/company.dart';
import 'package:waterbills/objects/product.dart';
import 'package:waterbills/screens/invoices/listInvoices.dart';
import 'package:waterbills/screens/listLayout.dart';

import '../../utils.dart';
import 'aEVProduct.dart';

class ListProductScreen extends StatefulWidget {
  final String? companyID;

  const ListProductScreen(this.companyID, {Key? key}) : super(key: key);

  @override
  _ListProductScreenState createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  List products = [];
  Company? selectedCompany;

  @override
  void initState() {
    super.initState();
    selectedCompany = Companies.instance.map[widget.companyID];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadList();
    });
  }

  loadList([reload = false]) async {
    Utils.showLoadingDialog(context, "Loading...");
    if (reload) {
      await Products.instance.getCollection();
      Utils.updateObjects();
    }
    products = Products.instance.list
        .where((prod) => prod.companyID == widget.companyID)
        .toList();
    Navigator.pop(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListScreenLayout(
      title: "Products",
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                  child: Text(
                    "${selectedCompany!.name}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                  margin: const EdgeInsets.fromLTRB(8, 8, 64, 8),
                )
              ] +
              List<Widget>.generate(products.length, (i) {
                Product? product = products[i];
                return InkWell(
                    onTap: () async {
                      await Navigator.push(
                          context,
                          Utils.createRoute(
                              ListInvoiceScreen(product!.id, widget.companyID),
                              Utils.DTU));
                      loadList();
                    },
                    child: ProductCard(
                      product,
                      goToView: () async {
                        await Navigator.push(
                            context,
                            Utils.createRoute(
                                AVEProductScreen(
                                  product: product,
                                  view: true,
                                ),
                                Utils.RTL));
                        loadList();
                      },
                    ));
              }),
        ),
      ),
      addScreen: AVEProductScreen(
          product: Product.fromJson({"company": widget.companyID}), add: true),
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

class ProductCard extends StatelessWidget {
  final Product? product;
  final VoidCallback? goToView;

  ProductCard(this.product, {@required this.goToView, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.lightBlue),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(Icons.water, color: Colors.white),
          SizedBox(
            width: 8,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  "${product!.name}",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!Utils.restricted!)
                      Flexible(
                        child: Text(
                          "\u20b9${product!.price} / litre",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                    if (product!.gst!)
                      Flexible(
                        child: Text(
                          "   GST",
                          style: const TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                  ],
                ),
              ),
              Flexible(
                child: Text(
                  "${product!.invoicesCount} Invoices | ${product!.dcsCount} DCs",
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
