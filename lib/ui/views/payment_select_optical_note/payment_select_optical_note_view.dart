import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:opmswebstaff/ui/widgets/select_optical_note_card/select_optical_note_card.dart';
import 'package:stacked/stacked.dart';

import 'payment_select_optical_note_view_model.dart';

class PaymentSelectOpticalNoteView extends StatelessWidget {
  final String patientId;
  const PaymentSelectOpticalNoteView({Key? key, required this.patientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentSelectOpticalNoteViewModel>.reactive(
      viewModelBuilder: () => PaymentSelectOpticalNoteViewModel(),
      onModelReady: (model) => model.init(patientId),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Select Dental Note'),
          centerTitle: true,
        ),
        persistentFooterButtons: [
          Container(
            color: Colors.white,
            // width: double.maxFinite,
            child: ElevatedButton(
                onPressed: () => model.returnSelectedDentalNote(),
                child: Text('Confirm')),
          )
        ],
        body: Form(
          key: model.dentalFormKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Unpaid Dental Note List',
                      style: TextStyles.tsHeading5(),
                    ),
                    SizedBox(width: 2),
                    Expanded(
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: Palettes.kcPurpleMain,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Container(
                  color: Colors.grey.shade200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Select All'),
                      Checkbox(
                        value: model.selectAll,
                        onChanged: (value) {
                          model.toogleSelectAll();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                model.isBusy
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 5),
                            Text('Loading Data...'),
                          ],
                        ),
                      )
                    : Expanded(
                        child: model.listOfUnpaidDentalNotes.length > 0
                            ? ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) =>
                                    SelectOpticalNoteCard(
                                  dentalNote:
                                      model.listOfUnpaidDentalNotes[index],
                                  onChanged: () =>
                                      model.addToSelectedDentalNote(
                                          model.listOfUnpaidDentalNotes[index]),
                                  value: model.dentalNoteExistInSelectedNotes(
                                      model.listOfUnpaidDentalNotes[index].id),
                                  patientId: patientId,
                                  selectedDentalNotes: model.selectedDentalNote,
                                  listOfDentalNotes:
                                      model.listOfUnpaidDentalNotes,
                                ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 8),
                                itemCount: model.listOfUnpaidDentalNotes.length,
                              )
                            : Center(
                                child: Text('No Dental Notes Found...'),
                              )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
