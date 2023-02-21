import 'package:opmsapp/ui/views/medical_history/medical_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MedicalHistoryView extends StatelessWidget {
  final dynamic patientId;
  const MedicalHistoryView({Key? key, required this.patientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MedicalHistoryViewModel>.reactive(
      viewModelBuilder: () => MedicalHistoryViewModel(),
      onModelReady: (model) => model.getPatientMedicalHistory(patientId),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Medical History'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text('Add Medical History'),
        ),
        body: Container(
          color: Colors.grey.shade50,
          child: ListView(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    // model.medHistoryList.isNotEmpty
                    //     ? GridView.builder(
                    //         shrinkWrap: true,
                    //         primary: false,
                    //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //           crossAxisCount: 2,
                    //           crossAxisSpacing: 8,
                    //           mainAxisSpacing: 8,
                    //           mainAxisExtent: 300,
                    //         ),
                    //         itemBuilder: (context, index) {
                    //           return model.isBusy
                    //               ? Center(
                    //                   child: CircularProgressIndicator(),
                    //                 )
                    //               : Column(
                    //                   mainAxisAlignment: MainAxisAlignment.start,
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     InkWell(
                    //                       onTap: () =>
                    //                           model.goToPhotoView(index: index),
                    //                       child: Container(
                    //                         decoration: BoxDecoration(
                    //                           color: Colors.grey,
                    //                           border: Border.all(
                    //                               color: Colors.grey, width: 1),
                    //                         ),
                    //                         child: CachedNetworkImage(
                    //                           imageUrl: model
                    //                               .medHistoryList[index].image!,
                    //                           fit: BoxFit.fitHeight,
                    //                           filterQuality: FilterQuality.high,
                    //                           height: 250,
                    //                           width: double.maxFinite,
                    //                           progressIndicatorBuilder:
                    //                               (context, url, progress) =>
                    //                                   LinearProgressIndicator(
                    //                             color: Palettes.kcBlueMain1,
                    //                             value: progress.progress,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     SizedBox(height: 5),
                    //                     Text(
                    //                       model.medHistoryList[index].date,
                    //                       style: TextStyles.tsHeading5(),
                    //                     )
                    //                   ],
                    //                 );
                    //         },
                    //         itemCount: model.medHistoryList.length,
                    //       )
                    //     :
                    SizedBox(
                        height: MediaQuery.of(context).size.height - 120,
                        width: MediaQuery.of(context).size.width,
                        child:
                            Center(child: Text('No Medical History Found...'))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
