import 'package:cached_network_image/cached_network_image.dart';
import 'package:opmsapp/models/medicine/medicine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_network/image_network.dart';

import '../../../constants/styles/text_styles.dart';

class PaymentMedicineCard extends StatelessWidget {
  final Medicine medicine;
  const PaymentMedicineCard({Key? key, required this.medicine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showMedImage(medicine.image),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicine.brandName ?? 'No Brand',
                    style: TextStyles.tsBody1(color: Colors.grey.shade900),
                  ),
                  Text(
                    medicine.medicineName,
                    style: TextStyles.tsBody2(color: Colors.black54),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        medicine.priceToCurrency ?? '0',
                        textAlign: TextAlign.left,
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      RichText(
                          text: TextSpan(
                              text: 'x',
                              style: TextStyles.tsBody3(
                                  color: Colors.grey.shade900),
                              children: [
                            TextSpan(
                                text: medicine.qty, style: TextStyles.tsBody1())
                          ]))
                    ],
                  ),
                ],
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
          height: 75,
          width: 87,
          child: SvgPicture.asset(
            'assets/icons/Pills.svg',
            color: Colors.purple,
            height: 50,
            width: 50,
            alignment: Alignment.center,
          ),
        ),
      );
    } else {
      return ImageNetwork(
        image: image,
        height: 92,
        width: 92,
        imageCache: CachedNetworkImageProvider(image),
      );
    }
  }
}
