import 'package:age_calculator/age_calculator.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/ui/views/patients/patients_view_model.dart';
import 'package:opmswebstaff/ui/widgets/patient_card/patient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class PatientsView extends StatelessWidget {
  const PatientsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PatientsViewModel>.reactive(
      onModelReady: (model) => model.getPatientList(),
      viewModelBuilder: () => PatientsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Optical Patients',
            style: TextStyles.tsHeading3(color: Colors.white),
          ),
        ),
        floatingActionButton: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: !model.isScrolledUp ? 56 : 48,
          child: FloatingActionButton.extended(
            heroTag: null,
            isExtended: model.isScrolledUp,
            onPressed: () =>
                model.navigationService.pushNamed(Routes.AddPatientView),
            label: Text('Add Patient'),
            icon: Icon(Icons.add),
          ),
        ),
        body: RefreshIndicator(
          color: Palettes.kcBlueMain1,
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1));
          },
          child: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.forward) {
                model.setFabSize(isScrolledUp: true);
              } else if (notification.direction == ScrollDirection.reverse) {
                model.setFabSize(isScrolledUp: false);
              }
              return true;
            },
            child: CustomScrollView(
              controller: model.scrollController,
              physics: AlwaysScrollableScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverStickyHeader(
                  controller: model.stickController,
                  overlapsContent: false,
                  header: Container(
                    padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                    color: Palettes.kcBlueMain1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextField(
                          onChanged: (value) => model.searchPatient(value),
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
                            suffixIcon: GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: SvgPicture.asset(
                                  'assets/icons/Filter.svg',
                                ),
                              ),
                            ),
                            constraints: BoxConstraints(maxHeight: 43),
                            hintText: 'Search by Last Name, First Name',
                          ),
                        ),
                      ],
                    ),
                  ),
                  sliver: model.patientList.length != 0
                      ? SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              child: SlideAnimation(
                                duration: Duration(milliseconds: 400),
                                horizontalOffset: 100,
                                child: Container(
                                  margin: EdgeInsets.only(top: 8, bottom: 8),
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
                                      onTap: () =>
                                          model.goToPatientInfoView(index),
                                      child: PatientCard(
                                        key: ObjectKey(
                                            model.patientList[index].id),
                                        name: model.patientList[index].fullName,
                                        // image: model.patientList[index].image,
                                        phone:
                                            model.patientList[index].phoneNum,
                                        address:
                                            model.patientList[index].address,
                                        birthDate: DateFormat.yMMMd().format(
                                            model.patientList[index].birthDate
                                                .toDateTime()!),
                                        age: AgeCalculator.age(
                                                model.patientList[index]
                                                    .birthDate
                                                    .toDateTime()!,
                                                today: DateTime.now())
                                            .years
                                            .toString(),
                                        dateCreated: model
                                            .patientList[index].dateCreated!,
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
                            height: MediaQuery.of(context).size.height / 2,
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
      ),
    );
  }
}
