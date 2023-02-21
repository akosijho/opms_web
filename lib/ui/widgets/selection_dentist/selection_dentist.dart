import 'package:opmsapp/constants/font_name/font_name.dart';
import 'package:opmsapp/constants/styles/palette_color.dart';
import 'package:opmsapp/models/user_model/user_model.dart';
import 'package:opmsapp/ui/widgets/selection_dentist/selection_dentist_view_model.dart';
import 'package:opmsapp/ui/widgets/user_card/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class SelectionDentist extends StatelessWidget {
  const SelectionDentist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectionDentistViewModel>.reactive(
      viewModelBuilder: () => SelectionDentistViewModel(),
      onModelReady: (model) => model.searchDentist(''),
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
                    'Select Dentist',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: FontNames.gilRoy,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    onChanged: (value) => model.searchDentist(value),
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
                      hintText: 'Search Dentist...',
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('List of Dentist'),
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
            child: setDentistSelectionBody(
              isBusy: model.isBusy,
              dentistList: model.isBusy ? null : model.dentistList,
              onTap: (user) => model.setReturnDentist(user),
            ),
          ),
        ),
      ),
    );
  }

  Widget setDentistSelectionBody({
    required bool isBusy,
    required List<UserModel>? dentistList,
    required Function(UserModel user) onTap,
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
      if (dentistList!.length <= 0) {
        return Center(
          child: Text('No Dentist Found...'),
        );
      } else {
        return ListView.separated(
          shrinkWrap: true,
          primary: false,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => UserCard(
            user: dentistList[index],
            onTap: () => onTap(dentistList[index]),
          ),

          separatorBuilder: (context, index) => SizedBox(
            height: 4,
          ),
          itemCount: dentistList.length,
          // padding: EdgeInsets.only(bottom: 20, top: 5),
        );
      }
    }
  }
}
