import 'package:opmswebstaff/constants/font_name/font_name.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:opmswebstaff/models/service/service.dart';
import 'package:opmswebstaff/ui/widgets/selection_service/selection_service_view_model.dart';
import 'package:opmswebstaff/ui/widgets/service_card/service_card.dart';
import 'package:stacked/stacked.dart';

class SelectionService extends StatelessWidget {
  const SelectionService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectionServiceViewModel>.reactive(
      viewModelBuilder: () => SelectionServiceViewModel(),
      onModelReady: (model) => model.getListOfService(),
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
                    'Select Service',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: FontNames.gilRoy,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    onChanged: (value) => model.searchService(value),
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
                      hintText: 'Search Service...',
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('List of Services'),
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
                serviceList: model.isBusy ? null : model.serviceList),
          ),
        ),
      ),
    );
  }

  Widget setProcedureSelectionBody({
    required bool isBusy,
    required List<Service>? serviceList,
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
      if (serviceList!.length <= 0) {
        return Center(
          child: Text('No Services Found...'),
        );
      } else {
        return Container(
          padding: EdgeInsets.only(top: 10),
          color: Colors.grey.shade200,
          child: ListView.separated(
            itemBuilder: (context, index) => ServiceCard(
              onTap: () => navigationService.pop(
                returnValue: Service(
                    id: serviceList[index].id,
                    serviceName: serviceList[index].serviceName,
                    price: serviceList[index].price,
                    searchIndex: []),
              ),
              id: serviceList[index].id ?? '',
              service: serviceList[index],
            ),
            separatorBuilder: (context, index) => Container(
              height: 10,
            ),
            itemCount: serviceList.length,
            padding: EdgeInsets.only(bottom: 20, top: 5),
          ),
        );
      }
    }
  }
}
