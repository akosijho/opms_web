import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/models/balance_notes/balance_notes.dart';

import '../../../app/app.locator.dart';

class SelectBalanceNoteCard extends StatefulWidget {
  final BalanceNotes balanceNote;
  final VoidCallback? onDone;
  final bool value;
  final Function() onChanged;
  final dynamic patientId;
  final List<BalanceNotes> selectedBalanceNotes;
  final List<BalanceNotes> listOfBalanceNotes;
  const SelectBalanceNoteCard(
      {Key? key,
        required this.balanceNote,
        this.onDone,
        required this.value,
        required this.onChanged,
        required this.patientId,
        required this.selectedBalanceNotes,
        required this.listOfBalanceNotes})
      : super(key: key);

  @override
  State<SelectBalanceNoteCard> createState() => _SelectBalanceNoteCardState();
}

class _SelectBalanceNoteCardState extends State<SelectBalanceNoteCard> {
  final priceTextController = TextEditingController();
  final apiService = locator<ApiService>();
  final validatorService = locator<ValidatorService>();

  @override
  void dispose() {
    priceTextController.dispose();
    super.dispose();
  }

  Future<void> updateBalanceAmount() async {
    await apiService.updateBalanceAmountField(
        patientId: widget.patientId,
        balance_noteId: widget.balanceNote.id,
        price: priceTextController.text);
  }

  // void updateAmountOfSelectedItem(
  //     {required List<BalanceNotes> listOfSelectedBalanceNote,
  //       required List<BalanceNotes> listOfNotes,
  //       required String selectedNoteId,
  //       required String newAmount}) {
  //   for (BalanceNotes balanceNotes in listOfSelectedBalanceNote) {
  //     if (balanceNotes.id == selectedNoteId) {
  //       balanceNotes.balance.price = newAmount;
  //       debugPrint("Updated" + opticalNotes.service.price!);
  //     }
  //   }
  //   for (OpticalNotes opticalNotes in listOfNotes) {
  //     if (opticalNotes.id == selectedNoteId) {
  //       opticalNotes.service.price = newAmount;
  //       debugPrint("Updated" + opticalNotes.service.price!);
  //     }
  //   }
  // }

  @override
  void initState() {
    priceTextController.text = widget.balanceNote.balance.toCurrency ?? 'Not Set';
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
                    // RichText(
                    //     text: TextSpan(
                    //         text: 'Service:\n',
                    //         style: TextStyles.tsBody2(),
                    //         children: [
                    //           TextSpan(
                    //               text: widget.opticalNote.service.serviceName,
                    //               style: TextStyles.tsHeading5())
                    //         ])),
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
                                      .format(widget.balanceNote.date.toDateTime()!),
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
                            // onChanged: (value) {
                            //   updateAmountOfSelectedItem(
                            //       selectedNoteId: widget.opticalNote.id,
                            //       listOfSelectedOpticalNote:
                            //       widget.selectedOptialNotes,
                            //       newAmount: priceTextController.text,
                            //       listOfNotes: widget.listOfOpticalNotes);
                            //   updateDentalAmount();
                            // },
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
