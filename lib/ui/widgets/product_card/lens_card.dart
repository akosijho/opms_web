import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmswebstaff/core/service/toast/toast_service.dart';
import 'package:opmswebstaff/models/product/lens.dart';
import 'package:opmswebstaff/ui/views/update_product/update_lens/update_lens.dart';

class LensCard extends StatefulWidget {
  final Lens lens;
  final String id;
  final String name;
  final String? price;
  final String? image;
  final String? brandName;
  const LensCard(
      {Key? key,
        required this.lens,
        required this.id,
        required this.name,
        this.brandName,
        this.price,
        this.image})
      : super(key: key);

  @override
  State<LensCard> createState() => _LensCardState();
}

class _LensCardState extends State<LensCard> {
  // final connectivityService = locator<ConnectivityService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();
  final toastService = locator<ToastService>();
  final bottomSheetService = locator<BottomSheetService>();

  Future<void> deleteLens(String lensId) async {
    // if (await connectivityService.checkConnectivity()) {
    dialogService.showConfirmDialog(
      title: 'Delete Lens',
      middleText: 'This action will delete the selected lens permanently. Continue this action?',
      onCancel: () => navigationService.pop(),
      onContinue: () async {
        await apiService.deleteLens(lensId: lensId);
        navigationService.pop();
        toastService.showToast(message: 'Lens deleted');
      },
    );
    // } else {
    //   toastService.showToast(message: 'Network Error. Please Try Again Later.');
    // }
  }

  void setActionValue(String? selectedValue) async {

    switch(selectedValue) {
      case 'Delete':
        this.deleteLens(widget.lens.id!);
        break;
      case 'Edit':
        this.updateLens(widget.lens);
        break;
      default:
        toastService.showToast(message: 'Something went wrong');
        break;
    }
  }
  // void updateLens(Lens lens) {
  //   navigationService.pushNamed(Routes.UpdateLensViews,
  //       arguments: UpdateLensViewArguments(lens: lens));
  // }
  void updateLens(Lens lens) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
              width: 500, // Specify the desired container width
              height: 500, // Specify the desired container height
              child: UpdateLensView(lens: lens)
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
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
            height: 130,
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
            'assets/icons/contact_lens.svg',
            color: Colors.black,
            // fit: BoxFit.contain,
          ),
        ),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        progressIndicatorBuilder: (context, url, progress) =>
            LinearProgressIndicator(
              color: Colors.grey.shade100,
              value: progress.progress,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
      );
    }
  }
}
