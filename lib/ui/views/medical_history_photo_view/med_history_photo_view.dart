import 'package:cached_network_image/cached_network_image.dart';
import 'package:opmswebstaff/models/medical_history/medical_history.dart';
import 'package:opmswebstaff/ui/views/medical_history_photo_view/med_history_photo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:stacked/stacked.dart';

class MedHistoryPhotoView extends StatelessWidget {
  final List<MedicalHistory> medHistory;
  final int initialIndex;
  const MedHistoryPhotoView(
      {Key? key, required this.medHistory, required this.initialIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MedHistoryPhotoViewModel>.nonReactive(
      viewModelBuilder: () => MedHistoryPhotoViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        body: Container(
          child: PhotoViewGallery.builder(
            pageController: model.pageController(initialIndex: initialIndex),
            itemCount: medHistory.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                key: ObjectKey(medHistory[index]),
                imageProvider:
                    CachedNetworkImageProvider(medHistory[index].image!),
                initialScale: PhotoViewComputedScale.contained * 1,
                heroAttributes: null,
              );
            },
          ),
        ),
      ),
    );
  }
}
