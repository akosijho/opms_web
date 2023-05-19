import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/ui/views/product/lens/lens_view_model.dart';
import 'package:opmswebstaff/ui/widgets/product_card/lens_card.dart';
import 'package:stacked/stacked.dart';

class LensView extends StatefulWidget {
  const LensView({Key? key}) : super(key: key);

  @override
  State<LensView> createState() => _LensViewState();
}

class _LensViewState extends State<LensView> {
  final medicineScrollController = ScrollController();
  final searchMedicineTxtController = TextEditingController();

  @override
  void dispose() {
    medicineScrollController.dispose();
    searchMedicineTxtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LensViewModel>.reactive(
      viewModelBuilder: () => LensViewModel(),
      onModelReady: (model) {
        model.getLensList();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Lens List',
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
                // model.navigationService.pushNamed(Routes.AddLensView),
            model.goToAddLens(context),
            label: Text('Add Lens'),
            icon: Icon(Icons.add),
          ),
        ),
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              model.setFabSize(isScrolledUp: true);
            } else if (notification.direction == ScrollDirection.reverse) {
              model.setFabSize(isScrolledUp: false);
            }
            return true;
          },
          child: ListView(
            controller: medicineScrollController,
            padding: EdgeInsets.symmetric(vertical: 15),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Container(
                  height: 50,
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
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
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Lens List',
                          style:
                          TextStyles.tsBody4(color: Colors.grey.shade800),
                        ),
                        SizedBox(width: 4),
                        Expanded(child: Divider()),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                    color: Colors.grey.shade100,
                    child: GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: model.lensList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        mainAxisExtent: 250,
                      ),
                      itemBuilder: (context, index) => LensCard(
                        id: 'id',
                        name: model.lensList[index].lensName,
                        brandName: model.lensList[index].brandName,
                        price: model.lensList[index].priceToCurrency,
                        image: model.lensList[index].image,
                        lens: model.lensList[index],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}