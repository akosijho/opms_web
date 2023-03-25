import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_network/image_network.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';

class CustomHomePageAppBar extends StatelessWidget with PreferredSizeWidget {
  final String image;
  final String position;
  final String name;
  final VoidCallback? onLogOutTap;
  final VoidCallback onTapUser;
  final VoidCallback? onNotificationTap;
  final bool hasNotification;
  const CustomHomePageAppBar(
      {Key? key,
        required this.image,
        required this.position,
        required this.name,
        this.onNotificationTap,
        this.onLogOutTap,
        required this.onTapUser,
        required this.hasNotification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height + 20,
        color: Palettes.kcDarkerBlueMain1,
        child: Material(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 20),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 2,
                      offset: Offset(1, 2),
                    )
                  ],
                ),
                child: GestureDetector(
                  onTap: () => onTapUser(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: image.isNotEmpty
                        ? ImageNetwork(
                      image: image,
                      imageCache: CachedNetworkImageProvider(image),
                      height: 50,
                      width: 50,
                      fitWeb: BoxFitWeb.cover,
                      // filterQuality: FilterQuality.low,
                      onLoading: CircularProgressIndicator(
                          // value: progress!.expectedTotalBytes != null && progress!.expectedTotalBytes != 0
                          //     ? progress!.cumulativeBytesLoaded! / progress!.expectedTotalBytes!
                          //     : null,
                          valueColor: AlwaysStoppedAnimation(Colors.white)
                      ),

                      onError: SizedBox.shrink(),
                      onTap: () => onTapUser(),
                        // loadingBuilder: (context, url, progress) {
                        //   if (progress != null) {
                        //     return CircularProgressIndicator(
                        //         value: progress!.expectedTotalBytes != null && progress!.expectedTotalBytes != 0
                        //                     ? progress!.cumulativeBytesLoaded! / progress!.expectedTotalBytes!
                        //                     : null,
                        //       valueColor: AlwaysStoppedAnimation(Colors.white),
                        //     );
                        //   } else {
                        //     return SizedBox.shrink();
                        //   }
                        // },
                    // Image.network(
                    //   image,
                    //   // imageUrl: image,
                    //   fit: BoxFit.cover,
                    //
                    //   filterQuality: FilterQuality.low,
                    //   loadingBuilder:
                    //       (context, url, progress) =>
                    //       CircularProgressIndicator(
                    //         value: progress!.expectedTotalBytes != null && progress!.expectedTotalBytes != 0
                    //             ? progress!.cumulativeBytesLoaded! / progress!.expectedTotalBytes!
                    //             : null,
                    //         valueColor: AlwaysStoppedAnimation(Colors.white),
                    //       ),
                    )
                        : Container(),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, Welcome!',
                      style: TextStyles.tsHeading5(color: Colors.white),
                    ),
                    Visibility(
                      visible: position.isNotEmpty,
                      child: Text(
                        position != 'Staff' ? 'Doc. $name' : '$name',
                        style: TextStyles.tsBody2(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(width: 40),
              Expanded(
                child: Text(
                    "EyeChoice Optical Shop",
                  style: TextStyles.tsHeading2 (color: Colors.white),
                    )
              ),
              SizedBox(width: 40),
              IconButton(
                onPressed: () => onNotificationTap!(),
                padding: EdgeInsets.zero,
                splashColor: Colors.transparent,
                alignment: Alignment.centerRight,
                icon: SvgPicture.asset(
                  hasNotification
                      ? 'assets/icons/Notification - Noti.svg'
                      : 'assets/icons/Notification-clear.svg',
                ),
              ),
              SizedBox(width: 20),
              // IconButton(
              //   onPressed: () => onLogOutTap != null ? onLogOutTap!() : null,
              //   padding: EdgeInsets.zero,
              //   icon: SvgPicture.asset(
              //     'assets/icons/Logout.svg',
              //     color: Colors.white,
              //   ),
              // ),
              // SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(0, 75);
}
