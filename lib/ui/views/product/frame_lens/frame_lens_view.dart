// import 'package:opmsapp/app/app.router.dart';
// import 'package:opmsapp/constants/styles/palette_color.dart';
// import 'package:opmsapp/constants/styles/text_styles.dart';
// import 'package:opmsapp/ui/views/product/frame/frame_view_model.dart';
// import 'package:opmsapp/ui/views/product/product_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:opmsapp/ui/widgets/product_card/product_card.dart';
// import 'package:stacked/stacked.dart';
//
// class FrameView extends StatefulWidget {
//   const FrameView({Key? key}) : super(key: key);
//
//   @override
//   State<FrameView> createState() => _FrameViewState();
// }
//
// class _FrameViewState extends State<FrameView> {
//   final medicineScrollController = ScrollController();
//   final searchMedicineTxtController = TextEditingController();
//
//   @override
//   void dispose() {
//     medicineScrollController.dispose();
//     searchMedicineTxtController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<FrameViewModel>.reactive(
//       viewModelBuilder: () => FrameViewModel(),
//       onModelReady: (model) {
//         model.getProductList();
//       },
//       builder: (context, model, child) => Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text(
//             'Product List',
//             style: TextStyles.tsHeading3(color: Colors.white),
//           ),
//         ),
//         floatingActionButton: AnimatedContainer(
//           duration: Duration(milliseconds: 300),
//           height: !model.isScrolledUp ? 56 : 48,
//           child: FloatingActionButton.extended(
//             heroTag: null,
//             isExtended: model.isScrolledUp,
//             onPressed: () =>
//                 model.navigationService.pushNamed(Routes.AddProductView),
//             label: Text('Add Frame'),
//             icon: Icon(Icons.add),
//           ),
//         ),
//         body: NotificationListener<UserScrollNotification>(
//           onNotification: (notification) {
//             if (notification.direction == ScrollDirection.forward) {
//               model.setFabSize(isScrolledUp: true);
//             } else if (notification.direction == ScrollDirection.reverse) {
//               model.setFabSize(isScrolledUp: false);
//             }
//             return true;
//           },
//           child: ListView(
//             controller: medicineScrollController,
//             padding: EdgeInsets.symmetric(vertical: 15),
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 15,
//                 ),
//                 child: Container(
//                   height: 50,
//                   width: double.maxFinite,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           // onChanged: (value) => model.searchPatient(value),
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                             contentPadding: EdgeInsets.symmetric(
//                               horizontal: 20,
//                               vertical: 5,
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(100),
//                               borderSide: BorderSide(
//                                 color: Palettes.kcBlueMain1,
//                                 width: 1.8,
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(100),
//                               borderSide: BorderSide(
//                                 color: Palettes.kcBlueDark,
//                                 width: 1,
//                               ),
//                             ),
//                             prefixIcon: Padding(
//                               padding: EdgeInsets.all(8),
//                               child: SvgPicture.asset(
//                                 'assets/icons/Search.svg',
//                               ),
//                             ),
//                             constraints: BoxConstraints(maxHeight: 43),
//                             hintText: 'Search Product...',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 15,
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           'Product List',
//                           style:
//                           TextStyles.tsBody4(color: Colors.grey.shade800),
//                         ),
//                         SizedBox(width: 4),
//                         Expanded(child: Divider()),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
//                     color: Colors.grey.shade100,
//                     child: GridView.builder(
//                       shrinkWrap: true,
//                       primary: false,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: model.productList.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 5,
//                         mainAxisSpacing: 5,
//                         mainAxisExtent: 250,
//                       ),
//                       itemBuilder: (context, index) => ProductCard(
//                         id: 'id',
//                         name: model.productList[index].productName,
//                         brandName: model.productList[index].brandName,
//                         price: model.productList[index].priceToCurrency,
//                         image: model.productList[index].image,
//                         product: model.productList[index],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:opmsapp/app/app.router.dart';
// import 'package:opmsapp/constants/styles/palette_color.dart';
// import 'package:opmsapp/constants/styles/text_styles.dart';
// import 'package:opmsapp/ui/views/product/product_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:opmsapp/ui/widgets/product_card/product_card.dart';
// import 'package:stacked/stacked.dart';
//
// class ProductView extends StatefulWidget {
//   const ProductView({Key? key}) : super(key: key);
//
//   @override
//   State<ProductView> createState() => _ProductViewState();
// }
//
// class _ProductViewState extends State<ProductView> {
//   final medicineScrollController = ScrollController();
//   final searchMedicineTxtController = TextEditingController();
//
//   @override
//   void dispose() {
//     medicineScrollController.dispose();
//     searchMedicineTxtController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<ProductViewModel>.reactive(
//       viewModelBuilder: () => ProductViewModel(),
//       onModelReady: (model) {
//         model.getProductList();
//       },
//       builder: (context, model, child) => Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text(
//             'Product List',
//             style: TextStyles.tsHeading3(color: Colors.white),
//           ),
//         ),
//         floatingActionButton: AnimatedContainer(
//           duration: Duration(milliseconds: 300),
//           height: !model.isScrolledUp ? 56 : 48,
//           child: FloatingActionButton.extended(
//             heroTag: null,
//             isExtended: model.isScrolledUp,
//             onPressed: () =>
//                 model.navigationService.pushNamed(Routes.AddProductView),
//             label: Text('Add Product'),
//             icon: Icon(Icons.add),
//           ),
//         ),
//         body: NotificationListener<UserScrollNotification>(
//           onNotification: (notification) {
//             if (notification.direction == ScrollDirection.forward) {
//               model.setFabSize(isScrolledUp: true);
//             } else if (notification.direction == ScrollDirection.reverse) {
//               model.setFabSize(isScrolledUp: false);
//             }
//             return true;
//           },
//           child: ListView(
//             controller: medicineScrollController,
//             padding: EdgeInsets.symmetric(vertical: 15),
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 15,
//                 ),
//                 child: Container(
//                   height: 50,
//                   width: double.maxFinite,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           // onChanged: (value) => model.searchPatient(value),
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                             contentPadding: EdgeInsets.symmetric(
//                               horizontal: 20,
//                               vertical: 5,
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(100),
//                               borderSide: BorderSide(
//                                 color: Palettes.kcBlueMain1,
//                                 width: 1.8,
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(100),
//                               borderSide: BorderSide(
//                                 color: Palettes.kcBlueDark,
//                                 width: 1,
//                               ),
//                             ),
//                             prefixIcon: Padding(
//                               padding: EdgeInsets.all(8),
//                               child: SvgPicture.asset(
//                                 'assets/icons/Search.svg',
//                               ),
//                             ),
//                             constraints: BoxConstraints(maxHeight: 43),
//                             hintText: 'Search Product...',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 15,
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           'Product List',
//                           style:
//                               TextStyles.tsBody4(color: Colors.grey.shade800),
//                         ),
//                         SizedBox(width: 4),
//                         Expanded(child: Divider()),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
//                     color: Colors.grey.shade100,
//                     child: GridView.builder(
//                       shrinkWrap: true,
//                       primary: false,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: model.productList.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 5,
//                         mainAxisSpacing: 5,
//                         mainAxisExtent: 250,
//                       ),
//                       itemBuilder: (context, index) => ProductCard(
//                         id: 'id',
//                         name: model.productList[index].productName,
//                         brandName: model.productList[index].brandName,
//                         price: model.productList[index].priceToCurrency,
//                         image: model.productList[index].image,
//                         product: model.productList[index],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:opmswebstaff/ui/views/product/frame_lens/frame_lens_view_model.dart';
import 'package:opmswebstaff/ui/views/product/lens/lens_view.dart';
import 'package:opmswebstaff/ui/views/product/product_view.dart';
import 'package:stacked/stacked.dart';

class FrameLensView extends StatelessWidget {
  const FrameLensView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FrameLensViewModel>.reactive(
      viewModelBuilder: () => FrameLensViewModel(),
      builder: (context, model, widget) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: model.currentIndex,
          onTap: (index) => model.changeIndex(index),
          iconSize: 28,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Frames',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_rounded), label: 'Lens'),
          ],
        ),
        body: IndexedStack(
          index: model.currentIndex,
          children: [
            ProductView(),
            LensView()
          ],
        ),
      ),
    );
  }
}
