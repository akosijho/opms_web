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
                    label: Text('Save', style: TextStyle(fontSize: 14)),
                    onPressed: () {
                      if (model.setOpticalNoteFormKey.currentState!.validate()) {
                        List<String> eye = [];

                        model.addOpticalNote(
                          patientId: patient.id,
                        );
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
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.history,
                    color: Colors.white,
                  ),
                  // onPressed: () => model.navigationService.pushNamed(
                  //     Routes.ViewOpticalNote,
                  //     arguments: ViewOpticalNoteArguments(patient: patient)),
                  onPressed: () => model.goToOpticalNote(context, patient),
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
                  // onPressed: () => model.navigationService.pushNamed(
                  //     Routes.AddPaymentView,
                  //     arguments: AddPaymentViewArguments(patient: patient)),
                  onPressed: () => model.goToAddPayment(context, patient),
                  label: Text('Add Payment'),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyles.tsBody2(),
                    primary: Palettes.kcNeutral1,
                  ),
                ),
              ]),
            ],
          ),
        ],
        body: Form(
          key: model.setOpticalNoteFormKey,
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
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ))),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Table(
                        //defaultColumnWidth: FixedColumnWidth(120.0),
                        border: TableBorder.all(
                            color: Colors.black,
                            //stylFe: BorderStyle.solid,
                            width: 1),
                        children: [
                          TableRow(children: [
                            Column(children: [
                              Align(
                                  alignment: Alignment.center,
                                  child: Text( 'Right(OD)\n/\nLeft(OS)', textAlign: TextAlign.center))
                            ]),
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
                                  border: InputBorder.none,
                                ),
                              ),
                            ]),
                          ]),
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
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Right(OD)\n/\nLeft(OS)',
                                    textAlign: TextAlign.center
                                ),
                              )
                            ]),
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

                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => model.selectDate(context),
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
                onTap: () => model.goToSelectService(context),
                child: TextFormField(
                  controller: model.serviceTxtController,
                  validator: (value) =>
                      model.validatorService.validateServiceName(value!),
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
