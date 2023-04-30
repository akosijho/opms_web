
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/models/optical_notes/optical_notes.dart';

import '../../../app/app.locator.dart';

class SelectOpticalNoteCard extends StatefulWidget {
  final OpticalNotes dentalNote;
  final VoidCallback? onDone;
  final bool value;
  final Function() onChanged;
  final dynamic patientId;
  final List<OpticalNotes> selectedDentalNotes;
  final List<OpticalNotes> listOfDentalNotes;
  const SelectOpticalNoteCard(
      {Key? key,
      required this.dentalNote,
      this.onDone,
      required this.value,
      required this.onChanged,
      required this.patientId,
      required this.selectedDentalNotes,
      required this.listOfDentalNotes})
      : super(key: key);

  @override
  State<SelectOpticalNoteCard> createState() => _SelectOpticalNoteCardState();
}

class _SelectOpticalNoteCardState extends State<SelectOpticalNoteCard> {
  final priceTextController = TextEditingController();
  final apiService = locator<ApiService>();
  final validatorService = locator<ValidatorService>();

  @override
  void dispose() {
    priceTextController.dispose();
    super.dispose();
  }

  Future<void> updateDentalAmount() async {
    await apiService.updateOpticalAmountField(
        patientId: widget.patientId,
        dental_noteId: widget.dentalNote.id,
        procedureId: widget.dentalNote.service.id,
        price: priceTextController.text);
  }

  void updateAmountOfSelectedItem(
      {required List<OpticalNotes> listOfSelectedDentalNote,
      required List<OpticalNotes> listOfNotes,
      required String selectedNoteId,
      required String newAmount}) {
    for (OpticalNotes dentalNotes in listOfSelectedDentalNote) {
      if (dentalNotes.id == selectedNoteId) {
        dentalNotes.service.price = newAmount;
        debugPrint("Updated" + dentalNotes.service.price!);
      }
    }
    for (OpticalNotes dentalNotes in listOfNotes) {
      if (dentalNotes.id == selectedNoteId) {
        dentalNotes.service.price = newAmount;
        debugPrint("Updated" + dentalNotes.service.price!);
      }
    }
  }

  @override
  void initState() {
    priceTextController.text = widget.dentalNote.service.price ?? 'Not Set';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: CheckboxListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey)),
        controlAffinity: ListTileControlAffinity.leading,
        value: widget.value,
        onChanged: (value) => widget.onChanged(),
        selectedTileColor: Colors.blue,
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 25,
                    //   child: Row(
                    //     children: [
                    //       // Align(
                    //       //     alignment: Alignment.bottomCenter,
                    //       //     child: Text('Tooth Number : ')),
                    //       Container(
                    //         height: 25,
                    //         width: 25,
                    //         decoration: BoxDecoration(
                    //             color: Palettes.kcPurpleMain,
                    //             borderRadius: BorderRadius.circular(2)),
                    //         child: Center(
                    //           child: Text(
                    //             widget.dentalNote.sphere,
                    //             // widget.dentalNote.selectedTooth,
                    //             softWrap: true,
                    //             style:
                    //                 TextStyles.tsHeading5(color: Colors.white),
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Divider(
                      height: 10,
                      color: Colors.grey,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Service:\n',
                            style: TextStyles.tsBody2(),
                            children: [
                          TextSpan(
                              text: widget.dentalNote.service.serviceName,
                              style: TextStyles.tsHeading5())
                        ])),
                    Divider(
                      height: 10,
                      color: Colors.grey,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Date Rendered:\n',
                            style: TextStyles.tsBody2(),
                            children: [
                          TextSpan(
                              text: DateFormat.yMd()
                                  .add_jm()
                                  .format(widget.dentalNote.date.toDateTime()!),
                              style: TextStyles.tsHeading5())
                        ])),
                    Divider(
                      height: 5,
                      color: Colors.grey,
                    ),
                    Row(
                      children: [
                        Text(
                          'Amount: ',
                          style: TextStyle(color: Colors.deepOrangeAccent),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: priceTextController,
                            enableInteractiveSelection: false,
                            keyboardType: TextInputType.numberWithOptions(),
                            textInputAction: TextInputAction.done,
                            validator: (value) =>
                                validatorService.validatePrice(value!),
                            textAlign: TextAlign.center,
                            // onEditingComplete: () => updateDentalAmount(),
                            onChanged: (value) {
                              updateAmountOfSelectedItem(
                                  selectedNoteId: widget.dentalNote.id,
                                  listOfSelectedDentalNote:
                                      widget.selectedDentalNotes,
                                  newAmount: priceTextController.text,
                                  listOfNotes: widget.listOfDentalNotes);
                              updateDentalAmount();
                            },
                            decoration: InputDecoration(
                              constraints:
                                  BoxConstraints(maxHeight: 60, minHeight: 40),
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide:
                                      BorderSide(color: Palettes.kcPurpleMain)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Palettes.kcPurpleMain, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              errorStyle: TextStyles.errorTextStyle,
                              hintText: 'Set Amount',
                              labelStyle: TextStyles.tsBody1(
                                  color: Palettes.kcNeutral1),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        contentPadding: EdgeInsets.all(2),
      ),
    );
  }
}
