import 'package:opmswebstaff/ui/views/view_dental_notes_by_tooth/view_dental_note_by_tooth_view_model.dart';
import 'package:opmswebstaff/ui/widgets/dental_note_card/dental_note_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/patient_model/patient_model.dart';

class ViewDentalNoteByToothView extends StatelessWidget {
  final Patient patient;
  final String selectedTooth;
  const ViewDentalNoteByToothView(
      {Key? key, required this.patient, required this.selectedTooth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewDentalNoteByToothViewModel>.reactive(
      viewModelBuilder: () => ViewDentalNoteByToothViewModel(),
      onModelReady: (model) =>
          model.getDentalNoteByID(selectedTooth, patient.id),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Treatment Records of Tooth ${selectedTooth}'),
        ),
        body: Container(
          color: Color.fromARGB(117, 176, 156, 177),
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              model.isBusy
                  ? Container(
                      height: 500,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text('Loading..')
                        ],
                      )),
                    )
                  : model.dentalNotes.isNotEmpty
                      ? ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) => DentalNoteCard(
                              dentalNote: model.dentalNotes[index],
                              patient: patient),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8),
                          itemCount: model.dentalNotes.length)
                      : Container(
                          height: 500,
                          child: Center(child: Text('No Treatment Records')),
                        )
            ],
          ),
        ),
      ),
    );
  }
}
