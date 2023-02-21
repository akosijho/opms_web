import 'package:opmsapp/constants/font_name/font_name.dart';
import 'package:opmsapp/constants/styles/palette_color.dart';
import 'package:opmsapp/constants/styles/text_styles.dart';
import 'package:opmsapp/ui/views/selection_tooth_condition/selection_tooth_condition_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class SelectionToothCondition extends StatelessWidget {
  const SelectionToothCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectionToothConditionViewModel>.nonReactive(
      viewModelBuilder: () => SelectionToothConditionViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Palettes.kcDarkerBlueMain1),
          title: Text('Select Tooth Condition'),
          backgroundColor: Palettes.kcDarkerBlueMain1,
          foregroundColor: Colors.white,
        ),
        body: Container(
          color: Palettes.kcDarkerBlueMain1,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'List of Tooth Condition',
                      style: TextStyles.tsBody2(color: Colors.white),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                        child: Divider(
                      height: 2,
                      thickness: 1,
                      color: Colors.white,
                    ))
                  ],
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                child: Scrollbar(
                  thickness: 7,
                  hoverThickness: 2,
                  showTrackOnHover: true,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                    ),
                    padding: EdgeInsets.only(top: 20, left: 2, right: 2),
                    child: ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => model.returnSelectedToothCondition(
                            model.toothConditionList[index]),
                        child: Card(
                          elevation: 1,
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                model.toothConditionList[index],
                                style: TextStyle(
                                    fontSize: 17, fontFamily: FontNames.sfPro),
                              ),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 2,
                      ),
                      itemCount: model.toothConditionList.length,
                      // padding: EdgeInsets.only(bottom: 20, top: 5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
