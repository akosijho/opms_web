import 'package:age_calculator/age_calculator.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/ui/views/payment_select_patient/payment_select_patient_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';
import '../../widgets/patient_card/patient_card.dart';

class PaymentSelectPatientView extends StatelessWidget {
  const PaymentSelectPatientView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentSelectPatientViewModel>.reactive(
        viewModelBuilder: () => PaymentSelectPatientViewModel(),
        onModelReady: (model) => model.init(),
        builder: (context, model, widget) => Scaffold(
              appBar: AppBar(
                title: Text('Select Patient For Payment'),
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade200,
                child: RefreshIndicator(
                  color: Palettes.kcBlueMain1,
                  onRefresh: () async {
                    await Future.delayed(Duration(seconds: 1));
                  },
                  child: CustomScrollView(
                    physics: AlwaysScrollableScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    slivers: [
                      SliverStickyHeader(
                        overlapsContent: false,
                        header: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          color: Palettes.kcBlueMain1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextField(
                                onChanged: (value) =>
                                    model.searchPatient(value),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide(
                                      color: Palettes.kcBlueMain1,
                                      width: 1.8,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: SvgPicture.asset(
                                      'assets/icons/Search.svg',
                                    ),
                                  ),
                                  // suffixIcon: GestureDetector(
                                  //   onTap: () {},
                                  //   child: Padding(
                                  //     padding: EdgeInsets.all(8),
                                  //     child: SvgPicture.asset(
                                  //       'assets/icons/Filter.svg',
                                  //     ),
                                  //   ),
                                  // ),
                                  constraints: BoxConstraints(maxHeight: 43),
                                  hintText: 'Search by Last Name, First Name',
                                ),
                              ),
                            ],
                          ),
                        ),
                        sliver: model.patientList.length != 0
                            ? SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    child: SlideAnimation(
                                      duration: Duration(milliseconds: 400),
                                      horizontalOffset: 100,
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(top: 8, bottom: 8),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade600,
                                              blurRadius: 1,
                                            )
                                          ],
                                        ),
                                        child: Material(
                                          color: Colors.white,
                                          child: InkWell(
                                            onTap: () => model.selectPatient(
                                                context, model.patientList[index]),
                                            child: PatientCard(
                                              key: ObjectKey(
                                                  model.patientList[index].id),
                                              name: model
                                                  .patientList[index].fullName,
                                              // image: model
                                              //     .patientList[index].image,
                                              phone: model
                                                  .patientList[index].phoneNum,
                                              address: model
                                                  .patientList[index].address,
                                              birthDate: DateFormat.yMMMd()
                                                  .format(model
                                                      .patientList[index]
                                                      .birthDate
                                                      .toDateTime()!),
                                              age: AgeCalculator.age(
                                                      model.patientList[index]
                                                          .birthDate
                                                          .toDateTime()!,
                                                      today: DateTime.now())
                                                  .years
                                                  .toString(),
                                              dateCreated: model
                                                  .patientList[index]
                                                  .dateCreated!,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }, childCount: model.patientList.length),
                              )
                            : SliverToBoxAdapter(
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: Center(
                                    child: Text('No Patients Found'),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
