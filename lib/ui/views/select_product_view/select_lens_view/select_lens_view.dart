import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/ui/views/select_product_view/select_lens_view/select_lens_view_model.dart';
import 'package:opmswebstaff/ui/widgets/cart_product_card/card_lens_card.dart';
import 'package:stacked/stacked.dart';


class SelectLensView extends StatelessWidget {
  const SelectLensView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectLensViewModel>.reactive(
        viewModelBuilder: () => SelectLensViewModel(),
        onModelReady: (model) {
          model.getLens();
        },
        builder: (context, model, widget) => Scaffold(
          appBar: AppBar(
            title: Text('Select Lens',
            style: TextStyle(
              fontSize: 16
            ),
            ),
          ),
          persistentFooterButtons: [
            Container(
              color: Colors.white,
              // width: double.maxFinite,
              child: ElevatedButton(
                  onPressed: () => model.returnSelectedLens(),
                  child: Text('Confirm',
                  style: TextStyle(
                    fontSize: 16
                  ),
                  )),
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
                      hintText: 'Search Lens...',
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Lens List',
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
                      child: model.lensList.isNotEmpty
                          ? Scrollbar(
                        interactive: true,
                        thumbVisibility: true,
                        thickness: 8,
                        radius: Radius.circular(40),
                        child: ListView.separated(
                          itemBuilder: (context, index) =>
                              CartLensCard(
                                key: ObjectKey(index),
                                notifyChange: () =>
                                    model.notifyListeners(),
                                lens: model.lensList[index],
                                isChecked: model
                                    .lensExistInSelectedLens(
                                    model
                                        .lensList[index].id!),
                                selectedLens:
                                model.selectedLens,
                              ),
                          separatorBuilder: (context, index) =>
                              Divider(
                                color: Colors.black,
                              ),
                          itemCount: model.lensList.length,
                        ),
                      )
                          : Center(child: Text('No Lens Found...')))
                ],
              ),
            ),
          ),
        ));
  }
}
