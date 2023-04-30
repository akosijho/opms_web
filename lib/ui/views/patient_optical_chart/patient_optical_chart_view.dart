import 'package:age_calculator/age_calculator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_border_styles.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/models/patient_model/patient_model.dart';
import 'package:opmswebstaff/ui/views/set_optical_note/set_optical_note_view_model.dart';
import 'package:stacked/stacked.dart';


class PatientOpticalChartView extends StatelessWidget {

  final Patient patient;

  const PatientOpticalChartView({Key? key, required this.patient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetOpticalNoteViewModel>.reactive(
      viewModelBuilder: () => SetOpticalNoteViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Patient's Optical Chart"),
          centerTitle: true,
          // actions: [
          //   IconButton(
          //       onPressed: () => model.goToChartLegend(),
          //       icon: Icon(
          //         Icons.info,
          //         color: Colors.white,
          //       ))
          // ],
        ),
        persistentFooterButtons: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  // width: double.maxFinite,
                  child: ElevatedButton.icon(
                    label: Text('Save',
                    style: TextStyle(
                      fontSize: 14
                    )
                    ),
                    onPressed: () {
                      if (model.setDentalNoteFormKey.currentState!.validate()) {
                        List<String> eye =[];

                        model.addDentalNote(
                          patientId: patient.id, );
                      }
                    },
                    // onPressed: () {
                    //   if (model.setDentalNoteFormKey.currentState!.validate()) {
                    //     model.addDentalNote(
                    //         patientId: patientId, selectedTeeth: selectedTeeth);
                    //   }
                    // },
                    icon: Icon(Icons.save),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:[
                  ElevatedButton.icon(
                    icon: Icon(
                      Icons.history,
                      color: Colors.white,
                    ),
                    onPressed: () => model.navigationService.pushNamed(
                        Routes.ViewOpticalNote,
                        arguments: ViewOpticalNoteArguments(patient: patient)),
                    label: Text('View Optical Notes'),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyles.tsBody2(),
                      primary: Palettes.kcBlueMain1,
                    ),
                  ),
                  SizedBox(width: 4),
                  ElevatedButton.icon(
                    icon: Icon(
                      Icons.money,
                      color: Colors.white,
                    ),
                    onPressed: () => model.navigationService.pushNamed(
                        Routes.AddPaymentView,
                        arguments: AddPaymentViewArguments(patient: patient)),
                    label: Text('Add Payment'),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyles.tsBody2(),
                      primary: Palettes.kcNeutral1,
                    ),
                  ),
                ]
              ),

            ],
          ),
        ],
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
                        const BoxDecoration(color: Color(0xff68D2F4)),
                        child: const Center(
                            child: Text(
                              "RX SPECTACLE",
                              style: TextStyle(
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
                            Column(children: [Text('OD\n/\nOS', textAlign: TextAlign.center,)]),
                            Column(children: [
                              TextFormField(
                                // textAlign: TextAlign.start,
                                textInputAction: TextInputAction.done,
                                minLines: 1,
                                maxLines: 2,
                                keyboardType: TextInputType.multiline,
                                controller: model.sphere,
                                decoration: const InputDecoration(
                                  //prefixIcon: Icon(Icons.mail),
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'Sphere',
                                  // enabledBorder: UnderlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Color(0xffADADAD))),
                                  // focusedBorder: UnderlineInputBorder(
                                  //     borderSide:
                                  //     BorderSide(color: Colors.blue)),

                                  border: InputBorder.none,
                                ),
                              ),
                            ]),
                            Column(children: [
                              TextFormField(
                                // textInputAction: TextInputAction.done,
                                textAlign: TextAlign.start,
                                minLines: 1,
                                maxLines: 2,
                                keyboardType: TextInputType.multiline,
                                controller: model.cylinder,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'Cylinder',
                                  // enabledBorder: UnderlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Color(0xffADADAD))),
                                  // focusedBorder: UnderlineInputBorder(
                                  //     borderSide:
                                  //     BorderSide(color: Colors.blue)),
                                  border: InputBorder.none,
                                ),
                              ),
                            ]),
                            Column(children: [
                              TextFormField(
                                // textInputAction: TextInputAction.done,
                                textAlign: TextAlign.start,
                                minLines: 1,
                                maxLines: 2,
                                keyboardType: TextInputType.multiline,
                                controller: model.axis,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'Axis',
                                  // enabledBorder: UnderlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Color(0xffADADAD))),
                                  // focusedBorder: UnderlineInputBorder(
                                  //     borderSide:
                                  //     BorderSide(color: Colors.blue)),
                                  border: InputBorder.none,
                                ),
                              ),
                            ]),
                            Column(children: [
                              TextFormField(
                                textAlign: TextAlign.start,
                                minLines: 1,
                                maxLines: 2,
                                keyboardType: TextInputType.multiline,
                                controller: model.pd,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'PD',
                                  // enabledBorder: UnderlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Color(0xffADADAD))),
                                  // focusedBorder: UnderlineInputBorder(
                                  //     borderSide:
                                  //     BorderSide(color: Colors.blue)),
                                  border: InputBorder.none,
                                ),
                              ),
                            ]),
                            Column(children: [
                              TextFormField(
                                textAlign: TextAlign.start,
                                minLines: 1,
                                maxLines: 2,
                                keyboardType: TextInputType.multiline,
                                controller: model.add,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'ADD',
                                  // enabledBorder: UnderlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Color(0xffADADAD))),
                                  // focusedBorder: UnderlineInputBorder(
                                  //     borderSide:
                                  //     BorderSide(color: Colors.blue)),
                                  border: InputBorder.none,
                                ),
                              ),
                            ]),
                            Column(children: [
                              TextFormField(
                                // enabled: false,
                                textAlign: TextAlign.start,
                                minLines: 1,
                                maxLines: 2,
                                keyboardType: TextInputType.multiline,
                                controller: model.va,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'V.A',
                                  // enabledBorder: UnderlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Color(0xffADADAD))),
                                  // focusedBorder: UnderlineInputBorder(
                                  //     borderSide:
                                  //     BorderSide(color: Colors.blue)),
                                  border: InputBorder.none,
                                ),
                              ),
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
                        const BoxDecoration(color: Color(0xff68D2F4)),
                        child: const Center(
                            child: Text(
                              "RX CONTACT LENS",
                              style: TextStyle(
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
                            Column(children: [Text('OD\n/\nOS', textAlign: TextAlign.center,)]),
                            Column(children: [
                              TextFormField(
                                textAlign: TextAlign.start,
                                minLines: 1,
                                maxLines: 2,
                                keyboardType: TextInputType.multiline,
                                controller: model.sphereCL,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'Sphere',
                                  // enabledBorder: UnderlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Color(0xffADADAD))),
                                  // focusedBorder: UnderlineInputBorder(
                                  //     borderSide:
                                  //     BorderSide(color: Colors.blue)),

                                  border: InputBorder.none,
                                ),
                              ),
                            ]),
                            Column(children: [
                              TextFormField(
                                textAlign: TextAlign.start,
                                minLines: 1,
                                maxLines: 2,
                                keyboardType: TextInputType.multiline,
                                controller: model.cylinderCL,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'Cylinder',
                                  // enabledBorder: UnderlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Color(0xffADADAD))),
                                  // focusedBorder: UnderlineInputBorder(
                                  //     borderSide:
                                  //     BorderSide(color: Colors.blue)),

                                  border: InputBorder.none,
                                ),
                              ),
                            ]),
                            Column(children: [
                              TextFormField(
                                textAlign: TextAlign.start,
                                minLines: 1,
                                maxLines: 2,
                                keyboardType: TextInputType.multiline,
                                controller: model.axisCL,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'Axis',
                                  // enabledBorder: UnderlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Color(0xffADADAD))),
                                  // focusedBorder: UnderlineInputBorder(
                                  //     borderSide:
                                  //     BorderSide(color: Colors.blue)),

                                  border: InputBorder.none,
                                ),
                              ),
                            ]),
                            Column(children: [
                              TextFormField(
                                textAlign: TextAlign.start,
                                minLines: 1,
                                maxLines: 2,
                                keyboardType: TextInputType.multiline,
                                controller: model.bcCL,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'B.C',
                                  // enabledBorder: UnderlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Color(0xffADADAD))),
                                  // focusedBorder: UnderlineInputBorder(
                                  //     borderSide:
                                  //     BorderSide(color: Colors.blue)),

                                  border: InputBorder.none,
                                ),
                              ),
                            ]),
                            Column(children: [
                              TextFormField(
                                textAlign: TextAlign.start,
                                minLines: 1,
                                maxLines: 2,
                                keyboardType: TextInputType.multiline,
                                controller: model.diaCL,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'DIA',
                                  // enabledBorder: UnderlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Color(0xffADADAD))),
                                  // focusedBorder: UnderlineInputBorder(
                                  //     borderSide:
                                  //     BorderSide(color: Colors.blue)),

                                  border: InputBorder.none,
                                ),
                              ),
                            ]),
                            Column(children: [
                              TextFormField(
                                textAlign: TextAlign.start,
                                minLines: 1,
                                maxLines: 2,
                                keyboardType: TextInputType.multiline,
                                controller: model.tintCL,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'Tint',
                                  //hintText: 'Enter Email',
                                  // enabledBorder: UnderlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Color(0xffADADAD))),
                                  // focusedBorder: UnderlineInputBorder(
                                  //     borderSide:
                                  //     BorderSide(color: Colors.blue)),

                                  border: InputBorder.none,
                                ),
                              ),
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
                          //       // controller: model.lensl1,
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
                          //       // controller: model.lensl2,
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
                          //       // controller: model.lensl3,
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
                          //       // controller: model.lensl4,
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
                          //       // controller: model.lensl5,
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
                          //       // controller: model.lensl6,
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
                          // ]),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => model.selectDate(),
                child: TextFormField(
                  controller: model.dateTextController,
                  enabled: false,
                  validator: (value) =>
                      model.validatorService.validateDate(value!),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                      errorBorder: TextBorderStyles.errorBorder,
                      errorStyle: TextStyles.errorTextStyle,
                      disabledBorder: TextBorderStyles.normalBorder,
                      hintText: 'MM/DD/YYYY',
                      labelText: 'Appointment Date*',
                      labelStyle:
                      TextStyle(fontSize: 21, color: Palettes.kcNeutral1),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: SvgPicture.asset(
                        'assets/icons/Calendar.svg',
                        color: Palettes.kcBlueMain1,
                        fit: BoxFit.scaleDown,
                      )),
                ),
              ),
              SizedBox(height: 9),
              GestureDetector(
                onTap: () => model.goToSelectProcedure(),
                child: TextFormField(
                  controller: model.procedureTxtController,
                  validator: (value) =>
                      model.validatorService.validateProcedureName(value!),
                  textInputAction: TextInputAction.next,
                  enabled: false,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                      errorBorder: TextBorderStyles.errorBorder,
                      errorStyle: TextStyles.errorTextStyle,
                      disabledBorder: TextBorderStyles.normalBorder,
                      hintText: 'Select Service Rendered',
                      labelText: 'Service*',
                      labelStyle:
                      TextStyle(fontSize: 21, color: Palettes.kcNeutral1),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        size: 24,
                        color: Palettes.kcBlueMain1,
                      )),
                ),
              ),
              SizedBox(height: 22),
              TextFormField(
                textInputAction: TextInputAction.done,
                maxLines: 5,
                maxLength: 300,
                decoration: InputDecoration(
                  hintText: 'Type here',
                  labelText: 'Note (Optional)',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle:
                  TextStyle(fontSize: 20, color: Palettes.kcNeutral1),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palettes.kcBlueMain1)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Palettes.kcBlueMain1, width: 2)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Palettes.kcBlueMain1)),
                ),
              ),
            ],
          ),
        ),
        // body: RefreshIndicator(
        //   key: refreshKey,
        //   onRefresh: () async {
        //     model.isInSelectionMode = false;
        //     model.selectedTooth.clear();
        //     model.init(patient.id);
        //     model.notifyListeners();
        //   },
        //   child: ListView(
        //     physics: BouncingScrollPhysics(),
        //     children: [
        //       PatientCard(
        //         // image: patient.image,
        //         name: patient.fullName,
        //         phone: patient.phoneNum,
        //         address: patient.address,
        //         age: '20',
        //         // age: AgeCalculator.age(
        //         //     model.patientList!
        //         //         .birthDate
        //         //         .toDateTime()!,
        //         //     today: DateTime.now())
        //         //     .years
        //         //     .toString(),
        //         birthDate:
        //             DateFormat.yMMMd().format(patient.birthDate.toDateTime()!),
        //         dateCreated: patient.dateCreated!,
        //       ),
        //       AnimatedContainer(
        //         height: model.isInSelectionMode ? 45 : 0,
        //         decoration: BoxDecoration(
        //           color: Colors.grey.shade200,
        //         ),
        //         duration: Duration(milliseconds: 200),
        //         padding: EdgeInsets.all(2),
        //         curve: Curves.easeIn,
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.end,
        //           children: [
        //             SizedBox(width: 10),
        //             Center(
        //                 child: RichText(
        //               text: TextSpan(
        //                 text: model.selectedTooth.length.toString(),
        //                 children: [
        //                   TextSpan(
        //                       // text: ' Tooth Selected',
        //                       text: ' Rx Added',
        //                       style: TextStyle(
        //                           fontSize: 14, fontWeight: FontWeight.normal))
        //                 ],
        //                 style: TextStyles.tsHeading5(),
        //               ),
        //             )),
        //             Spacer(),
        //             // TextButton.icon(
        //             //   onPressed: () => model.goToSetToothCondition(patient.id),
        //             //   icon: Icon(CupertinoIcons.add_circled),
        //             //   label: Text('Condition'),
        //             //   style: TextButton.styleFrom(
        //             //     primary: Colors.white,
        //             //     backgroundColor: Palettes.kcNeutral1,
        //             //   ),
        //             // ),
        //             SizedBox(width: 5),
        //             TextButton.icon(
        //               onPressed: () => model.goToSetDentalNote(patient.id),
        //               icon: Icon(CupertinoIcons.add_circled),
        //               label: Text(' Add RX'),
        //               style: TextButton.styleFrom(
        //                 primary: Colors.white,
        //                 backgroundColor: Palettes.kcBlueMain1,
        //               ),
        //             ),
        //             SizedBox(width: 5),
        //           ],
        //         ),
        //       ),
        //       SizedBox(height: 4),
        //       Padding(
        //         padding: const EdgeInsets.all(5.0),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             Text(
        //               "Patient's Optical Chart",
        //               style: TextStyles.tsHeading4(),
        //             ),
        //             SizedBox(height: 3),
        //
        //             //RX
        //             Container(
        //               // padding: EdgeInsets.all(5),
        //               decoration: BoxDecoration(
        //                   border: Border.all(color: Colors.black, width: 2)),
        //               child: Column(
        //                 children: [
        //                   Container(
        //                       width: MediaQuery.of(context).size.width,
        //                       height: 49,
        //                       decoration:
        //                       const BoxDecoration(color: Color(0xff68D2F4)),
        //                       child: const Center(
        //                           child: Text(
        //                             "RX SPECTACLE",
        //                             style: TextStyle(
        //                                 fontSize: 18, fontWeight: FontWeight.w500),
        //                           ))),
        //                   Container(
        //                     padding: EdgeInsets.all(8),
        //                     child: Table(
        //                       //defaultColumnWidth: FixedColumnWidth(120.0),
        //                       border: TableBorder.all(
        //                           color: Colors.black,
        //                           //style: BorderStyle.solid,
        //                           width: 1),
        //                       children: [
        //                         TableRow(children: [
        //                           Column(children: [Text('OD\n/\nOS', textAlign: TextAlign.center,)]),
        //                           Column(children: [
        //                             TextFormField(
        //                               // textAlign: TextAlign.start,
        //                               textInputAction: TextInputAction.done,
        //                               minLines: 1,
        //                               maxLines: 2,
        //                               keyboardType: TextInputType.multiline,
        //                               controller: model.sphere,
        //                               decoration: const InputDecoration(
        //                                 //prefixIcon: Icon(Icons.mail),
        //                                 contentPadding:
        //                                 EdgeInsets.only(top: 10, left: 4),
        //                                 labelText: 'Sphere',
        //                                 //hintText: 'Enter Email',
        //                                 enabledBorder: UnderlineInputBorder(
        //                                     borderSide: BorderSide(
        //                                         color: Color(0xffADADAD))),
        //                                 focusedBorder: UnderlineInputBorder(
        //                                     borderSide:
        //                                     BorderSide(color: Colors.blue)),
        //
        //                                 border: InputBorder.none,
        //                               ),
        //                             ),
        //                           ]),
        //                           Column(children: [
        //                             TextFormField(
        //                               // textInputAction: TextInputAction.done,
        //                               textAlign: TextAlign.start,
        //                               minLines: 1,
        //                               maxLines: 2,
        //                               keyboardType: TextInputType.multiline,
        //                               controller: model.cylinder,
        //                               decoration: const InputDecoration(
        //                                 contentPadding:
        //                                 EdgeInsets.only(top: 10, left: 4),
        //                                 labelText: 'Cylinder',
        //                                 enabledBorder: UnderlineInputBorder(
        //                                     borderSide: BorderSide(
        //                                         color: Color(0xffADADAD))),
        //                                 focusedBorder: UnderlineInputBorder(
        //                                     borderSide:
        //                                     BorderSide(color: Colors.blue)),
        //                                 border: InputBorder.none,
        //                               ),
        //                             ),
        //                           ]),
        //                           Column(children: [
        //                             TextFormField(
        //                               // textInputAction: TextInputAction.done,
        //                               textAlign: TextAlign.start,
        //                               minLines: 1,
        //                               maxLines: 2,
        //                               keyboardType: TextInputType.multiline,
        //                               controller: model.axis,
        //                               decoration: const InputDecoration(
        //                                 contentPadding:
        //                                 EdgeInsets.only(top: 10, left: 4),
        //                                 labelText: 'Axis',
        //                                 enabledBorder: UnderlineInputBorder(
        //                                     borderSide: BorderSide(
        //                                         color: Color(0xffADADAD))),
        //                                 focusedBorder: UnderlineInputBorder(
        //                                     borderSide:
        //                                     BorderSide(color: Colors.blue)),
        //                                 border: InputBorder.none,
        //                               ),
        //                             ),
        //                           ]),
        //                           Column(children: [
        //                             TextFormField(
        //                               textAlign: TextAlign.start,
        //                               minLines: 1,
        //                               maxLines: 2,
        //                               keyboardType: TextInputType.multiline,
        //                               // controller: model.specr4,
        //                               decoration: const InputDecoration(
        //                                 contentPadding:
        //                                 EdgeInsets.only(top: 10, left: 4),
        //                                 labelText: 'PD',
        //                                 enabledBorder: UnderlineInputBorder(
        //                                     borderSide: BorderSide(
        //                                         color: Color(0xffADADAD))),
        //                                 focusedBorder: UnderlineInputBorder(
        //                                     borderSide:
        //                                     BorderSide(color: Colors.blue)),
        //                                 border: InputBorder.none,
        //                               ),
        //                             ),
        //                           ]),
        //                           Column(children: [
        //                             TextFormField(
        //                               textAlign: TextAlign.start,
        //                               minLines: 1,
        //                               maxLines: 2,
        //                               keyboardType: TextInputType.multiline,
        //                               // controller: model.specr5,
        //                               decoration: const InputDecoration(
        //                                 contentPadding:
        //                                 EdgeInsets.only(top: 10, left: 4),
        //                                 labelText: 'ADD',
        //                                 enabledBorder: UnderlineInputBorder(
        //                                     borderSide: BorderSide(
        //                                         color: Color(0xffADADAD))),
        //                                 focusedBorder: UnderlineInputBorder(
        //                                     borderSide:
        //                                     BorderSide(color: Colors.blue)),
        //                                 border: InputBorder.none,
        //                               ),
        //                             ),
        //                           ]),
        //                           Column(children: [
        //                             TextFormField(
        //                               textAlign: TextAlign.start,
        //                               minLines: 1,
        //                               maxLines: 2,
        //                               keyboardType: TextInputType.multiline,
        //                               // controller: model.specr6,
        //                               decoration: const InputDecoration(
        //                                 contentPadding:
        //                                 EdgeInsets.only(top: 10, left: 4),
        //                                 labelText: 'V.A',
        //                                 enabledBorder: UnderlineInputBorder(
        //                                     borderSide: BorderSide(
        //                                         color: Color(0xffADADAD))),
        //                                 focusedBorder: UnderlineInputBorder(
        //                                     borderSide:
        //                                     BorderSide(color: Colors.blue)),
        //                                 border: InputBorder.none,
        //                               ),
        //                             ),
        //                           ]),
        //                         ]),
        //                         // TableRow(children: [
        //                         //   Column(children: [Text('LEFT\n(OS)')]),
        //                         //   Column(children: [
        //                         //     TextFormField(
        //                         //       textAlign: TextAlign.start,
        //                         //       minLines: 1,
        //                         //       maxLines: 2,
        //                         //       keyboardType: TextInputType.multiline,
        //                         //       // controller: model.specl1,
        //                         //       decoration: const InputDecoration(
        //                         //         contentPadding:
        //                         //         EdgeInsets.only(top: 10, left: 4),
        //                         //         //labelText: 'Lens Tint',
        //                         //         //hintText: 'Enter Email',
        //                         //         enabledBorder: UnderlineInputBorder(
        //                         //             borderSide: BorderSide(
        //                         //                 color: Color(0xffADADAD))),
        //                         //         focusedBorder: UnderlineInputBorder(
        //                         //             borderSide:
        //                         //             BorderSide(color: Colors.blue)),
        //                         //
        //                         //         border: InputBorder.none,
        //                         //       ),
        //                         //     ),
        //                         //   ]),
        //                         //   Column(children: [
        //                         //     TextFormField(
        //                         //       textAlign: TextAlign.start,
        //                         //       minLines: 1,
        //                         //       maxLines: 2,
        //                         //       keyboardType: TextInputType.multiline,
        //                         //       // controller: model.specl2,
        //                         //       decoration: const InputDecoration(
        //                         //         contentPadding:
        //                         //         EdgeInsets.only(top: 10, left: 4),
        //                         //         //labelText: 'Lens Tint',
        //                         //         //hintText: 'Enter Email',
        //                         //         enabledBorder: UnderlineInputBorder(
        //                         //             borderSide: BorderSide(
        //                         //                 color: Color(0xffADADAD))),
        //                         //         focusedBorder: UnderlineInputBorder(
        //                         //             borderSide:
        //                         //             BorderSide(color: Colors.blue)),
        //                         //
        //                         //         border: InputBorder.none,
        //                         //       ),
        //                         //     ),
        //                         //   ]),
        //                         //   Column(children: [
        //                         //     TextFormField(
        //                         //       textAlign: TextAlign.start,
        //                         //       minLines: 1,
        //                         //       maxLines: 2,
        //                         //       keyboardType: TextInputType.multiline,
        //                         //       // controller: model.specl3,
        //                         //       decoration: const InputDecoration(
        //                         //         contentPadding:
        //                         //         EdgeInsets.only(top: 10, left: 4),
        //                         //         //labelText: 'Lens Tint',
        //                         //         //hintText: 'Enter Email',
        //                         //         enabledBorder: UnderlineInputBorder(
        //                         //             borderSide: BorderSide(
        //                         //                 color: Color(0xffADADAD))),
        //                         //         focusedBorder: UnderlineInputBorder(
        //                         //             borderSide:
        //                         //             BorderSide(color: Colors.blue)),
        //                         //
        //                         //         border: InputBorder.none,
        //                         //       ),
        //                         //     ),
        //                         //   ]),
        //                         //   Column(children: [
        //                         //     TextFormField(
        //                         //       textAlign: TextAlign.start,
        //                         //       minLines: 1,
        //                         //       maxLines: 2,
        //                         //       keyboardType: TextInputType.multiline,
        //                         //       // controller: model.specl4,
        //                         //       decoration: const InputDecoration(
        //                         //         //prefixIcon: Icon(Icons.mail),
        //                         //         contentPadding:
        //                         //         EdgeInsets.only(top: 10, left: 4),
        //                         //         //labelText: 'Lens Tint',
        //                         //         //hintText: 'Enter Email',
        //                         //         enabledBorder: UnderlineInputBorder(
        //                         //             borderSide: BorderSide(
        //                         //                 color: Color(0xffADADAD))),
        //                         //         focusedBorder: UnderlineInputBorder(
        //                         //             borderSide:
        //                         //             BorderSide(color: Colors.blue)),
        //                         //
        //                         //         border: InputBorder.none,
        //                         //       ),
        //                         //     ),
        //                         //   ]),
        //                         //   Column(children: [
        //                         //     TextFormField(
        //                         //       textAlign: TextAlign.start,
        //                         //       minLines: 1,
        //                         //       maxLines: 2,
        //                         //       keyboardType: TextInputType.multiline,
        //                         //       // controller: model.specl5,
        //                         //       decoration: const InputDecoration(
        //                         //         //prefixIcon: Icon(Icons.mail),
        //                         //         contentPadding:
        //                         //         EdgeInsets.only(top: 10, left: 4),
        //                         //         //labelText: 'Lens Tint',
        //                         //         //hintText: 'Enter Email',
        //                         //         enabledBorder: UnderlineInputBorder(
        //                         //             borderSide: BorderSide(
        //                         //                 color: Color(0xffADADAD))),
        //                         //         focusedBorder: UnderlineInputBorder(
        //                         //             borderSide:
        //                         //             BorderSide(color: Colors.blue)),
        //                         //
        //                         //         border: InputBorder.none,
        //                         //       ),
        //                         //     ),
        //                         //   ]),
        //                         //   Column(children: [
        //                         //     TextFormField(
        //                         //       textAlign: TextAlign.start,
        //                         //       minLines: 1,
        //                         //       maxLines: 2,
        //                         //       keyboardType: TextInputType.multiline,
        //                         //       // controller: model.specl6,
        //                         //       decoration: const InputDecoration(
        //                         //         //prefixIcon: Icon(Icons.mail),
        //                         //         contentPadding:
        //                         //         EdgeInsets.only(top: 10, left: 4),
        //                         //         //labelText: 'Lens Tint',
        //                         //         //hintText: 'Enter Email',
        //                         //         enabledBorder: UnderlineInputBorder(
        //                         //             borderSide: BorderSide(
        //                         //                 color: Color(0xffADADAD))),
        //                         //         focusedBorder: UnderlineInputBorder(
        //                         //             borderSide:
        //                         //             BorderSide(color: Colors.blue)),
        //                         //
        //                         //         border: InputBorder.none,
        //                         //       ),
        //                         //     ),
        //                         //   ]),
        //                         // ]),
        //                       ],
        //                     ),
        //                   ),
        //                   Container(
        //                       width: MediaQuery.of(context).size.width,
        //                       height: 49,
        //                       decoration:
        //                       const BoxDecoration(color: Color(0xff68D2F4)),
        //                       child: const Center(
        //                           child: Text(
        //                             "RX CONTACT LENS",
        //                             style: TextStyle(
        //                                 fontSize: 18, fontWeight: FontWeight.w500),
        //                           ))),
        //                   Container(
        //                     padding: EdgeInsets.all(8),
        //                     child: Table(
        //                       //defaultColumnWidth: FixedColumnWidth(120.0),
        //                       border: TableBorder.all(
        //                           color: Colors.black,
        //                           //style: BorderStyle.solid,
        //                           width: 1),
        //                       children: [
        //                         TableRow(children: [
        //                           Column(children: [Text('OD\n/\nOS', textAlign: TextAlign.center,)]),
        //                           Column(children: [
        //                             TextFormField(
        //                               textAlign: TextAlign.start,
        //                               minLines: 1,
        //                               maxLines: 2,
        //                               keyboardType: TextInputType.multiline,
        //                               // controller: model.lensr1,
        //                               decoration: const InputDecoration(
        //                                 contentPadding:
        //                                 EdgeInsets.only(top: 10, left: 4),
        //                                 labelText: 'SPHERE',
        //                                 //hintText: 'Enter Email',
        //                                 enabledBorder: UnderlineInputBorder(
        //                                     borderSide: BorderSide(
        //                                         color: Color(0xffADADAD))),
        //                                 focusedBorder: UnderlineInputBorder(
        //                                     borderSide:
        //                                     BorderSide(color: Colors.blue)),
        //
        //                                 border: InputBorder.none,
        //                               ),
        //                             ),
        //                           ]),
        //                           Column(children: [
        //                             TextFormField(
        //                               textAlign: TextAlign.start,
        //                               minLines: 1,
        //                               maxLines: 2,
        //                               keyboardType: TextInputType.multiline,
        //                               // controller: model.lensr2,
        //                               decoration: const InputDecoration(
        //                                 contentPadding:
        //                                 EdgeInsets.only(top: 10, left: 4),
        //                                 labelText: 'CYLINDER',
        //                                 //hintText: 'Enter Email',
        //                                 enabledBorder: UnderlineInputBorder(
        //                                     borderSide: BorderSide(
        //                                         color: Color(0xffADADAD))),
        //                                 focusedBorder: UnderlineInputBorder(
        //                                     borderSide:
        //                                     BorderSide(color: Colors.blue)),
        //
        //                                 border: InputBorder.none,
        //                               ),
        //                             ),
        //                           ]),
        //                           Column(children: [
        //                             TextFormField(
        //                               textAlign: TextAlign.start,
        //                               minLines: 1,
        //                               maxLines: 2,
        //                               keyboardType: TextInputType.multiline,
        //                               // controller: model.lensr3,
        //                               decoration: const InputDecoration(
        //                                 contentPadding:
        //                                 EdgeInsets.only(top: 10, left: 4),
        //                                 labelText: 'AXIS',
        //                                 //hintText: 'Enter Email',
        //                                 enabledBorder: UnderlineInputBorder(
        //                                     borderSide: BorderSide(
        //                                         color: Color(0xffADADAD))),
        //                                 focusedBorder: UnderlineInputBorder(
        //                                     borderSide:
        //                                     BorderSide(color: Colors.blue)),
        //
        //                                 border: InputBorder.none,
        //                               ),
        //                             ),
        //                           ]),
        //                           Column(children: [
        //                             TextFormField(
        //                               textAlign: TextAlign.start,
        //                               minLines: 1,
        //                               maxLines: 2,
        //                               keyboardType: TextInputType.multiline,
        //                               // controller: model.lensr4,
        //                               decoration: const InputDecoration(
        //                                 contentPadding:
        //                                 EdgeInsets.only(top: 10, left: 4),
        //                                 labelText: 'B.C',
        //                                 //hintText: 'Enter Email',
        //                                 enabledBorder: UnderlineInputBorder(
        //                                     borderSide: BorderSide(
        //                                         color: Color(0xffADADAD))),
        //                                 focusedBorder: UnderlineInputBorder(
        //                                     borderSide:
        //                                     BorderSide(color: Colors.blue)),
        //
        //                                 border: InputBorder.none,
        //                               ),
        //                             ),
        //                           ]),
        //                           Column(children: [
        //                             TextFormField(
        //                               textAlign: TextAlign.start,
        //                               minLines: 1,
        //                               maxLines: 2,
        //                               keyboardType: TextInputType.multiline,
        //                               // controller: model.lensr5,
        //                               decoration: const InputDecoration(
        //                                 contentPadding:
        //                                 EdgeInsets.only(top: 10, left: 4),
        //                                 labelText: 'DIA',
        //                                 //hintText: 'Enter Email',
        //                                 enabledBorder: UnderlineInputBorder(
        //                                     borderSide: BorderSide(
        //                                         color: Color(0xffADADAD))),
        //                                 focusedBorder: UnderlineInputBorder(
        //                                     borderSide:
        //                                     BorderSide(color: Colors.blue)),
        //
        //                                 border: InputBorder.none,
        //                               ),
        //                             ),
        //                           ]),
        //                           Column(children: [
        //                             TextFormField(
        //                               textAlign: TextAlign.start,
        //                               minLines: 1,
        //                               maxLines: 2,
        //                               keyboardType: TextInputType.multiline,
        //                               // controller: model.lensr6,
        //                               decoration: const InputDecoration(
        //                                 contentPadding:
        //                                 EdgeInsets.only(top: 10, left: 4),
        //                                 labelText: 'TINT',
        //                                 //hintText: 'Enter Email',
        //                                 enabledBorder: UnderlineInputBorder(
        //                                     borderSide: BorderSide(
        //                                         color: Color(0xffADADAD))),
        //                                 focusedBorder: UnderlineInputBorder(
        //                                     borderSide:
        //                                     BorderSide(color: Colors.blue)),
        //
        //                                 border: InputBorder.none,
        //                               ),
        //                             ),
        //                           ]),
        //                         ]),
        //                         // TableRow(children: [
        //                         //   Column(children: [Text('LEFT\n(OS)')]),
        //                         //   Column(children: [
        //                         //     TextFormField(
        //                         //       textAlign: TextAlign.start,
        //                         //       minLines: 1,
        //                         //       maxLines: 2,
        //                         //       keyboardType: TextInputType.multiline,
        //                         //       // controller: model.lensl1,
        //                         //       decoration: const InputDecoration(
        //                         //         contentPadding:
        //                         //         EdgeInsets.only(top: 10, left: 4),
        //                         //         //labelText: 'Lens Tint',
        //                         //         //hintText: 'Enter Email',
        //                         //         enabledBorder: UnderlineInputBorder(
        //                         //             borderSide: BorderSide(
        //                         //                 color: Color(0xffADADAD))),
        //                         //         focusedBorder: UnderlineInputBorder(
        //                         //             borderSide:
        //                         //             BorderSide(color: Colors.blue)),
        //                         //
        //                         //         border: InputBorder.none,
        //                         //       ),
        //                         //     ),
        //                         //   ]),
        //                         //   Column(children: [
        //                         //     TextFormField(
        //                         //       textAlign: TextAlign.start,
        //                         //       minLines: 1,
        //                         //       maxLines: 2,
        //                         //       keyboardType: TextInputType.multiline,
        //                         //       // controller: model.lensl2,
        //                         //       decoration: const InputDecoration(
        //                         //         contentPadding:
        //                         //         EdgeInsets.only(top: 10, left: 4),
        //                         //         //labelText: 'Lens Tint',
        //                         //         //hintText: 'Enter Email',
        //                         //         enabledBorder: UnderlineInputBorder(
        //                         //             borderSide: BorderSide(
        //                         //                 color: Color(0xffADADAD))),
        //                         //         focusedBorder: UnderlineInputBorder(
        //                         //             borderSide:
        //                         //             BorderSide(color: Colors.blue)),
        //                         //
        //                         //         border: InputBorder.none,
        //                         //       ),
        //                         //     ),
        //                         //   ]),
        //                         //   Column(children: [
        //                         //     TextFormField(
        //                         //       textAlign: TextAlign.start,
        //                         //       minLines: 1,
        //                         //       maxLines: 2,
        //                         //       keyboardType: TextInputType.multiline,
        //                         //       // controller: model.lensl3,
        //                         //       decoration: const InputDecoration(
        //                         //         contentPadding:
        //                         //         EdgeInsets.only(top: 10, left: 4),
        //                         //         //labelText: 'Lens Tint',
        //                         //         //hintText: 'Enter Email',
        //                         //         enabledBorder: UnderlineInputBorder(
        //                         //             borderSide: BorderSide(
        //                         //                 color: Color(0xffADADAD))),
        //                         //         focusedBorder: UnderlineInputBorder(
        //                         //             borderSide:
        //                         //             BorderSide(color: Colors.blue)),
        //                         //
        //                         //         border: InputBorder.none,
        //                         //       ),
        //                         //     ),
        //                         //   ]),
        //                         //   Column(children: [
        //                         //     TextFormField(
        //                         //       textAlign: TextAlign.start,
        //                         //       minLines: 1,
        //                         //       maxLines: 2,
        //                         //       keyboardType: TextInputType.multiline,
        //                         //       // controller: model.lensl4,
        //                         //       decoration: const InputDecoration(
        //                         //         contentPadding:
        //                         //         EdgeInsets.only(top: 10, left: 4),
        //                         //         //labelText: 'Lens Tint',
        //                         //         //hintText: 'Enter Email',
        //                         //         enabledBorder: UnderlineInputBorder(
        //                         //             borderSide: BorderSide(
        //                         //                 color: Color(0xffADADAD))),
        //                         //         focusedBorder: UnderlineInputBorder(
        //                         //             borderSide:
        //                         //             BorderSide(color: Colors.blue)),
        //                         //
        //                         //         border: InputBorder.none,
        //                         //       ),
        //                         //     ),
        //                         //   ]),
        //                         //   Column(children: [
        //                         //     TextFormField(
        //                         //       textAlign: TextAlign.start,
        //                         //       minLines: 1,
        //                         //       maxLines: 2,
        //                         //       keyboardType: TextInputType.multiline,
        //                         //       // controller: model.lensl5,
        //                         //       decoration: const InputDecoration(
        //                         //         contentPadding:
        //                         //         EdgeInsets.only(top: 10, left: 4),
        //                         //         //labelText: 'Lens Tint',
        //                         //         //hintText: 'Enter Email',
        //                         //         enabledBorder: UnderlineInputBorder(
        //                         //             borderSide: BorderSide(
        //                         //                 color: Color(0xffADADAD))),
        //                         //         focusedBorder: UnderlineInputBorder(
        //                         //             borderSide:
        //                         //             BorderSide(color: Colors.blue)),
        //                         //
        //                         //         border: InputBorder.none,
        //                         //       ),
        //                         //     ),
        //                         //   ]),
        //                         //   Column(children: [
        //                         //     TextFormField(
        //                         //       textAlign: TextAlign.start,
        //                         //       minLines: 1,
        //                         //       maxLines: 2,
        //                         //       keyboardType: TextInputType.multiline,
        //                         //       // controller: model.lensl6,
        //                         //       decoration: const InputDecoration(
        //                         //         contentPadding:
        //                         //         EdgeInsets.only(top: 10, left: 4),
        //                         //         //labelText: 'Lens Tint',
        //                         //         //hintText: 'Enter Email',
        //                         //         enabledBorder: UnderlineInputBorder(
        //                         //             borderSide: BorderSide(
        //                         //                 color: Color(0xffADADAD))),
        //                         //         focusedBorder: UnderlineInputBorder(
        //                         //             borderSide:
        //                         //             BorderSide(color: Colors.blue)),
        //                         //
        //                         //         border: InputBorder.none,
        //                         //       ),
        //                         //     ),
        //                         //   ]),
        //                         // ]),
        //                       ],
        //                     ),
        //                   ),
        //                   SizedBox(height: 15),
        //                 ],
        //               ),
        //             ),
        //
        //             SizedBox(height: 10),
        //
        //             InkWell(
        //               onTap: () => model.goToSetDentalNote(patient.id),
        //               child: Container(
        //                 height: 40,
        //                 decoration: BoxDecoration(
        //                     color: Palettes.kcBlueMain1,
        //                     borderRadius: BorderRadius.circular(10)),
        //                 // padding:
        //                 // const EdgeInsets.fromLTRB(50, 20, 50, 16),
        //                 width: MediaQuery.of(context).size.width,
        //                 child: Center(
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: [
        //                         Icon(
        //                             CupertinoIcons.add_circled,
        //                           color: Colors.white,
        //                         ),
        //                         Text(
        //                   ' Add RX',
        //                   textAlign: TextAlign.center,
        //                   style: TextStyle(
        //                         // fontWeight: FontWeight.bold,
        //                         color: Colors.white
        //                   ),
        //                 ),
        //                       ],
        //                     )),
        //               ),
        //             ),
        //
        //             SizedBox(height: 10),
        //             Container(
        //               padding: EdgeInsets.all(5),
        //               decoration: BoxDecoration(
        //                   border: Border.all(color: Colors.black, width: 2)),
        //               child: Column(
        //                 children: [
        //                   SizedBox(height: 5),
        //
        //                   //PEDIATRIC UPPER
        //                   GridView.builder(
        //                     itemCount: 10,
        //                     shrinkWrap: true,
        //                     primary: false,
        //                     gridDelegate:
        //                         SliverGridDelegateWithFixedCrossAxisCount(
        //                             crossAxisCount: 10,
        //                             mainAxisExtent: 60,
        //                             crossAxisSpacing: 1),
        //                     itemBuilder: (context, index) => ToothWidget(
        //                       isUpper: true,
        //                       hasRecord: model.hasHistory(
        //                           model.toothIdFromA[index].toString()),
        //                       isSelected: model.isSelected(
        //                           model.toothIdFromA[index].toString()),
        //                       onTap: () {
        //                         if (model.hasHistory(
        //                                 model.toothIdFromA[index].toString()) &&
        //                             !(model.isInSelectionMode)) {
        //                           model.viewDentalNoteById(
        //                               patient: patient,
        //                               selectedTooth: model.toothIdFromA[index]);
        //                         } else {
        //                           model.addToSelectedTooth(
        //                               model.toothIdFromA[index].toString());
        //                         }
        //                       },
        //                       isCenterTooth: model
        //                           .checkCenterTooth1(model.toothIdFromA[index]),
        //                       toothId: model.toothIdFromA[index],
        //                     ),
        //                   ),
        //                   SizedBox(height: 10),
        //
        //                   //PEDIATRIC LOWER
        //                   GridView.builder(
        //                     itemCount: 10,
        //                     shrinkWrap: true,
        //                     primary: false,
        //                     gridDelegate:
        //                         SliverGridDelegateWithFixedCrossAxisCount(
        //                             crossAxisSpacing: 1,
        //                             crossAxisCount: 10,
        //                             mainAxisExtent: 60),
        //                     itemBuilder: (context, index) => ToothWidget(
        //                       isSelected: model.isSelected(
        //                           model.toothIdFromT[index].toString()),
        //                       hasRecord: model.hasHistory(
        //                           model.toothIdFromT[index].toString()),
        //                       onTap: () {
        //                         if (model.hasHistory(
        //                                 model.toothIdFromT[index].toString()) &&
        //                             !(model.isInSelectionMode)) {
        //                           model.viewDentalNoteById(
        //                               patient: patient,
        //                               selectedTooth: model.toothIdFromT[index]);
        //                         } else {
        //                           model.addToSelectedTooth(
        //                               model.toothIdFromT[index].toString());
        //                         }
        //                       },
        //                       isUpper: false,
        //                       isCenterTooth: model
        //                           .checkCenterTooth1(model.toothIdFromT[index]),
        //                       toothId: model.toothIdFromT[index],
        //                     ),
        //                   ),
        //                   SizedBox(height: 5),
        //                 ],
        //               ),
        //             ),
        //             SizedBox(height: 15),
        //
        //             //second row of teeth chart
        //             Container(
        //               padding: EdgeInsets.all(5),
        //               decoration: BoxDecoration(
        //                   border: Border.all(color: Colors.black, width: 2)),
        //               child: Column(
        //                 children: [
        //                   Text('Upper', style: TextStyles.tsHeading5()),
        //                   SizedBox(height: 5),
        //
        //                   //ADULT UPPER
        //                   Container(
        //                     decoration: BoxDecoration(
        //                         border:
        //                             Border.all(color: Colors.black, width: 1)),
        //                     child: GridView.builder(
        //                       itemCount: 16,
        //                       shrinkWrap: true,
        //                       primary: false,
        //                       gridDelegate:
        //                           SliverGridDelegateWithFixedCrossAxisCount(
        //                         crossAxisCount: 8,
        //                         mainAxisExtent: 60,
        //                       ),
        //                       itemBuilder: (context, index) => ToothWidget(
        //                         onTap: () {
        //                           if (model.hasHistory(model.toothIdFrom1[index]
        //                                   .toString()) &&
        //                               !(model.isInSelectionMode)) {
        //                             model.viewDentalNoteById(
        //                                 patient: patient,
        //                                 selectedTooth: model.toothIdFrom1[index]
        //                                     .toString());
        //                           } else {
        //                             model.addToSelectedTooth(
        //                                 model.toothIdFrom1[index].toString());
        //                           }
        //                         },
        //                         isSelected: model.isSelected(
        //                             model.toothIdFrom1[index].toString()),
        //                         hasRecord: model.hasHistory(
        //                             model.toothIdFrom1[index].toString()),
        //                         isUpper: true,
        //                         toothId: model.toothIdFrom1[index].toString(),
        //                         isCenterTooth: model.checkCenterTooth2(
        //                             model.toothIdFrom1[index].toString()),
        //                       ),
        //                     ),
        //                   ),
        //                   SizedBox(height: 8),
        //
        //                   //ADULT LOWER
        //                   Divider(
        //                     thickness: 1,
        //                     color: Colors.black,
        //                   ),
        //                   Text('Lower', style: TextStyles.tsHeading5()),
        //                   SizedBox(height: 5),
        //                   Container(
        //                     padding: EdgeInsets.all(5),
        //                     decoration: BoxDecoration(
        //                         border:
        //                             Border.all(color: Colors.black, width: 1)),
        //                     child: GridView.builder(
        //                       itemCount: 16,
        //                       shrinkWrap: true,
        //                       primary: false,
        //                       gridDelegate:
        //                           SliverGridDelegateWithFixedCrossAxisCount(
        //                         crossAxisCount: 8,
        //                         mainAxisExtent: 60,
        //                       ),
        //                       itemBuilder: (context, index) => ToothWidget(
        //                         onTap: () {
        //                           if (model.hasHistory(model
        //                                   .toothIdFrom32[index]
        //                                   .toString()) &&
        //                               !(model.isInSelectionMode)) {
        //                             model.viewDentalNoteById(
        //                                 patient: patient,
        //                                 selectedTooth: model
        //                                     .toothIdFrom32[index]
        //                                     .toString());
        //                           } else {
        //                             model.addToSelectedTooth(
        //                                 model.toothIdFrom32[index].toString());
        //                           }
        //                         },
        //                         hasRecord: model.hasHistory(
        //                             model.toothIdFrom32[index].toString()),
        //                         isSelected: model.isSelected(
        //                             model.toothIdFrom32[index].toString()),
        //                         isUpper: false,
        //                         isCenterTooth: model.checkCenterTooth2(
        //                             model.toothIdFrom32[index].toString()),
        //                         toothId: model.toothIdFrom32[index].toString(),
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
