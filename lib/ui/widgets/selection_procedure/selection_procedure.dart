import 'package:opmswebstaff/constants/font_name/font_name.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/main.dart';
import 'package:opmswebstaff/models/procedure/procedure.dart';
import 'package:opmswebstaff/ui/widgets/procedure_card/procedure_card.dart';
import 'package:opmswebstaff/ui/widgets/selection_procedure/selection_procedure_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class SelectionProcedure extends StatelessWidget {
  const SelectionProcedure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectionProcedureViewModel>.reactive(
      viewModelBuilder: () => SelectionProcedureViewModel(),
      onModelReady: (model) => model.getListOfProcedure(),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.maxFinite, 155),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Select Procedure',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: FontNames.gilRoy,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    onChanged: (value) => model.searchProcedure(value),
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
                          color: Palettes.kcNeutral1,
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
                      hintText: 'Search Procedure...',
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('List of Procedures'),
                      Expanded(child: Divider())
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: Scrollbar(
            thickness: 7,
            hoverThickness: 2,
            showTrackOnHover: true,
            child: setProcedureSelectionBody(
                isBusy: model.isBusy,
                procedureList: model.isBusy ? null : model.procedureList),
          ),
        ),
      ),
    );
  }

  Widget setProcedureSelectionBody({
    required bool isBusy,
    required List<Procedure>? procedureList,
  }) {
    if (isBusy) {
      return Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Column(
            children: [
              SizedBox(
                height: 35,
                width: 35,
                child: CircularProgressIndicator(),
              ),
              SizedBox(height: 4),
              Text('Loading..')
            ],
          ),
        ),
      );
    } else {
      if (procedureList!.length <= 0) {
        return Center(
          child: Text('No Procedures Found...'),
        );
      } else {
        return Container(
          padding: EdgeInsets.only(top: 10),
          color: Colors.grey.shade200,
          child: ListView.separated(
            itemBuilder: (context, index) => ProcedureCard(
              onTap: () => navigationService.pop(
                returnValue: Procedure(
                    id: procedureList[index].id,
                    procedureName: procedureList[index].procedureName,
                    price: procedureList[index].price,
                    searchIndex: []),
              ),
              id: procedureList[index].id ?? '',
              procedure: procedureList[index],
            ),
            separatorBuilder: (context, index) => Container(
              height: 10,
            ),
            itemCount: procedureList.length,
            padding: EdgeInsets.only(bottom: 20, top: 5),
          ),
        );
      }
    }
  }
}
