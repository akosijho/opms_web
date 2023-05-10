import 'package:flutter/material.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/ui/views/payment_select_balance_note/payment_select_balance_note_view_model.dart';
import 'package:opmswebstaff/ui/widgets/select_balance_note_card/select_balance_note_card.dart';
import 'package:stacked/stacked.dart';



class PaymentSelectBalanceNoteView extends StatelessWidget {
  final String patientId;
  const PaymentSelectBalanceNoteView({Key? key, required this.patientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentSelectBalanceNoteViewModel>.reactive(
      viewModelBuilder: () => PaymentSelectBalanceNoteViewModel(),
      onModelReady: (model) => model.init(patientId),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Select Balance Note'),
          centerTitle: true,
        ),
        persistentFooterButtons: [
          Container(
            color: Colors.white,
            width: double.maxFinite,
            child: ElevatedButton(
                onPressed: () => model.returnSelectedBalanceNote(),
                child: Text('Confirm',
                style: TextStyle(
                  fontSize: 16
                ),
                )),
          )
        ],
        body: Form(
          key: model.opticalFormKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Unpaid Balance Note List',
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
                    child: model.listOfUnpaidBalanceNotes.length > 0
                        ? ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) =>
                          SelectBalanceNoteCard(
                            balanceNote:
                            model.listOfUnpaidBalanceNotes[index],
                            onChanged: () =>
                                model.addToSelectedBalanceNote(
                                    model.listOfUnpaidBalanceNotes[index]),
                            value: model.balanceNoteExistInSelectedNotes(
                                model.listOfUnpaidBalanceNotes[index].id),
                            patientId: patientId,
                            selectedBalanceNotes: model.selectedBalanceNote,
                            listOfBalanceNotes:
                            model.listOfUnpaidBalanceNotes,
                          ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 8),
                      itemCount: model.listOfUnpaidBalanceNotes.length,
                    )
                        : Center(
                      child: Text('No Balance Notes Found...'),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
