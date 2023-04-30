import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/ui/views/service/service_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:opmswebstaff/ui/widgets/service_card/service_card.dart';
import 'package:stacked/stacked.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({Key? key}) : super(key: key);

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  final procedureScrollController = ScrollController();
  final searchProcedureTxtController = TextEditingController();

  @override
  void dispose() {
    procedureScrollController.dispose();
    searchProcedureTxtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ServiceViewModel>.reactive(
      viewModelBuilder: () => ServiceViewModel(),
      onModelReady: (model) {
        model.init();
      },
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Optical Services',
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
                  model.navigationService.pushNamed(Routes.AddServiceView),
              label: Text('Add Service'),
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
            child: Container(
              color: Colors.grey.shade200,
              child: ListView(
                controller: procedureScrollController,
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      child: Container(
                        height: 50,
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (value) =>
                                    model.searchService(value),
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
                                  hintText: 'Search Service...',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  model.isBusy
                      ? Container(
                          height: 500,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Fetching Data. Please wait...')
                              ],
                            ),
                          ),
                        )
                      : model.serviceList.isNotEmpty
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) => ServiceCard(
                                  service: model.serviceList[index],
                                  id: model.serviceList[index].id!,
                                ),
                                separatorBuilder: (context, index) => Container(
                                  height: 8,
                                ),
                                itemCount: model.serviceList.length,
                              ),
                            )
                          : Container(
                              height: 500,
                              child: Center(
                                child: Text('No Service found...'),
                              ),
                            )
                ],
              ),
            ),
          )),
    );
  }
}
