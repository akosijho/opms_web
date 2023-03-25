import 'package:image_network/image_network.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/models/user_model/user_model.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final VoidCallback? onTap;
  final UserModel user;
  const UserCard({Key? key, this.onTap, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onTap != null ? onTap!() : null,
        child: SizedBox(
          height: 130,
          child: Card(
            elevation: 2,
            margin: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 130,
                  width: 130,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                    ),
                    child: ImageNetwork(
                      image: user.image,
                      height: 130,
                      width: 130,
                      // filterQuality: FilterQuality.high,
                      fitWeb: BoxFitWeb.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                user.fullName,
                                style: TextStyles.tsHeading4(),
                              ),
                            ),
                            SizedBox(width: 2),
                            user.active_status == 'active'
                                ? Container(
                                    // width: 53.sp,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          size: 13,
                                          color: Colors.green,
                                        ),
                                        SizedBox(width: 1),
                                        Text('Active'),
                                      ],
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 13,
                                        color: Colors.grey.shade800,
                                      ),
                                      SizedBox(width: 1),
                                      Text('On Leave'),
                                    ],
                                  ),
                            SizedBox(width: 4),
                          ],
                        ),
                        Text(
                          user.position,
                          style: TextStyle(
                              fontSize: kfsBody3,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
