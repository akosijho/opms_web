import 'dart:io';
import 'dart:typed_data';

import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/ui/views/receipt_view/receipt_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stacked/stacked.dart';

import '../../../models/payment/payment.dart';

class ReceiptView extends StatelessWidget {
  final Payment payment;
  final bool showAppBar;

  const ReceiptView({Key? key, required this.payment, required this.showAppBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReceiptViewModel>.nonReactive(
      viewModelBuilder: () => ReceiptViewModel(payment),
      builder: (context, model, widget) => Scaffold(
        appBar:  showAppBar ? AppBar(
          title: Text('Payment Complete'),
        ) : null,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Palettes.kcBlueMain1,
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width - 20,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        // onPressed: () => model.downloadReceipt(
                        //     MediaQuery.of(context).devicePixelRatio,
                        //     payment.payment_id),
                        onPressed: () async {
                          // Uint8List? imageData = await model.captureWidget();
                          await model.saveAsPdf();
                          // model.openPdf(pdfFile);
                        },
                        icon: Icon(Icons.download),
                        label: Text('Download pdf'),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: TextButton.icon(
                    //     onPressed: () => model.downloadReceipt(
                    //         MediaQuery.of(context).devicePixelRatio,
                    //         payment.payment_id),
                    //     icon: Icon(Icons.download),
                    //     label: Text('Download pdf'),
                    //     style: TextButton.styleFrom(
                    //       primary: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                RepaintBoundary(
                  key: model.globalKey,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 20,
                          color: Colors.green,
                        ),
                        Text(
                          'Successfully Recorded the payment of patient',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            '${payment.patient_name}',
                            style: TextStyle(
                              color: Palettes.kcDarkerBlueMain1,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        payment.opticalNote!.isNotEmpty
                            ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Text('Optical Service'),
                            ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) => Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: payment
                                              .opticalNote![index]
                                              .service
                                              .serviceName,
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
                                              color: Colors.black,
                                              fontSize: 12)),
                                    ),
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
                          color: Colors.grey,
                        ),
                        SizedBox(height: 4),
                        payment.productList!.isNotEmpty
                            ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Frames'),
                            ListView.separated(
                                shrinkWrap: true,
                                primary: false,
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
                                              color: Colors.black,
                                              overflow:
                                              TextOverflow.fade,
                                              fontSize: 10)),
                                    ),
                                    Text(
                                        '${model.computeMedTotal(payment.productList![index])}')
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
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) => Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: payment
                                              .lensList![index]
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
                                              color: Colors.black,
                                              overflow:
                                              TextOverflow.fade,
                                              fontSize: 10)),
                                    ),
                                    Text(
                                        '${model.computeLensTotal(payment.lensList![index])}')
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
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Optical Note SubTotal: '),
                            Text(payment.opticalNoteSubTotal
                                .toString()
                                .toCurrency!),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Balance Note SubTotal: '),
                            Text(payment.balanceNoteSubTotal
                                .toString()
                                .toCurrency!),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Frame SubTotal: '),
                            Text(
                                payment.productSubTotal.toString().toCurrency!),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Lens SubTotal: '),
                            Text(payment.lensSubTotal.toString().toCurrency!),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Amount Due: '),
                              Text(payment.totalAmount.toString().toCurrency!),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Deposit: '),
                            Text(payment.deposit.toString().toCurrency!),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Balance: '),
                            Text(payment.balance.toString().toCurrency!),
                          ],
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                          thickness: 2,
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: RichText(
                              text: TextSpan(
                                  text: 'Ref. No.: ',
                                  style: TextStyle(
                                    // fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                        text: payment.payment_id,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal))
                                  ])),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Column(
                            children: [
                              Text('DR. RICA ANGELIQUE PLAZA'),
                              Text('SIGNATURE')
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Image.asset(
                            'assets/icons/logo1.png',
                            height: 40,
                            width: 40,
                          ),
                        ),
                        Center(child: Text('EyeChoice Optical Shop')),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                ClipPath(
                  clipper: MultipleRoundedCurveClipper(),
                  child: Container(
                    height: 20,
                    color: Colors.white,
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
