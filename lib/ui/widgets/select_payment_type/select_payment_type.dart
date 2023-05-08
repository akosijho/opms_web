import 'package:opmswebstaff/ui/widgets/select_payment_type/select_payment_type_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../constants/styles/text_styles.dart';

class SelectPaymentType extends StatelessWidget {
  const SelectPaymentType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectPaymentTypeViewModel>.reactive(
        viewModelBuilder: () => SelectPaymentTypeViewModel(),
        builder: (context, model, widget) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Container(
                  height: 450.sp,
                  width: 450.sp,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Palettes.kcPurpleMain,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)),
                          ),
                          child: Text(
                            'Select Payment Method',
                            style: TextStyles.tsHeading4(color: Colors.white),
                          ),
                        ),
                        Divider(
                          color: Palettes.kcDarkerBlueMain1,
                          height: 1,
                          thickness: 1,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemBuilder: (context, index) => Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(1, 1)),
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(-1, -1)),
                                        ]),
                                    child: RadioListTile(
                                      tileColor: Colors.white,
                                      value: index,
                                      groupValue: model.val,
                                      onChanged: (value) {
                                        model.val = int.parse(value.toString());
                                        model.notifyListeners();
                                      },
                                      selected: model.val == index,
                                      title: Text(model.paymentTypes[index]),
                                      secondary: Icon(Icons.money),
                                      toggleable: true,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                              itemCount: model.paymentTypes.length),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: SizedBox(
                              // width: double.maxFinite,
                              child: ElevatedButton(
                                onPressed: () {
                                  model.returnPaymentType(
                                      model.paymentTypes[model.val]);
                                },
                                child: Text('Confirm',
                                style: TextStyle(
                                  fontSize: 16
                                ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
