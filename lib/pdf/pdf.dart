import 'package:universal_html/html.dart' as html;
import 'dart:io';

// import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart';
import 'package:waterbills/pdf/pdfContent.dart';

import '../objects/dc.dart';
import '../objects/invoice.dart';
import '../utils.dart';

class PDF {
  PDF._();

  static PDF instance = PDF._();

  factory PDF() {
    instance = PDF._();
    return instance;
  }

  generateCombinedPDF(List<DC> dcs) async {
    Document doc = Document();
    List<Widget> content = [
      await PdfContent.instance.invoiceContent(dcs[0].invoice!),
      NewPage()
    ];
    content += await PdfContent.instance.dcsListContent(dcs);
    doc.addPage(MultiPage(
        margin: const EdgeInsets.all(16),
        pageFormat: pdf.PdfPageFormat.a4,
        build: (c) => content));
    String? path = await saveFile(doc, "${dcs[0].invoice!.name}");
    if(!kIsWeb)
      await mailInvoice(dcs[0].invoice!, path);
  }

  generateDCListPDF(List<DC> dcs) async {
    Document doc = Document();
    var content = await PdfContent.instance.dcsListContent(dcs);
    doc.addPage(MultiPage(
        margin: const EdgeInsets.all(16),
        pageFormat: pdf.PdfPageFormat.a4,
        build: (c) => content));
    saveFile(doc, "${dcs[0].invoice!.name} DCs");
    generateInvoicePDF(dcs[0].invoice!);
  }

  generateInvoicePDF(Invoice invoice) async {
    Document doc = Document();
    var content = await PdfContent.instance.invoiceContent(invoice);
    doc.addPage(Page(
        margin: const EdgeInsets.all(16),
        pageFormat: pdf.PdfPageFormat.a4,
        build: (c) => content));
    saveFile(doc, "${invoice.name} Invoice");
  }

  Future<String?> saveFile(Document doc, String? fileName) async {
    if(kIsWeb) {
      html.AnchorElement()
        ..href = '${Uri.dataFromBytes(await doc.save())}'
        ..download = "${fileName}.pdf"
        ..style.display = 'none'
        ..click();
      return "";
    } else {
      Directory? downloadPath = await getApplicationDocumentsDirectory();
      String? path = '${downloadPath.path}/$fileName.pdf';
      final file = File(path);
      await file.writeAsBytes(await doc.save());
      return path;
    }
  }

  mailInvoice(Invoice invoice, String? path) async {
    await FlutterEmailSender.send(Email(
        body:
            'Srinivas Enterprises ${invoice.product!.name} Bill for ${Utils.months[invoice.month!][0]} ${invoice.year}',
        recipients: ((invoice.company!.mailTo!.length == 0) ? ["srinivasbejugam2@gmail.com"] : invoice.company!.mailTo!),
        subject: 'Srinivas Enterprises ${Utils.months[invoice.month!][0]} ${invoice.year} Bill',
        attachmentPaths: [path!]));
  }
}
