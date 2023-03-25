import 'package:opmswebstaff/ui/views/prescription_view/prescription_view_model.dart';
import 'package:opmswebstaff/ui/widgets/prescription_card/prescription_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../models/patient_model/patient_model.dart';

class PrescriptionView extends StatelessWidget {
  final Patient patient;
  const PrescriptionView({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PrescriptionViewModel>.reactive(
      viewModelBuilder: () => PrescriptionViewModel(),
      onModelReady: (model) => model.listenToPrescriptionSub(patient.id),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text("Patient's Prescription"),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => model.goToAddPrescription(patient),
            label: Text('Add Prescription')),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'List Of Patient Prescriptions',
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
                )
              ],
            ),
            SizedBox(height: 10),
            model.prescriptionList.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, i) => PrescriptionCard(
                          prescription: model.prescriptionList[i],
                          onViewPrescriptionTap: () =>
                              model.saveAndOpenPrescriptionDoc(
                                  prescription: model.prescriptionList[i],
                                  patient: patient),
                        ),
                    separatorBuilder: (context, index) => SizedBox(height: 6),
                    itemCount: model.prescriptionList.length)
                : Container(
                    height: 500,
                    child: Center(
                        child: Text('No Appointments added on this patient ')),
                  ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
