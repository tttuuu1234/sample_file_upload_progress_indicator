import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerServiceProvider = Provider<ImagePickerService>((ref) {
  return const ImagePickerService();
});

class ImagePickerService {
  const ImagePickerService();

  // final ImagePicker _imagePicker;

  Future<void> takePhoto() async {
    try {
      await ImagePicker().pickImage(source: ImageSource.camera);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> selectFromGallery() async {
    try {
      await ImagePicker().pickImage(source: ImageSource.gallery);
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
