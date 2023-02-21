import 'dart:ui';

import 'package:opmsapp/constants/styles/text_styles.dart';
import 'package:opmsapp/ui/views/notification/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
      viewModelBuilder: () => NotificationViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
          centerTitle: true,
        ),
        body: model.notifications.isEmpty
            ? Center(
                child: Text('No notifications'),
              )
            : ListView(
                children: [
                  Container(
                    color: Colors.grey.shade300,
                    padding: EdgeInsets.all(4),
                    child: ElevatedButton(
                        onPressed: () => model.markAllRead(),
                        child: Text('Mark all as Read')),
                  ),
                  SizedBox(height: 10),
                  ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            model.markRead(model.notifications[index].id);
                            model.openNotification(model.notifications[index]);
                          },
                          child: Container(
                            height: 120,
                            padding: EdgeInsets.all(8),
                            color: model.notifications[index].isRead
                                ? Colors.white
                                : Colors.grey.shade100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: SvgPicture.asset(
                                    model.notifications[index]
                                                .notification_type ==
                                            'appointment'
                                        ? 'assets/icons/Calendar.svg'
                                        : 'assets/icons/Wallet.svg',
                                    color: Colors.grey.shade900,
                                    height: 35,
                                    width: 35,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model.notifications[index]
                                            .notification_title,
                                        style: TextStyles.tsButton2(),
                                      ),
                                      SizedBox(height: 8),
                                      Text(model.notifications[index]
                                          .notification_msg),
                                      Spacer(),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.av_timer_rounded,
                                            size: 16,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            DateFormat.yMMMd().add_jm().format(
                                                model.notifications[index]
                                                    .date_created!),
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.grey.shade800),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: double.maxFinite,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.linear_scale_sharp,
                                      size: 20,
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                )
                              ],
                            ),
                          )),
                      separatorBuilder: (context, index) => Divider(
                            height: 1,
                            color: Colors.grey.shade900,
                            thickness: 0.5,
                          ),
                      itemCount: model.notifications.length)
                ],
              ),
      ),
    );
  }
}
