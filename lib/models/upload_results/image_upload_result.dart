class ImageUploadResult {
  final String? imageUrl;
  final String? imageFileName;
  final bool isUploaded;
  final String? message;

  ImageUploadResult._(
      {this.imageUrl,
      this.imageFileName,
      required this.isUploaded,
      this.message});

  factory ImageUploadResult.success(String imageFileName, String imageUrl) =>
      ImageUploadResult._(
          isUploaded: true, imageFileName: imageFileName, imageUrl: imageUrl);

  factory ImageUploadResult.error(String message) =>
      ImageUploadResult._(isUploaded: false, message: message);
}
