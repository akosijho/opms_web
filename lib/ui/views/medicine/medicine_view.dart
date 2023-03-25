import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/ui/views/medicine/medicine_view_model.dart';
import 'package:opmswebstaff/ui/widgets/medicine_card/medicine_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class MedicineView extends StatefulWidget {
  const MedicineView({Key? key}) : super(key: key);

  @override
  State<MedicineView> createState() => _MedicineViewState();
}

class _MedicineViewState extends State<MedicineView> {
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
    return ViewModelBuilder<MedicineViewModel>.reactive(
      viewModelBuilder: () => MedicineViewModel(),
      onModelReady: (model) {
        model.getMedicineList();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Product List',
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
                model.navigationService.pushNamed(Routes.AddMedicineView),
            label: Text('Add Product'),
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
                            hintText: 'Search Product...',
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
                          'Product List',
                          style:
                              TextStyles.tsBody4(color: Colors.grey.shade800),
                        ),
                        SizedBox(width: 4),
                        Expanded(child: Divider()),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    color: Colors.grey.shade100,
                    child: GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: model.medicineList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        mainAxisExtent: 250,
                      ),
                      itemBuilder: (context, index) => MedicineCard(
                        id: 'id',
                        name: model.medicineList[index].medicineName,
                        brandName: model.medicineList[index].brandName,
                        price: model.medicineList[index].priceToCurrency,
                        image: model.medicineList[index].image,
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
