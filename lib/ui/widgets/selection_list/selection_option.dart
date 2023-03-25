import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/ui/widgets/selection_list/selection_option_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class SelectionOption extends StatelessWidget {
  final List<String> options;
  final String? title;
  const SelectionOption({Key? key, required this.options, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectionOptionViewModel>.reactive(
        viewModelBuilder: () => SelectionOptionViewModel(),
        builder: (context, model, child) => ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 250),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Palettes.kcHintColor))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: Get.back,
                          child: Text(
                            'Cancel',
                            style: TextStyles.tsButton1(color: Colors.red[700]),
                          ),
                        ),
                        Text(
                          title ?? '',
                          style: TextStyle(fontSize: 18),
                        ),
                        TextButton(
                          onPressed: () => model.setReturnOption(options),
                          child: Text(
                            'Done',
                            style: TextStyles.tsButton1(
                                color: Palettes.kcBlueMain1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: CupertinoPicker(
                      scrollController: model.scrollController,
                      onSelectedItemChanged: (index) =>
                          model.setSelectedOption(options, index),
                      children: options
                          .map((option) => Center(
                                child: Text(
                                  option,
                                  style: TextStyles.tsBody1(),
                                ),
                              ))
                          .toList(),
                      selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                        background: Palettes.kcBlueMain1.withOpacity(0.2),
                      ),
                      diameterRatio: 15,
                      itemExtent: 50,
                    ),
                  ),
                ],
              ),
            ));
  }
}
