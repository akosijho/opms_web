import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

import '../../../app/app.locator.dart';
import '../../../constants/styles/palette_color.dart';
import '../../../core/service/api/api_service.dart';
import '../../../core/service/connectivity/connectivity_service.dart';
import '../../../core/service/dialog/dialog_service.dart';
import '../../../core/service/navigation/navigation_service.dart';
import '../../../core/service/snack_bar/snack_bar_service.dart';
import '../../../core/service/toast/toast_service.dart';
import '../../../models/procedure/procedure.dart';

class ProcedureCard extends StatefulWidget {
  final String id;
  final Procedure procedure;
  final VoidCallback? onTap;
  const ProcedureCard(
      {Key? key, required this.id, required this.procedure, this.onTap})
      : super(key: key);

  @override
  State<ProcedureCard> createState() => _ProcedureCardState();
}

class _ProcedureCardState extends State<ProcedureCard> {
  final connectivityService = locator<ConnectivityService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();
  final toastService = locator<ToastService>();

  Future<void> deleteProcedure(String procedureId) async {
    dialogService.showConfirmDialog(
        title: 'Delete  Service',
        middleText:
            'This action will delete the selected service permanently. Continue this action?',
        onCancel: () => navigationService.pop(),
        onContinue: () async {
          // if (await connectivityService.checkConnectivity()) {
            await apiService.deleteProcedure(procedureId: procedureId);
            navigationService.pop();
            toastService.showToast(message: 'Service deleted');
          // } else {
          //   toastService.showToast(
          //       message: 'Network Error. Please Try Again Later.');
          // }
        });
  }

  void updateProcedure(Procedure procedure) {
    navigationService.pushNamed(Routes.UpdateProcedureViews,
        arguments: UpdateProcedureViewArguments(procedure: procedure));
  }

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: ObjectKey(widget.id),
      backgroundColor: Colors.grey.shade200,
      trailingActions: [
        SwipeAction(
          widthSpace: 60,
          color: Colors.transparent,
          onTap: (handler) async {
            // await handler(true);
            if (widget.procedure.id != null) {
              this.deleteProcedure(widget.procedure.id!);
            } else {
              toastService.showToast(message: 'Something went wrong');
            }
          },
          content: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red.shade700,
            ),
            child: SvgPicture.asset(
              'assets/icons/Delete.svg',
              color: Colors.white,
            ),
          ),
          nestedAction: SwipeNestedAction(
            content: Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.red.shade700,
              ),
              child: Container(
                width: 95,
                child: OverflowBox(
                  maxWidth: 95,
                  minWidth: 95,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/Delete.svg',
                        color: Colors.white,
                      ),
                      Text(
                        'Delete',
                        style: TextStyles.tsBody2(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SwipeAction(
          widthSpace: 60,
          color: Colors.transparent,
          onTap: (handler) {
            this.updateProcedure(widget.procedure);
          },
          content: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Palettes.kcBlueMain2,
            ),
            child: SvgPicture.asset(
              'assets/icons/Edit.svg',
              color: Colors.white,
            ),
          ),
        ),
      ],
      child: GestureDetector(
        onTap: () => widget.onTap != null ? widget.onTap!() : null,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(0, 0), blurRadius: 1)
                ]),
            child: Row(
              children: [
                Container(
                    width: 5,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Palettes.kcDarkerBlueMain1,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4)))),
                SizedBox(width: 4),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 9),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.procedure.procedureName,
                        style: TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text('Amnt. '),
                          Text(
                            widget.procedure.priceToCurrency ?? 'Not Set',
                            style: TextStyles.tsBody2(color: Colors.deepOrange),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
