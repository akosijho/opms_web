import 'package:opmswebstaff/ui/views/select_medicine_view/select_medicine_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../constants/styles/text_styles.dart';
import '../../widgets/cart_medicine_card/card_medicine_card.dart';

class SelectMedicineView extends StatelessWidget {
  const SelectMedicineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectMedicineViewModel>.reactive(
        viewModelBuilder: () => SelectMedicineViewModel(),
        onModelReady: (model) {
          model.getMedicine();
        },
        builder: (context, model, widget) => Scaffold(
              appBar: AppBar(
                title: Text('Select Dental Note'),
              ),
              persistentFooterButtons: [
                Container(
                  color: Colors.white,
                  width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: () => model.returnSelectedMedicine(),
                      child: Text('Confirm')),
                )
              ],
              body: Form(
                // key: model.dentalFormKey,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: Column(
                    children: [
                      TextField(
                        // onChanged: (value) => model.searchPatient(value),
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
                              color: Palettes.kcBlueDark,
                              width: 1,
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              'assets/icons/Search.svg',
                            ),
                          ),
                          constraints: BoxConstraints(maxHeight: 43),
                          hintText: 'Search Medicine...',
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'Medicine List',
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
                              child: model.medicineList.isNotEmpty
                                  ? Scrollbar(
                                      interactive: true,
                                      thumbVisibility: true,
                                      thickness: 8,
                                      radius: Radius.circular(40),
                                      child: ListView.separated(
                                        itemBuilder: (context, index) =>
                                            CartMedicineCard(
                                          key: ObjectKey(index),
                                          notifyChange: () =>
                                              model.notifyListeners(),
                                          medicine: model.medicineList[index],
                                          isChecked: model
                                              .medicineExistInSelectedMedicines(
                                                  model
                                                      .medicineList[index].id!),
                                          selectedMedicines:
                                              model.selectedMedicines,
                                        ),
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                          color: Colors.black,
                                        ),
                                        itemCount: model.medicineList.length,
                                      ),
                                    )
                                  : Center(child: Text('No Medicine Found...')))
                    ],
                  ),
                ),
              ),
            ));
  }
}
