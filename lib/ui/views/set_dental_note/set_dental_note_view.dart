import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_border_styles.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/ui/views/set_dental_note/set_dental_note_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class SetDentalNoteView extends StatelessWidget {
  final List<String> selectedTeeth;
  final dynamic patientId;
  const SetDentalNoteView(
      {Key? key, required this.selectedTeeth, required this.patientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetDentalNoteViewModel>.reactive(
      viewModelBuilder: () => SetDentalNoteViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Palettes.kcBlueMain1),
          title: Text('Set Dental Note'),
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
                        patientId: patientId, selectedTeeth: selectedTeeth);
                  }
                },
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
                      hintText: 'Select Procedure Rendered',
                      labelText: 'Procedure*',
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
