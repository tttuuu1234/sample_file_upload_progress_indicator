import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_file_upload_progress_indicator/image_repository.dart';

final imageUsecaseProvider = Provider<ImageUsecase>((ref) {
  return ImageUsecase(ref.read(imageRepositoryProvider));
});

class ImageUsecase {
  const ImageUsecase(this._imageRepository);

  final ImageRepository _imageRepository;

  Future<void> upload(List<XFile?> imageList) async {
    if (imageList.isEmpty) {
      return;
    }

    await _imageRepository.upload(imageList);
  }
}
