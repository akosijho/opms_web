import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  ResponsiveLayout({Key? key, required this.desktopBody, required this.mobileBody}) : super(key: key);

  final Widget desktopBody;
  final Widget mobileBody;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <650){
            return mobileBody;
          } else{
            return desktopBody;
          }
        }
    );
  }
}
