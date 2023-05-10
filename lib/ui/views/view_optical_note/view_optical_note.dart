import 'package:opmswebstaff/ui/views/view_optical_note/view_optical_note_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opmswebstaff/ui/widgets/optical_balance_card/balance_card.dart';
import 'package:opmswebstaff/ui/widgets/optical_note_card/optical_note_card.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../models/patient_model/patient_model.dart';

class ViewOpticalNote extends StatelessWidget {
  final Patient patient;

  const ViewOpticalNote({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewOpticalNoteViewModel>.reactive(
      viewModelBuilder: () => ViewOpticalNoteViewModel(),
      onModelReady: (model) => {
        model.getOpticalNotes(patient.id),
        model.getPaymentBalance(patient.id)
      },
      // onModelReady: (model) => model.init(patient.id),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Payment Notes'),
        ),
        body: Container(
          color: Color.fromARGB(143, 234, 218, 236),
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Patient Payment Notes',
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Divider(
                      height: 2,
                      thickness: 2,
                      color: Palettes.kcDarkerBlueMain1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              model.isBusy
                  ? Container(
                height: 500,
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text('Loading')
                      ],
                    )),
              )
                  : model.opticalNotes.isNotEmpty
                  ? ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) => OpticalNoteCard(
                      opticalNote: model.opticalNotes[index],
                      patient: patient),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: 8),
                  itemCount: model.opticalNotes.length)
                  : Container(
                height: 100,
                child: Center(
                    child:
                    Text('No Payment Notes Record')),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Balance Payment Notes',
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Divider(
                      height: 2,
                      thickness: 2,
                      color: Palettes.kcDarkerBlueMain1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              model.paymentBalance.isNotEmpty
                  ? ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) => BalanceCard(
                      balanceNotes: model.paymentBalance[index],
                      patient: patient),
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemCount: model.paymentBalance.length)
                  : Container(
                height: 100,
                child: Center(
                    child: Text('No Balance Record')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
