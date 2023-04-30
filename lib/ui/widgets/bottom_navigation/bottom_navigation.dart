import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:opmswebstaff/ui/views/user_view/user_view_model.dart';
import 'package:stacked/stacked.dart';

class CustomBottomNavigation extends StatelessWidget {
  final selectedIndex;
  final Function(int index) setSelectedIndex;

  CustomBottomNavigation(
      {Key? key, required this.selectedIndex, required this.setSelectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserViewModel>.reactive(
        viewModelBuilder: () => UserViewModel(),
        // onModelReady: (model) => model.init(widget.user),
        builder: (context, model, widget) => Drawer(
          width: 200,
              child: Material(
                color: Palettes.kcDarkerBlueMain1,
                child: ListView(
                  children: [
                    ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/homee.svg',
                          height: 23,
                          color: selectedIndex == 0
                              ? Palettes.kcNeutral5
                              : Palettes.kcNeutral4,
                        ),
                        title: Text(
                          'Home',
                          style: TextStyle(color: Colors.white),
                        ),
                        // shape: Border(
                        //   bottom: BorderSide(color: Colors.grey),
                        //   top: BorderSide(color: Colors.grey),
                        // ),
                        onTap: () => setSelectedIndex(0),
                        selected: selectedIndex == 0
                        // onTap: () => model.goToHome()

                        ),
                    ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/appointment.svg',
                          height: 23,
                          color: selectedIndex == 1
                              ? Palettes.kcNeutral5
                              : Palettes.kcNeutral4,
                        ),
                        title: Text(
                          'Appointment',
                          style: TextStyle(color: Colors.white),
                        ),
                        // shape: Border(
                        //   bottom: BorderSide(color: Colors.grey),
                        //   // top: BorderSide(color: Colors.grey),
                        // ),
                        onTap: () => setSelectedIndex(1),
                        selected: selectedIndex == 1),

                    ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/patients.svg',
                          height: 23,
                          color: selectedIndex == 2
                              ? Palettes.kcNeutral5
                              : Palettes.kcNeutral4,
                        ),
                        title: Text(
                          'Patients',
                          style: TextStyle(color: Colors.white),
                        ),
                        // shape: Border(
                        //   bottom: BorderSide(color: Colors.grey),
                        //   // top: BorderSide(color: Colors.grey),
                        // ),
                        onTap: () => setSelectedIndex(2),
                        selected: selectedIndex == 2),
                    ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/Filter.svg',
                          height: 23,
                          color: selectedIndex == 3
                              ? Palettes.kcNeutral5
                              : Palettes.kcNeutral4,
                        ),
                        title: Text(
                          'Services',
                          style: TextStyle(color: Colors.white),
                        ),
                        // shape: Border(
                        //   bottom: BorderSide(color: Colors.grey),
                        //   // top: BorderSide(color: Colors.grey),
                        // ),
                        onTap: () => setSelectedIndex(3),
                        selected: selectedIndex == 3),
                    ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/Work.svg',
                          height: 23,
                          color: selectedIndex == 4
                              ? Palettes.kcNeutral5
                              : Palettes.kcNeutral4,
                        ),
                        title: Text(
                          'Products',
                          style: TextStyle(color: Colors.white),
                        ),
                        // shape: Border(
                        //   bottom: BorderSide(color: Colors.grey),
                        //   // top: BorderSide(color: Colors.grey),
                        // ),
                        onTap: () => setSelectedIndex(4),
                        selected: selectedIndex == 4),

                    ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/Wallet.svg',
                          height: 23,
                          color: selectedIndex == 5
                              ? Palettes.kcNeutral5
                              : Palettes.kcNeutral4,
                        ),
                        title: Text(
                          'Payments',
                          style: TextStyle(color: Colors.white),
                        ),
                        // shape: Border(
                        //   bottom: BorderSide(color: Colors.grey),
                        //   // top: BorderSide(color: Colors.grey),
                        // ),
                        onTap: () => setSelectedIndex(5),
                        selected: selectedIndex == 5),

                    ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/Ticket.svg',
                          height: 23,
                          color: selectedIndex == 6
                              ? Palettes.kcNeutral5
                              : Palettes.kcNeutral4,
                        ),
                        title: Text(
                          'Expenses',
                          style: TextStyle(color: Colors.white),
                        ),
                        // shape: Border(
                        //   bottom: BorderSide(color: Colors.grey),
                        //   // top: BorderSide(color: Colors.grey),
                        // ),
                        onTap: () => setSelectedIndex(6),
                        selected: selectedIndex == 6),

                    ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/Graph.svg',
                          height: 23,
                          color: selectedIndex == 7
                              ? Palettes.kcNeutral5
                              : Palettes.kcNeutral4,
                        ),
                        title: Text(
                          'Report',
                          style: TextStyle(color: Colors.white),
                        ),
                        // shape: Border(
                        //   bottom: BorderSide(color: Colors.grey),
                        //   // top: BorderSide(color: Colors.grey),
                        // ),
                        onTap: () => setSelectedIndex(7),
                        selected: selectedIndex == 7),
                    ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Palettes.kcNeutral4,
                        ),
                        title: Text(
                          'Log Out',
                          style: TextStyle(color: Colors.white),
                        ),
                        // shape: Border(
                        //   bottom: BorderSide(color: Colors.grey),
                        //   // top: BorderSide(color: Colors.grey),
                        // ),
                        onTap: () => model.logout()),


                  ],
                ),
              ),
            ));
  }
}

class BottomNavigationCupertino extends CupertinoTabBar {
  final int selectedIndex;

  BottomNavigationCupertino({Key? key, required this.selectedIndex})
      : super(key: key, backgroundColor: Colors.white, currentIndex: 0, items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: CircleAvatar(
                radius: 20,
                backgroundColor: selectedIndex == 0
                    ? Palettes.kcBlueMain1.withOpacity(0.1)
                    : Colors.transparent,
                child: SvgPicture.asset(
                  'assets/icons/Home.svg',
                  height: 23,
                  color: selectedIndex == 0
                      ? Palettes.kcBlueMain1
                      : Palettes.kcNeutral1,
                )),
          ),
          BottomNavigationBarItem(
            label: 'Appointment',
            icon: CircleAvatar(
                radius: 20,
                backgroundColor: selectedIndex == 1
                    ? Palettes.kcBlueMain1.withOpacity(0.1)
                    : Colors.transparent,
                child: SvgPicture.asset(
                  'assets/icons/Calendar.svg',
                  height: 23,
                  color: selectedIndex == 1
                      ? Palettes.kcBlueMain1
                      : Palettes.kcNeutral1,
                )),
          ),
          BottomNavigationBarItem(
            label: 'Patients',
            icon: CircleAvatar(
                radius: 20,
                backgroundColor: selectedIndex == 2
                    ? Palettes.kcBlueMain1.withOpacity(0.1)
                    : Colors.transparent,
                child: SvgPicture.asset(
                  'assets/icons/patients.svg',
                  height: 23,
                  color: selectedIndex == 2
                      ? Palettes.kcBlueMain1
                      : Palettes.kcNeutral1,
                )),
          ),
          BottomNavigationBarItem(
            label: 'Services',
            icon: CircleAvatar(
                radius: 20,
                backgroundColor: selectedIndex == 3
                    ? Palettes.kcBlueMain1.withOpacity(0.1)
                    : Colors.transparent,
                child: SvgPicture.asset(
                  'assets/icons/Filter.svg',
                  height: 23,
                  color: selectedIndex == 3
                      ? Palettes.kcBlueMain1
                      : Palettes.kcNeutral1,
                )),
          ),
          BottomNavigationBarItem(
            label: 'Medicine',
            icon: CircleAvatar(
                radius: 20,
                backgroundColor: selectedIndex == 4
                    ? Palettes.kcBlueMain1.withOpacity(0.1)
                    : Colors.transparent,
                child: SvgPicture.asset(
                  'assets/icons/Work.svg',
                  height: 23,
                  color: selectedIndex == 4
                      ? Palettes.kcBlueMain1
                      : Palettes.kcNeutral1,
                )),
          ),
        ]);
}

///Drawer Item
class DrawerItem extends StatelessWidget {
  final String btnText;
  final IconData btnIcon;
  final VoidCallback onBtnTap;

  const DrawerItem(
      {required this.btnText,
      required this.btnIcon,
      required this.onBtnTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        btnIcon,
        color: Colors.white,
      ),
      title: Text(btnText, style: TextStyle(color: Colors.white, fontSize: 16)),
      hoverColor: null,
      onTap: () => onBtnTap(),
    );
  }
}
