import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerServiceProvider = Provider<ImagePickerService>((ref) {
  return const ImagePickerService();
});

class ImagePickerService {
  const ImagePickerService();

  // final ImagePicker _imagePicker;

  Future<XFile?> takePhoto() async {
    try {
      return await ImagePicker().pickImage(source: ImageSource.camera);
    } on Exception catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  Future<List<XFile?>> selectFromGallery() async {
    try {
      return await ImagePicker().pickMultiImage();
    } on Exception catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
