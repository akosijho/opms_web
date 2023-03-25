import 'package:age_calculator/age_calculator.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_border_styles.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/enums/appointment_status.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/models/appointment_model/appointment_model.dart';
import 'package:opmswebstaff/models/patient_model/patient_model.dart';
import 'package:opmswebstaff/ui/views/create_appointment/create_appointment_view_model.dart';
import 'package:opmswebstaff/ui/widgets/patient_card/patient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class CreateAppointmentView extends StatefulWidget {
  final Patient patient;
  final int popTimes;
  const CreateAppointmentView(
      {required this.patient, required this.popTimes, Key? key})
      : super(key: key);

  @override
  State<CreateAppointmentView> createState() => _CreateAppointmentViewState();
}

class _CreateAppointmentViewState extends State<CreateAppointmentView> {
  final createAppointmentFormKey = GlobalKey<FormState>();

  final dateTxtController = TextEditingController();
  final startTimeTxtController = TextEditingController();
  final endTimeTxtController = TextEditingController();
  final dentistTxtController = TextEditingController();
  final remarksTxtController = TextEditingController();
  final procedureTxtController = TextEditingController();

  @override
  void dispose() {
    dateTxtController.dispose();
    startTimeTxtController.dispose();
    endTimeTxtController.dispose();
    dentistTxtController.dispose();
    remarksTxtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateAppointmentViewModel>.reactive(
        viewModelBuilder: () => CreateAppointmentViewModel(),
        builder: (context, model, child) =>
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Add Schedule',
                  style: TextStyles.tsHeading3(color: Colors.white),
                ),
              ),
              persistentFooterButtons: [
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: model.navigationService.pop,
                      child: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade700),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              if (createAppointmentFormKey.currentState!
                                  .validate()) {
                                if (!(model.selectedProcedures.length <= 0)) {
                                  model.setAppointment(
                                    appointment: AppointmentModel(
                                      patient: widget.patient,
                                      date: model.selectedAppointmentDate
                                          .toString(),
                                      startTime:
                                          model.selectedStartTime.toString(),
                                      endTime: model.selectedEndTime.toString(),
                                      dentist: dentistTxtController.text,
                                      procedures: model.selectedProcedures,
                                      appointment_status:
                                          AppointmentStatus.Pending.name,
                                    ),
                                    popTime: widget.popTimes,
                                    patientId: widget.patient.id,
                                  );
                                } else {
                                  model.snackBarService.showSnackBar(
                                      message: 'No Procedures Selected',
                                      title: 'Warning');
                                }
                              }
                            },
                            child: Text('Save'))),
                  ],
                )
              ],
              body: Form(
                key: createAppointmentFormKey,
                child: SafeArea(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    children: [
                      Divider(),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Patient Info',
                            style: TextStyles.tsHeading3(),
                            textAlign: TextAlign.center,
                          )),
                      PatientCard(
                        // image: widget.patient.image,
                        name: widget.patient.fullName,
                        phone: widget.patient.phoneNum,
                        address: widget.patient.address,
                        birthDate: DateFormat.yMMMd()
                            .format(widget.patient.birthDate.toDateTime()!),
                        age: AgeCalculator.age(
                                widget.patient.birthDate.toDateTime()!,
                                today: DateTime.now())
                            .years
                            .toString(),
                        dateCreated: widget.patient.dateCreated!,
                      ),
                      Divider(),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GestureDetector(
                              onTap: () => model.selectDate(dateTxtController),
                              child: TextFormField(
                                controller: dateTxtController,
                                enabled: false,
                                validator: (value) =>
                                    model.validatorService.validateDate(value!),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                    errorBorder: TextBorderStyles.errorBorder,
                                    errorStyle: TextStyles.errorTextStyle,
                                    disabledBorder:
                                        TextBorderStyles.normalBorder,
                                    hintText: 'MM/DD/YYYY',
                                    labelText: 'Appointment Date*',
                                    // disabledBorder: ,
                                    labelStyle: TextStyles.tsBody1(
                                        color: Palettes.kcNeutral1),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    suffixIcon: SvgPicture.asset(
                                      'assets/icons/Calendar.svg',
                                      color: Palettes.kcBlueMain1,
                                      fit: BoxFit.scaleDown,
                                    )),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Service*',
                                ),
                                ActionChip(
                                  label: Text(
                                      model.selectedProcedures.length <= 0
                                          ? 'Select'
                                          : 'Add more'),
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  labelStyle:
                                      TextStyles.tsBody2(color: Colors.white),
                                  backgroundColor: Palettes.kcBlueMain1,
                                  tooltip: 'Select Procedure',
                                  onPressed: () =>
                                      model.openProcedureFullScreenModal(
                                    procedureTxtController,
                                  ),
                                )
                              ],
                            ),
                            Visibility(
                              visible: model.selectedProcedures.length > 0
                                  ? true
                                  : false,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Palettes.kcBlueMain1, width: 1)),
                                padding: EdgeInsets.all(4),
                                child: Wrap(
                                  spacing: 4,
                                  children: model.selectedProcedures
                                      .map((e) => InputChip(
                                            label: Text(e.procedureName),
                                            backgroundColor:
                                                Colors.deepPurple.shade50,
                                            labelStyle: TextStyles.tsBody2(
                                                color: Colors.deepPurple),
                                            labelPadding: EdgeInsets.all(1),
                                            onDeleted: () => model
                                                .deleteSelectedProcedure(e),
                                            deleteIcon: CircleAvatar(
                                                radius: 10,
                                                backgroundColor:
                                                    Colors.red.shade700,
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 16,
                                                )),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  model.selectStartTime(startTimeTxtController),
                              child: TextFormField(
                                controller: startTimeTxtController,
                                enabled: false,
                                validator: (value) => model.validatorService
                                    .validateStartTime(value!),
                                decoration: InputDecoration(
                                  hintText: 'Set Start Time',
                                  labelText: 'Start Time*',
                                  labelStyle: TextStyles.tsBody1(
                                      color: Palettes.kcNeutral1),
                                  errorBorder: TextBorderStyles.errorBorder,
                                  errorStyle: TextStyles.errorTextStyle,
                                  disabledBorder: TextBorderStyles.normalBorder,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () =>
                                  model.selectEndTime(endTimeTxtController),
                              child: TextFormField(
                                controller: endTimeTxtController,
                                enabled: false,
                                validator: (value) => model.validatorService
                                    .validateEndTime(value!),
                                decoration: InputDecoration(
                                  hintText: 'Set End Time',
                                  labelText: 'End Time*',
                                  labelStyle: TextStyles.tsBody1(
                                      color: Palettes.kcNeutral1),
                                  errorBorder: TextBorderStyles.errorBorder,
                                  errorStyle: TextStyles.errorTextStyle,
                                  disabledBorder: TextBorderStyles.normalBorder,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () =>
                                  model.openDentistModal(dentistTxtController),
                              child: TextFormField(
                                controller: dentistTxtController,
                                textInputAction: TextInputAction.next,
                                enabled: false,
                                validator: (value) => model.validatorService
                                    .validateDentist(value!),
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                    errorBorder: TextBorderStyles.errorBorder,
                                    errorStyle: TextStyles.errorTextStyle,
                                    disabledBorder:
                                        TextBorderStyles.normalBorder,
                                    hintText: 'Select Optometrist',
                                    labelText: 'Optometrist*',
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
                            SizedBox(height: 10),
                            TextFormField(
                              controller: remarksTxtController,
                              decoration: InputDecoration(
                                hintText: 'Type here',
                                labelText: 'Remarks (Optional)',
                                labelStyle: TextStyles.tsBody1(
                                    color: Palettes.kcNeutral1),
                                enabledBorder: TextBorderStyles.normalBorder,
                                focusedBorder: TextBorderStyles.focusedBorder,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
