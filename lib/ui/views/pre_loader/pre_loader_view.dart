import 'package:animate_do/animate_do.dart';
import 'package:opmsapp/constants/font_name/font_name.dart';
import 'package:opmsapp/constants/styles/palette_color.dart';
import 'package:opmsapp/constants/styles/text_styles.dart';
import 'package:opmsapp/main.dart';
import 'package:opmsapp/ui/views/pre_loader/pre_loader_view_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

class PreLoaderView extends StatelessWidget {
  const PreLoaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PreLoaderViewModel>.reactive(
      viewModelBuilder: () => PreLoaderViewModel(),
      onModelReady: (model) {
        model.listenToConnectivityChanges();
      },
      builder: (context, model, child) => Scaffold(
        body: Container(
          color: Colors.grey.shade50,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 130,
                        width: 130,
                        // decoration: BoxDecoration(
                        //     color: Palettes.kcBlueMain1,
                        //     borderRadius: BorderRadius.circular(20),
                        //     border: Border.all(color: Colors.white, width: 2)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset(
                              'assets/icons/logo_splash.png',
                            ))),
                    SizedBox(height: 10),
                    ElasticIn(
                      child: Text(
                        'EyeChoice Optical Shop',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: FontNames.gilRoy,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          letterSpacing: 1,
                          wordSpacing: 1,
                          color: Palettes.kcBlueMain1,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    CircularProgressIndicator(
                      color: Palettes.kcBlueMain1,
                      strokeWidth: 5,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Text(
                    'Version $appVersion',
                    style: TextStyles.tsBody4(color: Palettes.kcNeutral1),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
