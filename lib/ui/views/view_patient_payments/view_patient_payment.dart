import 'package:opmswebstaff/ui/views/view_patient_payments/view_payment_patient_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../models/patient_model/patient_model.dart';
import '../../widgets/payment_card/payment_card.dart';

class ViewPatientPayment extends StatelessWidget {
  final Patient patient;
  const ViewPatientPayment({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewPatientPaymentViewModel>.reactive(
      viewModelBuilder: () => ViewPatientPaymentViewModel(),
      onModelReady: (model) {
        model.listenToPaymentChange(patient.id);
      },
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text("Patient's Record"),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => model.goToAddBilling(patient),
            label: Text('Add Billing/Payment')),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "List Of Patient's Records",
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
            model.patientPaymentList.isNotEmpty
                ? ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) => PaymentCard(
                  onViewReceiptTap: () => model.goToReceipt(index),
                  onViewRxTap: () => model.goToRx(index),
                  payment: model.patientPaymentList[index],
                ),
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemCount: model.patientPaymentList.length)
                : Container(
              height: 500,
              color: Colors.grey.shade100,
              child: Center(
                child: Text('No Payment record'),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
