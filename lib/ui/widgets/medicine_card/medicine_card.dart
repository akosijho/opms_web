import 'package:image_network/image_network.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedicineCard extends StatelessWidget {
  final String id;
  final String name;
  final String? price;
  final String? image;
  final String? brandName;
  const MedicineCard(
      {Key? key,
      required this.id,
      required this.name,
      this.brandName,
      this.price,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180,
            width: double.maxFinite,
            child: showMedImage(image),
          ),
          Divider(height: 1),
          SizedBox(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: FittedBox(
              child: Text(
                brandName ?? 'No Brand',
                style: TextStyles.tsHeading4(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                name,
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
                '${price ?? 'Not Set'}',
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
          height: 50,
          width: 50,
          child: SvgPicture.asset(
            'assets/icons/eyeglass.svg',
            color: Colors.purple,
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
