import 'package:image_picker/image_picker.dart';

class ImageSelector {
  final ImagePicker _imagePicker = ImagePicker();
  Future<XFile?> selectImageWithGallery() async {
    return await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 30);
  }

  Future<XFile?> selectImageWithCamera() async {
    return await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 30);
  }
}
