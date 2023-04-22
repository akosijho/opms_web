import 'package:age_calculator/age_calculator.dart';
import 'package:opmswebstaff/constants/font_name/font_name.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/ui/widgets/patient_card/patient_card.dart';
import 'package:opmswebstaff/ui/widgets/payment_dental_note_card/payment_dental_note_card.dart';
import 'package:opmswebstaff/ui/widgets/payment_medicine_card/payment_medicine_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../../constants/styles/palette_color.dart';
import '../../../constants/styles/text_border_styles.dart';
import '../../../models/patient_model/patient_model.dart';
import 'add_payment_view_model.dart';

class AddPaymentView extends StatelessWidget {
  final Patient patient;
  const AddPaymentView({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPaymentViewModel>.reactive(
      viewModelBuilder: () => AddPaymentViewModel(),
      onModelReady: (model) {
        model.init();
      },
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Add Payment'),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                color: Colors.grey.shade500,
                width: 1,
              )),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ]),
          height: 55,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Total Payment',
                        style: TextStyles.tsHeading5(),
                      ),
                      Text(
                        '${model.totalAmountFinal}'.toCurrency!,
                        style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 18,
                            fontFamily: FontNames.sfPro,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => model.savePaymentInfo(
                  paymentType: model.paymentTypeTxtController.text,
                  dentist: model.dentistTxtController.text,
                  totalAmountFinal: model.totalAmountFinal,
                  patientId: patient.id,
                  dentalNoteSubTotal: model.dentalNoteSubTotal,
                  medicineSubTotal: model.medicineSubTotal,
                  selectedMedicine: model.selectedMedicines,
                  selectedNotes: model.selectedDentalNotes,
                  patient_name: patient.fullName,
                ),
                child: Container(
                  height: double.maxFinite,
                  color: Palettes.kcPurpleMain,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  alignment: Alignment.center,
                  child: Text(
                    'Save Payment',
                    style: TextStyles.tsButton1(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Form(
          key: model.addPaymentFormKey,
          child: Scrollbar(
            radius: Radius.circular(40),
            thickness: 8,
            interactive: true,
            child: SafeArea(
              bottom: true,
              top: false,
              child: ListView(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: PatientCard(
                      // image: patient.image,
                      name: patient.fullName,
                      phone: patient.phoneNum,
                      address: patient.address,
                      dateCreated: patient.dateCreated!,
                      birthDate: DateFormat.yMMMd()
                          .format(patient.birthDate.toDateTime()!),
                      age: AgeCalculator.age(patient.birthDate.toDateTime()!,
                              today: DateTime.now())
                          .years
                          .toString(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Payment Info',
                              style: TextStyles.tsHeading4(),
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: Divider(
                                color: Palettes.kcPurpleMain,
                                height: 3,
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => model.showSelectDentist(),
                          child: TextFormField(
                            controller: model.dentistTxtController,
                            textInputAction: TextInputAction.next,
                            enabled: false,
                            validator: (value) =>
                                model.validatorService.validateDentist(value!),
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                                errorBorder: TextBorderStyles.errorBorder,
                                errorStyle: TextStyles.errorTextStyle,
                                disabledBorder: TextBorderStyles.normalBorder,
                                hintText: 'Select Optometrist',
                                labelText: 'Optometrist In-Charge*',
                                labelStyle: TextStyles.tsBody1(
                                    color: Palettes.kcNeutral1),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 24,
                                  color: Palettes.kcBlueMain1,
                                )),
                          ),
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () => model.showSelectPaymentType(),
                          child: TextFormField(
                            controller: model.paymentTypeTxtController,
                            textInputAction: TextInputAction.next,
                            enabled: false,
                            validator: (value) => model.validatorService
                                .validatePaymentType(value!),
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                                errorBorder: TextBorderStyles.errorBorder,
                                errorStyle: TextStyles.errorTextStyle,
                                disabledBorder: TextBorderStyles.normalBorder,
                                hintText: 'Payment Method',
                                labelText: 'Payment Type*',
                                labelStyle: TextStyles.tsBody1(
                                    color: Palettes.kcNeutral1),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 24,
                                  color: Palettes.kcBlueMain1,
                                )),
                          ),
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () => model.selectDate(),
                          child: TextFormField(
                            controller: model.dateTxtController,
                            textInputAction: TextInputAction.next,
                            enabled: false,
                            validator: (value) =>
                                model.validatorService.validateDate(value!),
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                                errorBorder: TextBorderStyles.errorBorder,
                                errorStyle: TextStyles.errorTextStyle,
                                disabledBorder: TextBorderStyles.normalBorder,
                                hintText: 'Select Date',
                                labelText: 'Date of Payment*',
                                labelStyle: TextStyles.tsBody1(
                                    color: Palettes.kcNeutral1),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 24,
                                  color: Palettes.kcBlueMain1,
                                )),
                          ),
                        ),
                        SizedBox(height: 4),
                        TextFormField(
                          controller: model.remarksTxtController,
                          textInputAction: TextInputAction.done,
                          maxLines: 3,
                          maxLength: 80,
                          decoration: InputDecoration(
                            hintText: 'Type here',
                            labelText: 'Remark & Notes (Optional)',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                                fontSize: 20, color: Palettes.kcNeutral1),
                            enabledBorder: TextBorderStyles.normalBorder,
                            focusedBorder: TextBorderStyles.focusedBorder,
                          ),
                        ),
                        Container(
                          height: 10,
                          color: Colors.grey.shade200,
                        ),
                        // GestureDetector(
                        //   onTap: () => model.goToSelectProcedure(patient.id),
                        //   child: TextFormField(
                        //     controller: model.procedureTxtController,
                        //     validator: (value) =>
                        //         model.validatorService.validateProcedureName(value!),
                        //     textInputAction: TextInputAction.next,
                        //     enabled: false,
                        //     keyboardType: TextInputType.datetime,
                        //     decoration: InputDecoration(
                        //         errorBorder: TextBorderStyles.errorBorder,
                        //         errorStyle: TextStyles.errorTextStyle,
                        //         disabledBorder: TextBorderStyles.normalBorder,
                        //         hintText: 'Select Service Rendered',
                        //         labelText: 'Service*',
                        //         labelStyle:
                        //         TextStyle(fontSize: 21, color: Palettes.kcNeutral1),
                        //         floatingLabelBehavior: FloatingLabelBehavior.always,
                        //         suffixIcon: Icon(
                        //           Icons.arrow_drop_down,
                        //           size: 24,
                        //           color: Palettes.kcBlueMain1,
                        //         )),
                        //   ),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Notes or Services',
                              style: TextStyles.tsButton1(),
                            ),

                            ActionChip(
                              label: Text(
                                  0 <= 0 ? 'Select Optical Service' : 'Add more'),
                              labelPadding: EdgeInsets.symmetric(horizontal: 8),
                              labelStyle:
                                  TextStyles.tsBody2(color: Colors.white),
                              backgroundColor: Palettes.kcBlueMain1,
                              tooltip: 'Select Optical Service',
                              onPressed: () =>
                                  model.selectDentalNote(patient.id),
                            )
                          ],
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: model.selectedDentalNotes.isNotEmpty
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemBuilder: (context, index) =>
                                      PaymentDentalNoteCard(
                                          dentalNote:
                                              model.selectedDentalNotes[index],
                                          patientID: patient.id),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 10),
                                  itemCount: model.selectedDentalNotes.length)
                              : SizedBox(
                                  height: 100,
                                  child:
                                      Center(child: Text('No Notes Selected'))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Product',
                              style: TextStyles.tsButton1(),
                            ),
                            ActionChip(
                              label:
                                  Text(0 <= 0 ? 'Select Product' : 'Add more'),
                              labelPadding: EdgeInsets.symmetric(horizontal: 8),
                              labelStyle:
                                  TextStyles.tsBody2(color: Colors.white),
                              backgroundColor: Palettes.kcBlueMain1,
                              tooltip: 'Select Product',
                              onPressed: () =>
                                  model.selectMedicines(patient.id),
                            ),
                          ],
                        ),
                        model.selectedMedicines.isNotEmpty
                            ? Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemBuilder: (context, index) =>
                                        PaymentMedicineCard(
                                            medicine:
                                                model.selectedMedicines[index]),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 4),
                                    itemCount: model.selectedMedicines.length),
                              )
                            : Container(
                                height: 50,
                                width: double.maxFinite,
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                child: Text('No Product Selected'),
                              ),
                        SizedBox(height: 6),
                        Container(
                          height: 8,
                          color: Colors.grey.shade200,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          color: Colors.grey.shade50,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Optical Note Sub Total:',
                                      style: TextStyles.tsHeading5(),
                                    ),
                                  ),
                                  Text(
                                    // '${model.dentalNoteSubTotal.toString().toCurrency}',
                                    '${model.serviceSubTotal.toString().toCurrency}',
                                    style: TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Product Sub Total:',
                                      style: TextStyles.tsHeading5(),
                                    ),
                                  ),
                                  Text(
                                    '${model.medicineSubTotal}'.toCurrency!,
                                    style: TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                height: 60,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Total Amount:',
                                        style: TextStyles.tsHeading5(),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.deepOrangeAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        enabled:

                                      //   model.dentalNoteSubTotal == 0 &&
                                      // model.medicineSubTotal == 0,
                                            model.serviceSubTotal == 0 &&
                                                model.medicineSubTotal == 0,
                                        controller:
                                            model.totalAmountTxtController,
                                        onChanged: (value) =>
                                            model.onTotalAmountTextEdit(value),
                                        validator: (value) => model
                                            .validatorService
                                            .validatePrice(value!),
                                        enableInteractiveSelection: false,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          fillColor: Colors.white,
                                          filled: true,
                                          constraints: BoxConstraints(
                                              maxHeight: 60, minHeight: 60),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: BorderSide(
                                                  color:
                                                      Colors.deepOrangeAccent)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            borderSide: BorderSide(
                                                color: Colors.deepOrangeAccent,
                                                width: 2),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 2),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 2),
                                          ),
                                          errorStyle: TextStyle(
                                              color: Colors.red, height: 0),
                                          hintText: 'Set Amount',
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          height: 8,
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
