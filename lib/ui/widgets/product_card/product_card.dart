import 'package:image_network/image_network.dart';
import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmswebstaff/core/service/toast/toast_service.dart';
import 'package:opmswebstaff/models/product/product.dart';
import 'package:opmswebstaff/ui/views/update_product/update_product_view.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final String id;
  final String name;
  final String? price;
  final String? image;
  final String? brandName;
  const ProductCard(
      {Key? key,
        required this.product,
      required this.id,
      required this.name,
      this.brandName,
      this.price,
      this.image})
      : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // final connectivityService = locator<ConnectivityService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();
  final toastService = locator<ToastService>();
  final bottomSheetService = locator<BottomSheetService>();

  // late String _value;

  // Future<void> deleteProduct(String medicineId) async {
  //   dialogService.showConfirmDialog(
  //       title: 'Delete  Product',
  //       middleText:
  //       'This action will delete the selected service permanently. Continue this action?',
  //       onCancel: () => navigationService.pop(),
  //       onContinue: () async {
  //         if (await connectivityService.checkConnectivity()) {
  //           await apiService.deleteMedicine(medicineId: medicineId);
  //           navigationService.pop();
  //           toastService.showToast(message: 'Product deleted');
  //         } else {
  //           toastService.showToast(
  //               message: 'Network Error. Please Try Again Later.');
  //         }
  //       });
  // }
  Future<void> deleteProduct(String medicineId) async {
    // if (await connectivityService.checkConnectivity()) {
      dialogService.showConfirmDialog(
        title: 'Delete Product',
        middleText: 'This action will delete the selected product permanently. Continue this action?',
        onCancel: () => navigationService.pop(),
        onContinue: () async {
          await apiService.deleteProduct(medicineId: medicineId);
          navigationService.pop();
          toastService.showToast(message: 'Product deleted');
        },
      );
    // } else {
    //   toastService.showToast(message: 'Network Error. Please Try Again Later.');
    // }
  }

  // Future<void> setActionValue() async {
  //   final selectedAction =
  //   await bottomSheetService.openBottomSheet(SelectionOption(
  //     options: SetupUserViewModel().editDeleteOptions,
  //     title: 'Select action',
  //   ));
  //   // if (selectedGender != null) {
  //   //   genderController.text = selectedGender;
  //   // }
  //   if (widget.product.id == 'delete') {
  //     this.deleteProduct(widget.product.id!);
  //   } else if (widget.product.id == 'edit'){
  //   this.deleteProduct(widget.product.id!);
  //   }else {
  //     toastService.showToast(message: 'Something went wrong');
  //   }
  // }
  void setActionValue(String? selectedValue) async {
    // if (widget.product.id == 'delete') {
    //   this.deleteProduct(widget.product.id!);
    // } else if (widget.product.id == 'edit'){
    //   // this.deleteProduct(widget.product.id!);
    //   toastService.showToast(message: 'Edit action selected');
    // }else {
    //   toastService.showToast(message: 'Something went wrong');
    // }
    switch(selectedValue) {
      case 'Delete':
        this.deleteProduct(widget.product.id!);
        // await FirebaseFirestore.instance
        //     .collection('medicines')
        //     .doc(widget.product.id!)
        //     .delete();
        break;
      case 'Edit':
        this.updateProduct(widget.product);
        break;
      default:
        toastService.showToast(message: 'Something went wrong');
        break;
    }
  }
  // void updateProduct(Product product) {
  //   navigationService.pushNamed(Routes.UpdateProductViews,
  //       arguments: UpdateProductViewArguments(medicine: product));
  // }

  void updateProduct(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
              width: 500, // Specify the desired container width
              height: 500, // Specify the desired container height
              child: UpdateProductView(medicine: product)
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      key: ObjectKey(widget.id),
      color: Colors.white,
      padding: EdgeInsets.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              // child: InkWell(
              //   onTap: () => setActionValue(),
              //   child: Icon(
              //       Icons.more_vert
              //   ),
              // ),
              child: DropdownButton(
                items: const [
                  DropdownMenuItem(child: Text("Edit"), value: "Edit",),
                  DropdownMenuItem(child: Text("Delete"), value: "Delete",)
                ],
                icon: Icon(Icons.more_vert),
                // value: _value,

                underline: Container(
                  height: 0,
                  color: Colors.transparent,
                ),
                onChanged: setActionValue

              ),
            ),
          ),
          SizedBox(
            height: 140,
            width: double.maxFinite,
            child: showMedImage(widget.image),
          ),
          Divider(height: 1),
          SizedBox(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: FittedBox(
              child: Text(
                widget.brandName ?? 'No Brand',
                style: TextStyles.tsHeading4(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                widget.name,
                style: TextStyles.tsBody2(color: Colors.grey.shade700),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                '${widget.price ?? 'Not Set'}',
                style: TextStyles.tsBody2(color: Colors.deepOrange),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showMedImage(String? image) {
    if (image == null || image == '') {
      return Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: 150,
          width: 150,
          child: SvgPicture.asset(
            'assets/icons/eyeglass.svg',
            color: Colors.black,

          ),
        ),
      );
    } else {
      return ImageNetwork(
        image: image,
        fitWeb: BoxFitWeb.cover,
        onLoading: LinearProgressIndicator(
            color: Colors.grey.shade100,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)
        ),
        height: 50,
        width: 50,
        // filterQuality: FilterQuality.high,
        // progressIndicatorBuilder: (context, url, progress) =>
        //     LinearProgressIndicator(
        //   color: Colors.grey.shade100,
        //   value: progress.progress,
        //   valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
        // ),
      );
    }
  }
}
