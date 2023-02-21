import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ToothWidget extends StatelessWidget {
  final bool? isSelected;
  final bool? hasRecord;
  final String toothId;
  final bool isUpper;
  final isCenterTooth;
  final VoidCallback? onTap;

  const ToothWidget(
      {Key? key,
      this.isSelected,
      this.hasRecord,
      required this.toothId,
      required this.isUpper,
      this.onTap,
      this.isCenterTooth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => this.onTap!(),
      child: Column(
        children: [
          Visibility(
            visible: isUpper,
            child: Text(toothId),
          ),
          Container(
            height: 38,
            width: 38,
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: checkHistory(isSelected, hasRecord),
              border: isCenterTooth
                  ? Border.all(
                      color: isSelected == true
                          ? Colors.blue.shade800
                          : Colors.blueAccent,
                      width: 2)
                  : Border.all(
                      color: hasRecord == true && !isSelected!
                          ? Colors.red.shade900
                          : isSelected == true
                              ? Colors.blue.shade800
                              : Colors.black,
                      width: isSelected == true || hasRecord == true ? 3 : 0.8),
            ),
            child: SvgPicture.asset(
              'assets/icons/tooth.svg',
              color: hasRecord != null && hasRecord == true && !isSelected!
                  ? Colors.white
                  : hasRecord != null && hasRecord == true && isSelected!
                      ? Colors.black
                      : Colors.black,
            ),
          ),
          Visibility(
            visible: !isUpper,
            child: Text(toothId),
          ),
        ],
      ),
    );
  }

  Color checkHistory(bool? isSelected, bool? hasRecord) {
    if (isSelected != null && isSelected) {
      return Colors.blue.shade200;
    } else if (hasRecord != null && hasRecord) {
      return Colors.red.shade400;
    } else {
      return Colors.white;
    }
  }
}
