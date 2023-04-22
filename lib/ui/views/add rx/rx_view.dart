import 'package:flutter/material.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/models/payment/payment.dart';
import 'package:opmswebstaff/ui/views/add%20rx/rx_view_model.dart';
import 'package:stacked/stacked.dart';

class RxView extends StatelessWidget {
  RxView({Key? key, required this.payment}) : super(key: key);
  final Payment payment;

  // DentalNotes? notes;

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RxViewModel>.reactive(
        viewModelBuilder: () => RxViewModel(),
        disposeViewModel: false,
        // onModelReady: (model) => model.init(),
        // onModelReady: (model) => model.init(notes),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Patient's RX Record",
                style: TextStyle(fontSize: 20),
              ),
            ),
            //extendBodyBehindAppBar: true,
            body: Form(
              key: model.setDentalNoteFormKey,
              child: ListView(
                padding: EdgeInsets.all(8),
                children: [
                  // Text(
                  //   'Selected ${selectedTeeth.length > 1 ? 'Teeth' : 'Tooth'}: ',
                  //   style: TextStyles.tsButton1(),
                  // ),
                  // SizedBox(height: 3),
                  // Container(
                  //   padding: EdgeInsets.all(8),
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.shade100,
                  //     border: Border.all(color: Palettes.kcNeutral1, width: 2),
                  //   ),
                  //   child: GridView.builder(
                  //     shrinkWrap: true,
                  //     primary: false,
                  //     itemCount: selectedTeeth.length,
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 10,
                  //       mainAxisExtent: 30,
                  //       crossAxisSpacing: 4,
                  //       mainAxisSpacing: 4,
                  //     ),
                  //     itemBuilder: (context, index) => Container(
                  //       height: 30,
                  //       width: 30,
                  //       alignment: Alignment.center,
                  //       color: Colors.blue,
                  //       child: Text(
                  //         selectedTeeth[index],
                  //         style: TextStyles.tsHeading4(color: Colors.white),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 8),
                  Container(
                    // padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2)),
                    child: Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 49,
                            decoration:
                                const BoxDecoration(color: Palettes.kcBlueMain1),
                            child: const Center(
                                child: Text(
                              "RX SPECTACLE",
                              style: TextStyle(
                              color: Colors.white,
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ))),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Table(
                            //defaultColumnWidth: FixedColumnWidth(120.0),
                            border: TableBorder.all(
                                color: Colors.black,
                                //style: BorderStyle.solid,
                                width: 1),
                            children: [
                              TableRow(children: [
                                Column(children: [
                                  Text(
                                    'OD\n/\nOS',
                                    textAlign: TextAlign.center,
                                  )
                                ]),
                                Column(children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(top: 3.0),
                                        child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text('Sphere',
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                                SizedBox(height: 6),
                                                Text(
                                                  payment
                                                      .dentalNote![index].sphere,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                )
                                                // TextFormField(
                                                //
                                                //   textInputAction:
                                                //       TextInputAction.done,
                                                //   minLines: 1,
                                                //   maxLines: 2,
                                                //   keyboardType:
                                                //       TextInputType.multiline,
                                                //   controller: payment.dentalNote![index].sphere,
                                                //   // ListView.separated(
                                                //   //     shrinkWrap: true,
                                                //   //     primary: false,
                                                //   //     itemBuilder: (context, index) => Row(
                                                //   //       mainAxisAlignment:
                                                //   //       MainAxisAlignment.spaceBetween,
                                                //   //       children: [
                                                //   //         RichText(
                                                //   //           text: TextSpan(
                                                //   //               text: payment
                                                //   //                   .dentalNote![index]
                                                //   //                   .procedure
                                                //   //                   .procedureName,
                                                //   //               // children: [
                                                //   //               //   TextSpan(
                                                //   //               //     text: ' @tooth#' +
                                                //   //               //         payment
                                                //   //               //             .dentalNote![
                                                //   //               //                 index]
                                                //   //               //             .sphere,
                                                //   //               //   )
                                                //   //               // ],
                                                //   //               style: TextStyle(
                                                //   //                 color: Colors.black,
                                                //   //               )),
                                                //   //         ),
                                                //   //         Text(payment.dentalNote![index]
                                                //   //             .procedure.price!
                                                //   //             .toString()
                                                //   //             .toCurrency!),
                                                //   //       ],
                                                //   //     ),
                                                //   //     separatorBuilder: (context, index) =>
                                                //   //         Divider(height: 1),
                                                //   //     itemCount: payment.dentalNote!.length),
                                                //
                                                //   // model.currentUser!.email,
                                                //   decoration:
                                                //       const InputDecoration(
                                                //     //prefixIcon: Icon(Icons.mail),
                                                //     contentPadding:
                                                //         EdgeInsets.only(
                                                //             top: 10, left: 4),
                                                //     labelText: 'Sphere',
                                                //     // enabledBorder: UnderlineInputBorder(
                                                //     //     borderSide: BorderSide(
                                                //     //         color: Color(0xffADADAD))),
                                                //     // focusedBorder: UnderlineInputBorder(
                                                //     //     borderSide:
                                                //     //     BorderSide(color: Colors.blue)),
                                                //
                                                //     border: InputBorder.none,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          Divider(height: 1),
                                      itemCount: payment.dentalNote!.length)
                                  // itemCount: payment.dentalNote!.length)
                                ]),
                                Column(children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(top: 3.0),
                                        child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Cylinder',
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                                SizedBox(height: 6),
                                                Text(
                                                  payment.dentalNote![index]
                                                      .cylinder,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                )
                                                // TextFormField(
                                                //
                                                //   textInputAction:
                                                //       TextInputAction.done,
                                                //   minLines: 1,
                                                //   maxLines: 2,
                                                //   keyboardType:
                                                //       TextInputType.multiline,
                                                //   controller: payment.dentalNote![index].sphere,
                                                //   // ListView.separated(
                                                //   //     shrinkWrap: true,
                                                //   //     primary: false,
                                                //   //     itemBuilder: (context, index) => Row(
                                                //   //       mainAxisAlignment:
                                                //   //       MainAxisAlignment.spaceBetween,
                                                //   //       children: [
                                                //   //         RichText(
                                                //   //           text: TextSpan(
                                                //   //               text: payment
                                                //   //                   .dentalNote![index]
                                                //   //                   .procedure
                                                //   //                   .procedureName,
                                                //   //               // children: [
                                                //   //               //   TextSpan(
                                                //   //               //     text: ' @tooth#' +
                                                //   //               //         payment
                                                //   //               //             .dentalNote![
                                                //   //               //                 index]
                                                //   //               //             .sphere,
                                                //   //               //   )
                                                //   //               // ],
                                                //   //               style: TextStyle(
                                                //   //                 color: Colors.black,
                                                //   //               )),
                                                //   //         ),
                                                //   //         Text(payment.dentalNote![index]
                                                //   //             .procedure.price!
                                                //   //             .toString()
                                                //   //             .toCurrency!),
                                                //   //       ],
                                                //   //     ),
                                                //   //     separatorBuilder: (context, index) =>
                                                //   //         Divider(height: 1),
                                                //   //     itemCount: payment.dentalNote!.length),
                                                //
                                                //   // model.currentUser!.email,
                                                //   decoration:
                                                //       const InputDecoration(
                                                //     //prefixIcon: Icon(Icons.mail),
                                                //     contentPadding:
                                                //         EdgeInsets.only(
                                                //             top: 10, left: 4),
                                                //     labelText: 'Sphere',
                                                //     // enabledBorder: UnderlineInputBorder(
                                                //     //     borderSide: BorderSide(
                                                //     //         color: Color(0xffADADAD))),
                                                //     // focusedBorder: UnderlineInputBorder(
                                                //     //     borderSide:
                                                //     //     BorderSide(color: Colors.blue)),
                                                //
                                                //     border: InputBorder.none,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          Divider(height: 1),
                                      itemCount: payment.dentalNote!.length)
                                  // TextFormField(
                                  //   // textInputAction: TextInputAction.done,
                                  //   textAlign: TextAlign.start,
                                  //   minLines: 1,
                                  //   maxLines: 2,
                                  //   keyboardType: TextInputType.multiline,
                                  //   // controller: model.cylinder,
                                  //   decoration: const InputDecoration(
                                  //     contentPadding:
                                  //         EdgeInsets.only(top: 10, left: 4),
                                  //     labelText: 'Cylinder',
                                  //     // enabledBorder: UnderlineInputBorder(
                                  //     //     borderSide: BorderSide(
                                  //     //         color: Color(0xffADADAD))),
                                  //     // focusedBorder: UnderlineInputBorder(
                                  //     //     borderSide:
                                  //     //     BorderSide(color: Colors.blue)),
                                  //     border: InputBorder.none,
                                  //   ),
                                  // ),
                                ]),
                                Column(children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(top: 3.0),
                                        child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Axis',
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                                SizedBox(height: 6),
                                                Text(
                                                  payment.dentalNote![index].axis,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                )
                                                // TextFormField(
                                                //
                                                //   textInputAction:
                                                //       TextInputAction.done,
                                                //   minLines: 1,
                                                //   maxLines: 2,
                                                //   keyboardType:
                                                //       TextInputType.multiline,
                                                //   controller: payment.dentalNote![index].sphere,
                                                //   // ListView.separated(
                                                //   //     shrinkWrap: true,
                                                //   //     primary: false,
                                                //   //     itemBuilder: (context, index) => Row(
                                                //   //       mainAxisAlignment:
                                                //   //       MainAxisAlignment.spaceBetween,
                                                //   //       children: [
                                                //   //         RichText(
                                                //   //           text: TextSpan(
                                                //   //               text: payment
                                                //   //                   .dentalNote![index]
                                                //   //                   .procedure
                                                //   //                   .procedureName,
                                                //   //               // children: [
                                                //   //               //   TextSpan(
                                                //   //               //     text: ' @tooth#' +
                                                //   //               //         payment
                                                //   //               //             .dentalNote![
                                                //   //               //                 index]
                                                //   //               //             .sphere,
                                                //   //               //   )
                                                //   //               // ],
                                                //   //               style: TextStyle(
                                                //   //                 color: Colors.black,
                                                //   //               )),
                                                //   //         ),
                                                //   //         Text(payment.dentalNote![index]
                                                //   //             .procedure.price!
                                                //   //             .toString()
                                                //   //             .toCurrency!),
                                                //   //       ],
                                                //   //     ),
                                                //   //     separatorBuilder: (context, index) =>
                                                //   //         Divider(height: 1),
                                                //   //     itemCount: payment.dentalNote!.length),
                                                //
                                                //   // model.currentUser!.email,
                                                //   decoration:
                                                //       const InputDecoration(
                                                //     //prefixIcon: Icon(Icons.mail),
                                                //     contentPadding:
                                                //         EdgeInsets.only(
                                                //             top: 10, left: 4),
                                                //     labelText: 'Sphere',
                                                //     // enabledBorder: UnderlineInputBorder(
                                                //     //     borderSide: BorderSide(
                                                //     //         color: Color(0xffADADAD))),
                                                //     // focusedBorder: UnderlineInputBorder(
                                                //     //     borderSide:
                                                //     //     BorderSide(color: Colors.blue)),
                                                //
                                                //     border: InputBorder.none,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          Divider(height: 1),
                                      itemCount: payment.dentalNote!.length)
                                  // TextFormField(
                                  //   // textInputAction: TextInputAction.done,
                                  //   textAlign: TextAlign.start,
                                  //   minLines: 1,
                                  //   maxLines: 2,
                                  //   keyboardType: TextInputType.multiline,
                                  //   // controller: model.axis,
                                  //   decoration: const InputDecoration(
                                  //     contentPadding:
                                  //         EdgeInsets.only(top: 10, left: 4),
                                  //     labelText: 'Axis',
                                  //     // enabledBorder: UnderlineInputBorder(
                                  //     //     borderSide: BorderSide(
                                  //     //         color: Color(0xffADADAD))),
                                  //     // focusedBorder: UnderlineInputBorder(
                                  //     //     borderSide:
                                  //     //     BorderSide(color: Colors.blue)),
                                  //     border: InputBorder.none,
                                  //   ),
                                  // ),
                                ]),
                                Column(children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(top: 3.0),
                                        child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('PD',
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                                SizedBox(height: 6),
                                                Text(
                                                  payment.dentalNote![index].pd,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                )
                                                // Text(
                                                //   payment.dentalNote![index].axis,
                                                //   style: TextStyle(
                                                //     color: Colors.black, fontSize: 10
                                                //   ),
                                                // )
                                                // TextFormField(
                                                //
                                                //   textInputAction:
                                                //       TextInputAction.done,
                                                //   minLines: 1,
                                                //   maxLines: 2,
                                                //   keyboardType:
                                                //       TextInputType.multiline,
                                                //   controller: payment.dentalNote![index].sphere,
                                                //   // ListView.separated(
                                                //   //     shrinkWrap: true,
                                                //   //     primary: false,
                                                //   //     itemBuilder: (context, index) => Row(
                                                //   //       mainAxisAlignment:
                                                //   //       MainAxisAlignment.spaceBetween,
                                                //   //       children: [
                                                //   //         RichText(
                                                //   //           text: TextSpan(
                                                //   //               text: payment
                                                //   //                   .dentalNote![index]
                                                //   //                   .procedure
                                                //   //                   .procedureName,
                                                //   //               // children: [
                                                //   //               //   TextSpan(
                                                //   //               //     text: ' @tooth#' +
                                                //   //               //         payment
                                                //   //               //             .dentalNote![
                                                //   //               //                 index]
                                                //   //               //             .sphere,
                                                //   //               //   )
                                                //   //               // ],
                                                //   //               style: TextStyle(
                                                //   //                 color: Colors.black,
                                                //   //               )),
                                                //   //         ),
                                                //   //         Text(payment.dentalNote![index]
                                                //   //             .procedure.price!
                                                //   //             .toString()
                                                //   //             .toCurrency!),
                                                //   //       ],
                                                //   //     ),
                                                //   //     separatorBuilder: (context, index) =>
                                                //   //         Divider(height: 1),
                                                //   //     itemCount: payment.dentalNote!.length),
                                                //
                                                //   // model.currentUser!.email,
                                                //   decoration:
                                                //       const InputDecoration(
                                                //     //prefixIcon: Icon(Icons.mail),
                                                //     contentPadding:
                                                //         EdgeInsets.only(
                                                //             top: 10, left: 4),
                                                //     labelText: 'Sphere',
                                                //     // enabledBorder: UnderlineInputBorder(
                                                //     //     borderSide: BorderSide(
                                                //     //         color: Color(0xffADADAD))),
                                                //     // focusedBorder: UnderlineInputBorder(
                                                //     //     borderSide:
                                                //     //     BorderSide(color: Colors.blue)),
                                                //
                                                //     border: InputBorder.none,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          Divider(height: 1),
                                      itemCount: payment.dentalNote!.length)
                                ]),
                                Column(children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(top: 3.0),
                                        child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('ADD',
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                                SizedBox(height: 6),
                                                Text(
                                                  payment.dentalNote![index].add,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                )
                                                // Text(
                                                //   payment.dentalNote![index].axis,
                                                //   style: TextStyle(
                                                //     color: Colors.black,
                                                //   ),
                                                // )
                                                // TextFormField(
                                                //
                                                //   textInputAction:
                                                //       TextInputAction.done,
                                                //   minLines: 1,
                                                //   maxLines: 2,
                                                //   keyboardType:
                                                //       TextInputType.multiline,
                                                //   controller: payment.dentalNote![index].sphere,
                                                //   // ListView.separated(
                                                //   //     shrinkWrap: true,
                                                //   //     primary: false,
                                                //   //     itemBuilder: (context, index) => Row(
                                                //   //       mainAxisAlignment:
                                                //   //       MainAxisAlignment.spaceBetween,
                                                //   //       children: [
                                                //   //         RichText(
                                                //   //           text: TextSpan(
                                                //   //               text: payment
                                                //   //                   .dentalNote![index]
                                                //   //                   .procedure
                                                //   //                   .procedureName,
                                                //   //               // children: [
                                                //   //               //   TextSpan(
                                                //   //               //     text: ' @tooth#' +
                                                //   //               //         payment
                                                //   //               //             .dentalNote![
                                                //   //               //                 index]
                                                //   //               //             .sphere,
                                                //   //               //   )
                                                //   //               // ],
                                                //   //               style: TextStyle(
                                                //   //                 color: Colors.black,
                                                //   //               )),
                                                //   //         ),
                                                //   //         Text(payment.dentalNote![index]
                                                //   //             .procedure.price!
                                                //   //             .toString()
                                                //   //             .toCurrency!),
                                                //   //       ],
                                                //   //     ),
                                                //   //     separatorBuilder: (context, index) =>
                                                //   //         Divider(height: 1),
                                                //   //     itemCount: payment.dentalNote!.length),
                                                //
                                                //   // model.currentUser!.email,
                                                //   decoration:
                                                //       const InputDecoration(
                                                //     //prefixIcon: Icon(Icons.mail),
                                                //     contentPadding:
                                                //         EdgeInsets.only(
                                                //             top: 10, left: 4),
                                                //     labelText: 'Sphere',
                                                //     // enabledBorder: UnderlineInputBorder(
                                                //     //     borderSide: BorderSide(
                                                //     //         color: Color(0xffADADAD))),
                                                //     // focusedBorder: UnderlineInputBorder(
                                                //     //     borderSide:
                                                //     //     BorderSide(color: Colors.blue)),
                                                //
                                                //     border: InputBorder.none,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          Divider(height: 1),
                                      itemCount: payment.dentalNote!.length)
                                ]),
                                Column(children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(top: 3.0),
                                        child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('V.A',
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                                SizedBox(height: 6),
                                                Text(
                                                  payment.dentalNote![index].va,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                )
                                                // Text(
                                                //   payment.dentalNote![index].axis,
                                                //   style: TextStyle(
                                                //     color: Colors.black,
                                                //   ),
                                                // )
                                                // TextFormField(
                                                //
                                                //   textInputAction:
                                                //       TextInputAction.done,
                                                //   minLines: 1,
                                                //   maxLines: 2,
                                                //   keyboardType:
                                                //       TextInputType.multiline,
                                                //   controller: payment.dentalNote![index].sphere,
                                                //   // ListView.separated(
                                                //   //     shrinkWrap: true,
                                                //   //     primary: false,
                                                //   //     itemBuilder: (context, index) => Row(
                                                //   //       mainAxisAlignment:
                                                //   //       MainAxisAlignment.spaceBetween,
                                                //   //       children: [
                                                //   //         RichText(
                                                //   //           text: TextSpan(
                                                //   //               text: payment
                                                //   //                   .dentalNote![index]
                                                //   //                   .procedure
                                                //   //                   .procedureName,
                                                //   //               // children: [
                                                //   //               //   TextSpan(
                                                //   //               //     text: ' @tooth#' +
                                                //   //               //         payment
                                                //   //               //             .dentalNote![
                                                //   //               //                 index]
                                                //   //               //             .sphere,
                                                //   //               //   )
                                                //   //               // ],
                                                //   //               style: TextStyle(
                                                //   //                 color: Colors.black,
                                                //   //               )),
                                                //   //         ),
                                                //   //         Text(payment.dentalNote![index]
                                                //   //             .procedure.price!
                                                //   //             .toString()
                                                //   //             .toCurrency!),
                                                //   //       ],
                                                //   //     ),
                                                //   //     separatorBuilder: (context, index) =>
                                                //   //         Divider(height: 1),
                                                //   //     itemCount: payment.dentalNote!.length),
                                                //
                                                //   // model.currentUser!.email,
                                                //   decoration:
                                                //       const InputDecoration(
                                                //     //prefixIcon: Icon(Icons.mail),
                                                //     contentPadding:
                                                //         EdgeInsets.only(
                                                //             top: 10, left: 4),
                                                //     labelText: 'Sphere',
                                                //     // enabledBorder: UnderlineInputBorder(
                                                //     //     borderSide: BorderSide(
                                                //     //         color: Color(0xffADADAD))),
                                                //     // focusedBorder: UnderlineInputBorder(
                                                //     //     borderSide:
                                                //     //     BorderSide(color: Colors.blue)),
                                                //
                                                //     border: InputBorder.none,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          Divider(height: 1),
                                      itemCount: payment.dentalNote!.length)
                                ]),
                              ]),
                              // TableRow(children: [
                              //   Column(children: [Text('LEFT\n(OS)')]),
                              //   Column(children: [
                              //     TextFormField(
                              //       textAlign: TextAlign.start,
                              //       minLines: 1,
                              //       maxLines: 2,
                              //       keyboardType: TextInputType.multiline,
                              //       // controller: model.specl1,
                              //       decoration: const InputDecoration(
                              //         contentPadding:
                              //         EdgeInsets.only(top: 10, left: 4),
                              //         //labelText: 'Lens Tint',
                              //         //hintText: 'Enter Email',
                              //         enabledBorder: UnderlineInputBorder(
                              //             borderSide: BorderSide(
                              //                 color: Color(0xffADADAD))),
                              //         focusedBorder: UnderlineInputBorder(
                              //             borderSide:
                              //             BorderSide(color: Colors.blue)),
                              //
                              //         border: InputBorder.none,
                              //       ),
                              //     ),
                              //   ]),
                              //   Column(children: [
                              //     TextFormField(
                              //       textAlign: TextAlign.start,
                              //       minLines: 1,
                              //       maxLines: 2,
                              //       keyboardType: TextInputType.multiline,
                              //       // controller: model.specl2,
                              //       decoration: const InputDecoration(
                              //         contentPadding:
                              //         EdgeInsets.only(top: 10, left: 4),
                              //         //labelText: 'Lens Tint',
                              //         //hintText: 'Enter Email',
                              //         enabledBorder: UnderlineInputBorder(
                              //             borderSide: BorderSide(
                              //                 color: Color(0xffADADAD))),
                              //         focusedBorder: UnderlineInputBorder(
                              //             borderSide:
                              //             BorderSide(color: Colors.blue)),
                              //
                              //         border: InputBorder.none,
                              //       ),
                              //     ),
                              //   ]),
                              //   Column(children: [
                              //     TextFormField(
                              //       textAlign: TextAlign.start,
                              //       minLines: 1,
                              //       maxLines: 2,
                              //       keyboardType: TextInputType.multiline,
                              //       // controller: model.specl3,
                              //       decoration: const InputDecoration(
                              //         contentPadding:
                              //         EdgeInsets.only(top: 10, left: 4),
                              //         //labelText: 'Lens Tint',
                              //         //hintText: 'Enter Email',
                              //         enabledBorder: UnderlineInputBorder(
                              //             borderSide: BorderSide(
                              //                 color: Color(0xffADADAD))),
                              //         focusedBorder: UnderlineInputBorder(
                              //             borderSide:
                              //             BorderSide(color: Colors.blue)),
                              //
                              //         border: InputBorder.none,
                              //       ),
                              //     ),
                              //   ]),
                              //   Column(children: [
                              //     TextFormField(
                              //       textAlign: TextAlign.start,
                              //       minLines: 1,
                              //       maxLines: 2,
                              //       keyboardType: TextInputType.multiline,
                              //       // controller: model.specl4,
                              //       decoration: const InputDecoration(
                              //         //prefixIcon: Icon(Icons.mail),
                              //         contentPadding:
                              //         EdgeInsets.only(top: 10, left: 4),
                              //         //labelText: 'Lens Tint',
                              //         //hintText: 'Enter Email',
                              //         enabledBorder: UnderlineInputBorder(
                              //             borderSide: BorderSide(
                              //                 color: Color(0xffADADAD))),
                              //         focusedBorder: UnderlineInputBorder(
                              //             borderSide:
                              //             BorderSide(color: Colors.blue)),
                              //
                              //         border: InputBorder.none,
                              //       ),
                              //     ),
                              //   ]),
                              //   Column(children: [
                              //     TextFormField(
                              //       textAlign: TextAlign.start,
                              //       minLines: 1,
                              //       maxLines: 2,
                              //       keyboardType: TextInputType.multiline,
                              //       // controller: model.specl5,
                              //       decoration: const InputDecoration(
                              //         //prefixIcon: Icon(Icons.mail),
                              //         contentPadding:
                              //         EdgeInsets.only(top: 10, left: 4),
                              //         //labelText: 'Lens Tint',
                              //         //hintText: 'Enter Email',
                              //         enabledBorder: UnderlineInputBorder(
                              //             borderSide: BorderSide(
                              //                 color: Color(0xffADADAD))),
                              //         focusedBorder: UnderlineInputBorder(
                              //             borderSide:
                              //             BorderSide(color: Colors.blue)),
                              //
                              //         border: InputBorder.none,
                              //       ),
                              //     ),
                              //   ]),
                              //   Column(children: [
                              //     TextFormField(
                              //       textAlign: TextAlign.start,
                              //       minLines: 1,
                              //       maxLines: 2,
                              //       keyboardType: TextInputType.multiline,
                              //       // controller: model.specl6,
                              //       decoration: const InputDecoration(
                              //         //prefixIcon: Icon(Icons.mail),
                              //         contentPadding:
                              //         EdgeInsets.only(top: 10, left: 4),
                              //         //labelText: 'Lens Tint',
                              //         //hintText: 'Enter Email',
                              //         enabledBorder: UnderlineInputBorder(
                              //             borderSide: BorderSide(
                              //                 color: Color(0xffADADAD))),
                              //         focusedBorder: UnderlineInputBorder(
                              //             borderSide:
                              //             BorderSide(color: Colors.blue)),
                              //
                              //         border: InputBorder.none,
                              //       ),
                              //     ),
                              //   ]),
                              // ]),
                            ],
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 49,
                            decoration:
                                const BoxDecoration(color: Palettes.kcBlueMain1),
                            child: const Center(
                                child: Text(
                              "RX CONTACT LENS",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ))),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Table(
                            //defaultColumnWidth: FixedColumnWidth(120.0),
                            border: TableBorder.all(
                                color: Colors.black,
                                //style: BorderStyle.solid,
                                width: 1),
                            children: [
                              TableRow(children: [
                                Column(children: [
                                  Text(
                                    'OD\n/\nOS',
                                    textAlign: TextAlign.center,
                                  )
                                ]),
                                Column(children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(top: 3.0),
                                        child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Sphere',
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                                SizedBox(height: 6),
                                                Text(
                                                  payment.dentalNote![index]
                                                      .sphereCL,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                )
                                                // Text(
                                                //   payment.dentalNote![index].axis,
                                                //   style: TextStyle(
                                                //     color: Colors.black,
                                                //   ),
                                                // )
                                                // TextFormField(
                                                //
                                                //   textInputAction:
                                                //       TextInputAction.done,
                                                //   minLines: 1,
                                                //   maxLines: 2,
                                                //   keyboardType:
                                                //       TextInputType.multiline,
                                                //   controller: payment.dentalNote![index].sphere,
                                                //   // ListView.separated(
                                                //   //     shrinkWrap: true,
                                                //   //     primary: false,
                                                //   //     itemBuilder: (context, index) => Row(
                                                //   //       mainAxisAlignment:
                                                //   //       MainAxisAlignment.spaceBetween,
                                                //   //       children: [
                                                //   //         RichText(
                                                //   //           text: TextSpan(
                                                //   //               text: payment
                                                //   //                   .dentalNote![index]
                                                //   //                   .procedure
                                                //   //                   .procedureName,
                                                //   //               // children: [
                                                //   //               //   TextSpan(
                                                //   //               //     text: ' @tooth#' +
                                                //   //               //         payment
                                                //   //               //             .dentalNote![
                                                //   //               //                 index]
                                                //   //               //             .sphere,
                                                //   //               //   )
                                                //   //               // ],
                                                //   //               style: TextStyle(
                                                //   //                 color: Colors.black,
                                                //   //               )),
                                                //   //         ),
                                                //   //         Text(payment.dentalNote![index]
                                                //   //             .procedure.price!
                                                //   //             .toString()
                                                //   //             .toCurrency!),
                                                //   //       ],
                                                //   //     ),
                                                //   //     separatorBuilder: (context, index) =>
                                                //   //         Divider(height: 1),
                                                //   //     itemCount: payment.dentalNote!.length),
                                                //
                                                //   // model.currentUser!.email,
                                                //   decoration:
                                                //       const InputDecoration(
                                                //     //prefixIcon: Icon(Icons.mail),
                                                //     contentPadding:
                                                //         EdgeInsets.only(
                                                //             top: 10, left: 4),
                                                //     labelText: 'Sphere',
                                                //     // enabledBorder: UnderlineInputBorder(
                                                //     //     borderSide: BorderSide(
                                                //     //         color: Color(0xffADADAD))),
                                                //     // focusedBorder: UnderlineInputBorder(
                                                //     //     borderSide:
                                                //     //     BorderSide(color: Colors.blue)),
                                                //
                                                //     border: InputBorder.none,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          Divider(height: 1),
                                      itemCount: payment.dentalNote!.length)
                                ]),
                                Column(children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(top: 3.0),
                                        child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Cylinder',
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                                SizedBox(height: 6),
                                                Text(
                                                  payment.dentalNote![index]
                                                      .cylinderCL,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                )
                                                // Text(
                                                //   payment.dentalNote![index].axis,
                                                //   style: TextStyle(
                                                //     color: Colors.black,
                                                //   ),
                                                // )
                                                // TextFormField(
                                                //
                                                //   textInputAction:
                                                //       TextInputAction.done,
                                                //   minLines: 1,
                                                //   maxLines: 2,
                                                //   keyboardType:
                                                //       TextInputType.multiline,
                                                //   controller: payment.dentalNote![index].sphere,
                                                //   // ListView.separated(
                                                //   //     shrinkWrap: true,
                                                //   //     primary: false,
                                                //   //     itemBuilder: (context, index) => Row(
                                                //   //       mainAxisAlignment:
                                                //   //       MainAxisAlignment.spaceBetween,
                                                //   //       children: [
                                                //   //         RichText(
                                                //   //           text: TextSpan(
                                                //   //               text: payment
                                                //   //                   .dentalNote![index]
                                                //   //                   .procedure
                                                //   //                   .procedureName,
                                                //   //               // children: [
                                                //   //               //   TextSpan(
                                                //   //               //     text: ' @tooth#' +
                                                //   //               //         payment
                                                //   //               //             .dentalNote![
                                                //   //               //                 index]
                                                //   //               //             .sphere,
                                                //   //               //   )
                                                //   //               // ],
                                                //   //               style: TextStyle(
                                                //   //                 color: Colors.black,
                                                //   //               )),
                                                //   //         ),
                                                //   //         Text(payment.dentalNote![index]
                                                //   //             .procedure.price!
                                                //   //             .toString()
                                                //   //             .toCurrency!),
                                                //   //       ],
                                                //   //     ),
                                                //   //     separatorBuilder: (context, index) =>
                                                //   //         Divider(height: 1),
                                                //   //     itemCount: payment.dentalNote!.length),
                                                //
                                                //   // model.currentUser!.email,
                                                //   decoration:
                                                //       const InputDecoration(
                                                //     //prefixIcon: Icon(Icons.mail),
                                                //     contentPadding:
                                                //         EdgeInsets.only(
                                                //             top: 10, left: 4),
                                                //     labelText: 'Sphere',
                                                //     // enabledBorder: UnderlineInputBorder(
                                                //     //     borderSide: BorderSide(
                                                //     //         color: Color(0xffADADAD))),
                                                //     // focusedBorder: UnderlineInputBorder(
                                                //     //     borderSide:
                                                //     //     BorderSide(color: Colors.blue)),
                                                //
                                                //     border: InputBorder.none,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          Divider(height: 1),
                                      itemCount: payment.dentalNote!.length)
                                ]),
                                Column(children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(top: 3.0),
                                        child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Axis',
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                                SizedBox(height: 6),
                                                Text(
                                                  payment
                                                      .dentalNote![index].axisCL,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                )
                                                // Text(
                                                //   payment.dentalNote![index].axis,
                                                //   style: TextStyle(
                                                //     color: Colors.black,
                                                //   ),
                                                // )
                                                // TextFormField(
                                                //
                                                //   textInputAction:
                                                //       TextInputAction.done,
                                                //   minLines: 1,
                                                //   maxLines: 2,
                                                //   keyboardType:
                                                //       TextInputType.multiline,
                                                //   controller: payment.dentalNote![index].sphere,
                                                //   // ListView.separated(
                                                //   //     shrinkWrap: true,
                                                //   //     primary: false,
                                                //   //     itemBuilder: (context, index) => Row(
                                                //   //       mainAxisAlignment:
                                                //   //       MainAxisAlignment.spaceBetween,
                                                //   //       children: [
                                                //   //         RichText(
                                                //   //           text: TextSpan(
                                                //   //               text: payment
                                                //   //                   .dentalNote![index]
                                                //   //                   .procedure
                                                //   //                   .procedureName,
                                                //   //               // children: [
                                                //   //               //   TextSpan(
                                                //   //               //     text: ' @tooth#' +
                                                //   //               //         payment
                                                //   //               //             .dentalNote![
                                                //   //               //                 index]
                                                //   //               //             .sphere,
                                                //   //               //   )
                                                //   //               // ],
                                                //   //               style: TextStyle(
                                                //   //                 color: Colors.black,
                                                //   //               )),
                                                //   //         ),
                                                //   //         Text(payment.dentalNote![index]
                                                //   //             .procedure.price!
                                                //   //             .toString()
                                                //   //             .toCurrency!),
                                                //   //       ],
                                                //   //     ),
                                                //   //     separatorBuilder: (context, index) =>
                                                //   //         Divider(height: 1),
                                                //   //     itemCount: payment.dentalNote!.length),
                                                //
                                                //   // model.currentUser!.email,
                                                //   decoration:
                                                //       const InputDecoration(
                                                //     //prefixIcon: Icon(Icons.mail),
                                                //     contentPadding:
                                                //         EdgeInsets.only(
                                                //             top: 10, left: 4),
                                                //     labelText: 'Sphere',
                                                //     // enabledBorder: UnderlineInputBorder(
                                                //     //     borderSide: BorderSide(
                                                //     //         color: Color(0xffADADAD))),
                                                //     // focusedBorder: UnderlineInputBorder(
                                                //     //     borderSide:
                                                //     //     BorderSide(color: Colors.blue)),
                                                //
                                                //     border: InputBorder.none,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          Divider(height: 1),
                                      itemCount: payment.dentalNote!.length)
                                ]),
                                Column(children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(top: 3.0),
                                        child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('B.C',
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                                SizedBox(height: 6),
                                                Text(
                                                  payment.dentalNote![index].bcCL,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                )
                                                // Text(
                                                //   payment.dentalNote![index].axis,
                                                //   style: TextStyle(
                                                //     color: Colors.black,
                                                //   ),
                                                // )
                                                // TextFormField(
                                                //
                                                //   textInputAction:
                                                //       TextInputAction.done,
                                                //   minLines: 1,
                                                //   maxLines: 2,
                                                //   keyboardType:
                                                //       TextInputType.multiline,
                                                //   controller: payment.dentalNote![index].sphere,
                                                //   // ListView.separated(
                                                //   //     shrinkWrap: true,
                                                //   //     primary: false,
                                                //   //     itemBuilder: (context, index) => Row(
                                                //   //       mainAxisAlignment:
                                                //   //       MainAxisAlignment.spaceBetween,
                                                //   //       children: [
                                                //   //         RichText(
                                                //   //           text: TextSpan(
                                                //   //               text: payment
                                                //   //                   .dentalNote![index]
                                                //   //                   .procedure
                                                //   //                   .procedureName,
                                                //   //               // children: [
                                                //   //               //   TextSpan(
                                                //   //               //     text: ' @tooth#' +
                                                //   //               //         payment
                                                //   //               //             .dentalNote![
                                                //   //               //                 index]
                                                //   //               //             .sphere,
                                                //   //               //   )
                                                //   //               // ],
                                                //   //               style: TextStyle(
                                                //   //                 color: Colors.black,
                                                //   //               )),
                                                //   //         ),
                                                //   //         Text(payment.dentalNote![index]
                                                //   //             .procedure.price!
                                                //   //             .toString()
                                                //   //             .toCurrency!),
                                                //   //       ],
                                                //   //     ),
                                                //   //     separatorBuilder: (context, index) =>
                                                //   //         Divider(height: 1),
                                                //   //     itemCount: payment.dentalNote!.length),
                                                //
                                                //   // model.currentUser!.email,
                                                //   decoration:
                                                //       const InputDecoration(
                                                //     //prefixIcon: Icon(Icons.mail),
                                                //     contentPadding:
                                                //         EdgeInsets.only(
                                                //             top: 10, left: 4),
                                                //     labelText: 'Sphere',
                                                //     // enabledBorder: UnderlineInputBorder(
                                                //     //     borderSide: BorderSide(
                                                //     //         color: Color(0xffADADAD))),
                                                //     // focusedBorder: UnderlineInputBorder(
                                                //     //     borderSide:
                                                //     //     BorderSide(color: Colors.blue)),
                                                //
                                                //     border: InputBorder.none,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          Divider(height: 1),
                                      itemCount: payment.dentalNote!.length)
                                ]),
                                Column(children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(top: 3.0),
                                        child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('DIA',
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                                SizedBox(height: 6),
                                                Text(
                                                  payment
                                                      .dentalNote![index].diaCL,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                )
                                                // Text(
                                                //   payment.dentalNote![index].axis,
                                                //   style: TextStyle(
                                                //     color: Colors.black,
                                                //   ),
                                                // )
                                                // TextFormField(
                                                //
                                                //   textInputAction:
                                                //       TextInputAction.done,
                                                //   minLines: 1,
                                                //   maxLines: 2,
                                                //   keyboardType:
                                                //       TextInputType.multiline,
                                                //   controller: payment.dentalNote![index].sphere,
                                                //   // ListView.separated(
                                                //   //     shrinkWrap: true,
                                                //   //     primary: false,
                                                //   //     itemBuilder: (context, index) => Row(
                                                //   //       mainAxisAlignment:
                                                //   //       MainAxisAlignment.spaceBetween,
                                                //   //       children: [
                                                //   //         RichText(
                                                //   //           text: TextSpan(
                                                //   //               text: payment
                                                //   //                   .dentalNote![index]
                                                //   //                   .procedure
                                                //   //                   .procedureName,
                                                //   //               // children: [
                                                //   //               //   TextSpan(
                                                //   //               //     text: ' @tooth#' +
                                                //   //               //         payment
                                                //   //               //             .dentalNote![
                                                //   //               //                 index]
                                                //   //               //             .sphere,
                                                //   //               //   )
                                                //   //               // ],
                                                //   //               style: TextStyle(
                                                //   //                 color: Colors.black,
                                                //   //               )),
                                                //   //         ),
                                                //   //         Text(payment.dentalNote![index]
                                                //   //             .procedure.price!
                                                //   //             .toString()
                                                //   //             .toCurrency!),
                                                //   //       ],
                                                //   //     ),
                                                //   //     separatorBuilder: (context, index) =>
                                                //   //         Divider(height: 1),
                                                //   //     itemCount: payment.dentalNote!.length),
                                                //
                                                //   // model.currentUser!.email,
                                                //   decoration:
                                                //       const InputDecoration(
                                                //     //prefixIcon: Icon(Icons.mail),
                                                //     contentPadding:
                                                //         EdgeInsets.only(
                                                //             top: 10, left: 4),
                                                //     labelText: 'Sphere',
                                                //     // enabledBorder: UnderlineInputBorder(
                                                //     //     borderSide: BorderSide(
                                                //     //         color: Color(0xffADADAD))),
                                                //     // focusedBorder: UnderlineInputBorder(
                                                //     //     borderSide:
                                                //     //     BorderSide(color: Colors.blue)),
                                                //
                                                //     border: InputBorder.none,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          Divider(height: 1),
                                      itemCount: payment.dentalNote!.length)
                                ]),
                                Column(children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) => Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Tint',
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                                SizedBox(height: 6),
                                                Text(
                                                  payment.dentalNote![index]
                                                      .tintCL,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                )
                                                // Text(
                                                //   payment.dentalNote![index].axis,
                                                //   style: TextStyle(
                                                //     color: Colors.black,
                                                //   ),
                                                // )
                                                // TextFormField(
                                                //
                                                //   textInputAction:
                                                //       TextInputAction.done,
                                                //   minLines: 1,
                                                //   maxLines: 2,
                                                //   keyboardType:
                                                //       TextInputType.multiline,
                                                //   controller: payment.dentalNote![index].sphere,
                                                //   // ListView.separated(
                                                //   //     shrinkWrap: true,
                                                //   //     primary: false,
                                                //   //     itemBuilder: (context, index) => Row(
                                                //   //       mainAxisAlignment:
                                                //   //       MainAxisAlignment.spaceBetween,
                                                //   //       children: [
                                                //   //         RichText(
                                                //   //           text: TextSpan(
                                                //   //               text: payment
                                                //   //                   .dentalNote![index]
                                                //   //                   .procedure
                                                //   //                   .procedureName,
                                                //   //               // children: [
                                                //   //               //   TextSpan(
                                                //   //               //     text: ' @tooth#' +
                                                //   //               //         payment
                                                //   //               //             .dentalNote![
                                                //   //               //                 index]
                                                //   //               //             .sphere,
                                                //   //               //   )
                                                //   //               // ],
                                                //   //               style: TextStyle(
                                                //   //                 color: Colors.black,
                                                //   //               )),
                                                //   //         ),
                                                //   //         Text(payment.dentalNote![index]
                                                //   //             .procedure.price!
                                                //   //             .toString()
                                                //   //             .toCurrency!),
                                                //   //       ],
                                                //   //     ),
                                                //   //     separatorBuilder: (context, index) =>
                                                //   //         Divider(height: 1),
                                                //   //     itemCount: payment.dentalNote!.length),
                                                //
                                                //   // model.currentUser!.email,
                                                //   decoration:
                                                //       const InputDecoration(
                                                //     //prefixIcon: Icon(Icons.mail),
                                                //     contentPadding:
                                                //         EdgeInsets.only(
                                                //             top: 10, left: 4),
                                                //     labelText: 'Sphere',
                                                //     // enabledBorder: UnderlineInputBorder(
                                                //     //     borderSide: BorderSide(
                                                //     //         color: Color(0xffADADAD))),
                                                //     // focusedBorder: UnderlineInputBorder(
                                                //     //     borderSide:
                                                //     //     BorderSide(color: Colors.blue)),
                                                //
                                                //     border: InputBorder.none,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                      separatorBuilder: (context, index) =>
                                          Divider(height: 1),
                                      itemCount: payment.dentalNote!.length)
                                ]),
                              ]),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                  // SizedBox(height: 22),
                  // TextFormField(
                  //   textInputAction: TextInputAction.done,
                  //   controller: model.notes,
                  //   maxLines: 5,
                  //   maxLength: 300,
                  //   decoration: InputDecoration(
                  //     hintText: 'No Notes Available',
                  //     labelText: 'Notes',
                  //     floatingLabelBehavior: FloatingLabelBehavior.always,
                  //     labelStyle:
                  //     TextStyle(fontSize: 20, color: Palettes.kcNeutral1),
                  //     enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Palettes.kcBlueMain1)),
                  //     focusedBorder: OutlineInputBorder(
                  //         borderSide:
                  //         BorderSide(color: Palettes.kcBlueMain1, width: 2)),
                  //     border: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Palettes.kcBlueMain1)),
                  //   ),
                  // ),
                  SizedBox(height: 22),
                  // TextFormField(
                  //   textInputAction: TextInputAction.done,
                  //   controller: model.note,
                  //   maxLines: 5,
                  //   maxLength: 300,
                  //   decoration: InputDecoration(
                  //     hintText: 'Type here',
                  //     labelText: 'Note (Optional)',
                  //     floatingLabelBehavior: FloatingLabelBehavior.always,
                  //     labelStyle:
                  //     TextStyle(fontSize: 20, color: Palettes.kcNeutral1),
                  //     enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Palettes.kcBlueMain1)),
                  //     focusedBorder: OutlineInputBorder(
                  //         borderSide:
                  //         BorderSide(color: Palettes.kcBlueMain1, width: 2)),
                  //     border: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Palettes.kcBlueMain1)),
                  //   ),
                  // ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 49,
                      decoration:
                      const BoxDecoration(color: Palettes.kcBlueMain1),
                      child: const Center(
                          child: Text(
                            "NOTES",
                            style: TextStyle(
                              color: Colors.white,
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ))),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Palettes.kcBlueMain1)),
                    child: ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Align(
                                  //     alignment: Alignment.topLeft,
                                  //     child: Text('Notes',
                                  //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                                  SizedBox(height: 6),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      payment.dentalNote![index].note,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                            ),
                        separatorBuilder: (context, index) =>
                            Divider(height: 1),
                        itemCount: payment.dentalNote!.length),
                  )
                ],
              ),
            ),
          );
        });
  }
}
