import 'package:cached_network_image/cached_network_image.dart';
import 'package:opmsapp/app/app.locator.dart';
import 'package:opmsapp/constants/styles/palette_color.dart';
import 'package:opmsapp/constants/styles/text_styles.dart';
import 'package:opmsapp/core/service/url_launcher/url_launcher_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class PatientCard extends StatelessWidget {
  final String image;
  final String name;
  final String phone;
  final String address;
  final String? age;
  final String? birthDate;
  final DateTime dateCreated;
  PatientCard(
      {Key? key,
      required this.image,
      required this.name,
      required this.phone,
      required this.address,
      this.age,
      this.birthDate,
      required this.dateCreated})
      : super(key: key);

  final urlLauncherService = locator<URLLauncherService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
                border: Border.all(
                  color: Palettes.kcNeutral5,
                  width: 2,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1.5,
                      offset: Offset(0, 2)),
                ]),
            child:  ClipRRect(
              borderRadius: BorderRadius.circular(120),
              child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  filterQuality:  FilterQuality.high,
                  progressIndicatorBuilder: (context, url, progress) =>
                      CircularProgressIndicator(
                        value: progress.progress,
                        valueColor: AlwaysStoppedAnimation(
                          Colors.white,
                        ),
                      )),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 21.sp,
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyles.tsHeading4(color: Palettes.kcNeutral1),
                      ),
                      Expanded(
                        child: Visibility(
                          visible: DateFormat.yMMMd().format(dateCreated) ==
                              DateFormat.yMMMd().format(DateTime.now()),
                          child: Container(
                            height: 21.sp,
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              '(New)',
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Age: ',
                      style: TextStyles.tsHeading5(color: Palettes.kcNeutral1),
                    ),
                    Text(
                      '$age',
                      style: TextStyles.tsHeading5(color: Palettes.kcNeutral1),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/Call.svg',
                                height: 18,
                                width: 18,
                                color: Palettes.kcBlueDark,
                              ),
                              SizedBox(width: 5),
                              Text(
                                phone,
                                style: TextStyles.tsBody2(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/Location.svg',
                                height: 20,
                                width: 20,
                                color: Palettes.kcBlueDark,
                              ),
                              SizedBox(width: 5),
                              Text(
                                address,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.tsBody3(
                                  color: Colors.grey.shade700,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 1),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/Calendar.svg',
                                height: 18,
                                width: 18,
                                color: Palettes.kcBlueDark,
                              ),
                              SizedBox(width: 5),
                              Text(
                                birthDate ?? '',
                                style: TextStyles.tsBody2(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
