import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/core/service/pdf_service/pdf_service.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/models/optical_receipt/optical_receipt.dart';
import 'package:opmswebstaff/models/payment/payment.dart';
import 'package:opmswebstaff/models/prescription/prescription.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:opmswebstaff/models/product/lens.dart';
import 'package:opmswebstaff/models/product/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;

import '../../../models/optical_certificate/optical_certificate.dart';
import '../../../models/patient_model/patient_model.dart';

class PdfServiceImp extends PdfService {
  @override
  Future<Uint8List> printReceipt({required Payment payment}) async {
    final ByteData image =
        await rootBundle.load('assets/images/check_green.png');
    final ByteData logo = await rootBundle.load('assets/icons/logo1.png');

    final ByteData fontData =
        await rootBundle.load('fonts/SFPro-Regular.ttf');

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a6,
          build: (pw.Context context) => [
                Container(
                  color: PdfColors.white,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: ListView(
                    children: [
                      pw.Image(pw.MemoryImage(image.buffer.asUint8List()),
                          width: 20, height: 20),
                      Text(
                        'Successfully Recorded the payment of patient',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Text(
                          '${payment.patient_name}',
                          style: TextStyle(
                            color: PdfColors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      payment.opticalNote!.isNotEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: PdfColors.grey,
                                ),
                                Text('Optical Service'),
                                ListView.separated(
                                    itemBuilder: (context, index) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // RichText(
                                            //   text: TextSpan(
                                            //       text: payment
                                            //           .opticalNote![index]
                                            //           .service
                                            //           .serviceName,
                                            //       // children: [
                                            //       //   TextSpan(
                                            //       //     text: ' @tooth#' +
                                            //       //         payment
                                            //       //             .dentalNote![
                                            //       //                 index]
                                            //       //             .sphere,
                                            //       //   )
                                            //       // ],
                                            //       style: TextStyle(
                                            //           color: PdfColors.black,
                                            //           fontSize: 12)),
                                            // ),
                                            Text(
                                                payment.opticalNote![index]
                                                    .service.serviceName,
                                                // children: [
                                                //   TextSpan(
                                                //     text: ' @tooth#' +
                                                //         payment
                                                //             .dentalNote![
                                                //                 index]
                                                //             .sphere,
                                                //   )
                                                // ],
                                                style: TextStyle(
                                                    color: PdfColors.black,
                                                    fontSize: 12)),
                                            // Text(payment.opticalNote![index]
                                            //     .service.price!
                                            //     .toString()
                                            //     .toCurrency!),
                                            Text(payment.opticalNoteSubTotal
                                                .toString()
                                                .toCurrency!),
                                          ],
                                        ),
                                    separatorBuilder: (context, index) =>
                                        Divider(height: 1),
                                    itemCount: payment.opticalNote!.length),
                              ],
                            )
                          : Container(),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: PdfColors.grey,
                      ),
                      SizedBox(height: 4),
                      payment.productList!.isNotEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Frames'),
                                ListView.separated(
                                    itemBuilder: (context, index) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                  text: payment
                                                      .productList![index]
                                                      .brandName,
                                                  children: [
                                                    TextSpan(
                                                        text: ' @' +
                                                            payment
                                                                .productList![
                                                                    index]
                                                                .price
                                                                .toString()
                                                                .toCurrency!,
                                                        children: [
                                                          TextSpan(
                                                              text: '  x' +
                                                                  payment
                                                                      .productList![
                                                                          index]
                                                                      .qty
                                                                      .toString())
                                                        ]),
                                                  ],
                                                  style: TextStyle(
                                                      color: PdfColors.black,
                                                      fontSize: 10)),
                                            ),
                                            Text(
                                                '${computeMedTotal(payment.productList![index])}')
                                          ],
                                        ),
                                    separatorBuilder: (context, index) =>
                                        Divider(height: 1),
                                    itemCount: payment.productList!.length),
                              ],
                            )
                          : Container(),
                      SizedBox(height: 4),
                      payment.lensList!.isNotEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Lens'),
                                ListView.separated(
                                    itemBuilder: (context, index) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                  text: payment.lensList![index]
                                                      .brandName,
                                                  children: [
                                                    TextSpan(
                                                        text: ' @' +
                                                            payment
                                                                .lensList![
                                                                    index]
                                                                .price
                                                                .toString()
                                                                .toCurrency!,
                                                        children: [
                                                          TextSpan(
                                                              text: '  x' +
                                                                  payment
                                                                      .lensList![
                                                                          index]
                                                                      .qty
                                                                      .toString())
                                                        ]),
                                                  ],
                                                  style: TextStyle(
                                                      color: PdfColors.black,
                                                      fontSize: 10)),
                                            ),
                                            Text(
                                                '${computeLensTotal(payment.lensList![index])}')
                                          ],
                                        ),
                                    separatorBuilder: (context, index) =>
                                        Divider(height: 1),
                                    itemCount: payment.lensList!.length),
                              ],
                            )
                          : Container(),
                      Divider(
                        height: 1,
                        color: PdfColors.grey,
                        thickness: 1,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Optical Note SubTotal: '),
                          Text(payment.opticalNoteSubTotal
                              .toString()
                              .toCurrency!, style: TextStyle(fontSize: 11, font: Font.ttf(fontData))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Balance Note SubTotal: '),
                          Text(payment.balanceNoteSubTotal
                              .toString()
                              .toCurrency!, style: TextStyle(font: Font.ttf(fontData))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Frame SubTotal: '),
                          Text(payment.productSubTotal.toString().toCurrency!, style: TextStyle(font: Font.ttf(fontData))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Lens SubTotal: '),
                          Text(payment.lensSubTotal.toString().toCurrency!, style: TextStyle(font: Font.ttf(fontData))),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(
                        height: 1,
                        color: PdfColors.grey,
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Amount Due: '),
                            Text(payment.totalAmount.toString().toCurrency!, style: TextStyle(font: Font.ttf(fontData))),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Deposit: '),
                          Text(payment.deposit.toString().toCurrency!, style: TextStyle(font: Font.ttf(fontData))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Balance: '),
                          Text(payment.balance.toString().toCurrency!, style: TextStyle(font: Font.ttf(fontData))),
                        ],
                      ),
                      Divider(
                        height: 1,
                        color: PdfColors.grey,
                        thickness: 2,
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: RichText(
                            text: TextSpan(
                                text: 'Ref. No.: ',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: PdfColors.black,
                                    fontWeight: FontWeight.bold),
                                children: [
                              TextSpan(
                                  text: payment.payment_id,
                                  style: TextStyle(
                                      color: PdfColors.black,
                                      fontWeight: FontWeight.normal))
                            ])),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Column(
                          children: [
                            Text('DR. RICA ANGELIQUE PLAZA',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: PdfColors.black,
                                    fontWeight: FontWeight.bold)),
                            Text('SIGNATURE',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: PdfColors.black,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: pw.Image(
                            pw.MemoryImage(logo.buffer.asUint8List()),
                            width: 20,
                            height: 20),
                      ),
                      Center(child: Text('EyeChoice Optical Shop',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: PdfColors.black,
                                    fontWeight: FontWeight.bold))),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ]),
    );

    return pdf.save();
  }

  String computeMedTotal(Product product) {
    int qty = int.parse(product.qty!);
    double price = double.parse(product.price!);
    return (qty * price).toString().toCurrency!;
  }

  String computeLensTotal(Lens lens) {
    int qty = int.parse(lens.qty!);
    double price = double.parse(lens.price!);
    return (qty * price).toString().toCurrency!;
  }

  @override
  Future<Uint8List> printOpticalCertificate(
      {required OpticalCertificate opticalCertificate,
      required Patient patient}) {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Container(
          height: PdfPageFormat.a4.height,
          width: PdfPageFormat.a4.width,
          child: pw.Column(children: [
            pw.Text('EyeChoice Optical Shop',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                )),
            pw.Text('Tagbilaran City, Bohol',
                style: pw.TextStyle(
                  fontSize: 13,
                )),
            pw.SizedBox(height: 25),
            pw.Container(
              alignment: pw.Alignment.centerLeft,
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Dr. Rica Angelique Plaza',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 13,
                            )),
                      ]),
                  pw.Text('Optometrist',
                      style: pw.TextStyle(
                        fontSize: 12,
                      )),
                  pw.SizedBox(height: 4),
                ],
              ),
            ),
            pw.Divider(
              thickness: 2,
              color: PdfColor.fromHex("#000000"),
            ),
            pw.SizedBox(height: 20),
            pw.Align(
                child: pw.Text('OPTICAL CERTIFICATE',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ))),
            pw.SizedBox(height: 20),
            pw.Expanded(
              child: pw.Column(children: [
                pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('To whom it may concern:',
                          style: pw.TextStyle(
                            fontSize: 12,
                          )),
                      pw.SizedBox(height: 8),
                      pw.Wrap(spacing: 4, runSpacing: 4, children: [
                        pw.Text('This is to certify that patient ',
                            style: pw.TextStyle(
                              fontSize: 12,
                            )),
                        pw.Text('${patient.firstName}, ${patient.lastName} ',
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.Text('has undergone the service - ',
                            style: pw.TextStyle(
                              fontSize: 12,
                            )),
                        pw.Text('${opticalCertificate.service.toUpperCase()} ',
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.Text('on ',
                            style: pw.TextStyle(
                              fontSize: 12,
                            )),
                        pw.Text(
                            '${DateFormat.yMMMd().format(opticalCertificate.date.toDateTime()!).toUpperCase()}. ',
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            )),
                      ]),
                    ],
                  ),
                ),
              ]),
            ),
            pw.Align(
                alignment: pw.Alignment.bottomRight,
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Container(
                        padding: pw.EdgeInsets.all(4),
                        decoration: pw.BoxDecoration(
                            border: pw.Border(
                                bottom: pw.BorderSide(
                                    width: 1,
                                    color: PdfColor.fromHex("#000000")))),
                        child: pw.Text('DR. RICA ANGELIQUE PLAZA'),
                      ),
                      pw.Text('SIGNATURE')
                    ])),
            pw.SizedBox(height: 20),
            pw.Divider(
              thickness: 2,
              color: PdfColor.fromHex("#000000"),
            ),
          ]),
        ),
      ),
    );

    return pdf.save();
  }

  @override
  Future<Uint8List> printPrescription(
      {required Prescription prescription, required Patient patient}) {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(
            4 * PdfPageFormat.inch, 7 * PdfPageFormat.inch,
            marginAll: 0.2 * PdfPageFormat.cm),
        build: (pw.Context context) {
          return pw.Container(
            height: PdfPageFormat.a4.height,
            width: PdfPageFormat.a4.width,
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Text('EyeChoice Optical Shop',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 14,
                    )),
                pw.Text('Tagbilaran City, Bohol',
                    style: pw.TextStyle(
                      fontSize: 13,
                    )),
                pw.SizedBox(height: 15),
                pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text('Dr. Rica Angelique Plaza',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 13,
                                  )),
                            ]),
                        pw.Text('Optometrist',
                            style: pw.TextStyle(
                              fontSize: 12,
                            )),
                        pw.SizedBox(height: 4),
                        pw.Text(
                            'Date: ${DateFormat.yMMMd().add_jm().format(prescription.date.toDateTime()!)}',
                            style: pw.TextStyle(
                              fontSize: 12,
                            )),
                      ]),
                ),
                pw.Divider(
                  thickness: 2,
                  color: PdfColor.fromHex("#000000"),
                ),
                pw.Expanded(
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Patient Name: ${patient.fullName}'),
                        pw.Text('Address: ${patient.address}'),
                        pw.Text('Contact #: ${patient.phoneNum}'),
                        pw.SizedBox(height: 8),
                        pw.Text('Rx',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 24,
                            )),
                        pw.ListView.separated(
                          itemBuilder: (context, index) => pw.Container(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      prescription
                                          .prescriptionItems[index].inscription,
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      'Disp. ' +
                                          prescription.prescriptionItems[index]
                                              .subscription,
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    pw.Text(
                                      'Sig. ' +
                                          prescription.prescriptionItems[index]
                                              .signatura,
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ])),
                          separatorBuilder: (context, index) =>
                              pw.SizedBox(height: 5),
                          itemCount: prescription.prescriptionItems.length,
                        ),
                      ]),
                ),
                pw.Align(
                    alignment: pw.Alignment.bottomRight,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Container(
                            padding: pw.EdgeInsets.all(4),
                            decoration: pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(
                                        width: 1,
                                        color: PdfColor.fromHex("#000000")))),
                            child: pw.Text('DR. RICA ANGELIQUE PLAZA'),
                          ),
                          pw.Text('SIGNATURE')
                        ]))
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  // Future<void> savePdfFile(
  //     {required String fileName, required Uint8List byteList}) async {
  //   final output = await getExternalStorageDirectory();
  //   var filePath = "${output!.path}/$fileName.pdf";
  //   final file = File(filePath);
  //   await file.writeAsBytes(byteList);
  //   await OpenFile.open(filePath);
  // }

  // Future<void> savedPdfFile({required Uint8List byteList}) async{
  //   final blob = html.Blob([byteList], 'application/pdf');
  //   final url = html.Url.createObjectUrlFromBlob(blob);
  //
  //   final anchor = html.document.createElement('a') as html.AnchorElement;
  //   anchor.href = url;
  //   anchor.target = '_blank';
  //   anchor.click();
  //

  @override
  Future<void> savePdfFile({required Uint8List byteList}) async {
    final blob = html.Blob([byteList], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.document.createElement('a') as html.AnchorElement;
    anchor.href = url;
    anchor.target = '_blank';
    anchor.click();
  }

  @override
  Future<void> savePdfFile2(
      {required String fileName, required Uint8List byteList}) async {
    final output = await getExternalStorageDirectory();
    var filePath = "${output!.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
  }

  // @override
  // Future<Uint8List> printOpticalReceipt({required Uint8List byteList}) {
  //     Uint8List? imageData = captureWidget();
  //     File? pdfData = saveAsPdf(imageData);
  //
  //   return pdf.save();
  // }
}
