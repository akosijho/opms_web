import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_border_styles.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/ui/views/set_optical_note/set_optical_note_view_model.dart';
import 'package:stacked/stacked.dart';

class SetOpticalNoteView extends StatelessWidget {
  final List<String> selectedTeeth;
  final dynamic patientId;
  // final String sphere;
  // final String cylinder;
  // final String axis;
  const SetOpticalNoteView(
      {Key? key, required this.selectedTeeth, required this.patientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetOpticalNoteViewModel>.reactive(
      viewModelBuilder: () => SetOpticalNoteViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: Palettes.kcBlueMain1),
          title: Text('Set Optical Note'),
        ),
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton.icon(
                label: Text('Save'),
                onPressed: () {
                  if (model.setDentalNoteFormKey.currentState!.validate()) {
                    model.addDentalNote(
                      patientId: patientId, );
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
        ],
        body: Form(
          key: model.setDentalNoteFormKey,
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              Text(
                'Selected ${selectedTeeth.length > 1 ? 'Teeth' : 'Tooth'}: ',
                style: TextStyles.tsButton1(),
              ),
              SizedBox(height: 3),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: Palettes.kcNeutral1, width: 2),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: selectedTeeth.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                    mainAxisExtent: 30,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemBuilder: (context, index) => Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    color: Colors.blue,
                    child: Text(
                      selectedTeeth[index],
                      style: TextStyles.tsHeading4(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
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
                                  //hintText: 'Enter Email',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffADADAD))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blue)),

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
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffADADAD))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blue)),
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
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffADADAD))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blue)),
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
                                // controller: model.specr4,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'PD',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffADADAD))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blue)),
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
                                // controller: model.specr5,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'ADD',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffADADAD))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blue)),
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
                                // controller: model.specr6,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'V.A',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffADADAD))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blue)),
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
                                // controller: model.lensr1,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'SPHERE',
                                  //hintText: 'Enter Email',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffADADAD))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blue)),

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
                                // controller: model.lensr2,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'CYLINDER',
                                  //hintText: 'Enter Email',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffADADAD))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blue)),

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
                                // controller: model.lensr3,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'AXIS',
                                  //hintText: 'Enter Email',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffADADAD))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blue)),

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
                                // controller: model.lensr4,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'B.C',
                                  //hintText: 'Enter Email',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffADADAD))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blue)),

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
                                // controller: model.lensr5,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'DIA',
                                  //hintText: 'Enter Email',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffADADAD))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blue)),

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
                                // controller: model.lensr6,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 4),
                                  labelText: 'TINT',
                                  //hintText: 'Enter Email',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffADADAD))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blue)),

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
      ),
    );
  }
}
