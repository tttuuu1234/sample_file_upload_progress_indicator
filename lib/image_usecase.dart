import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_file_upload_progress_indicator/image_repository.dart';
import 'package:sample_file_upload_progress_indicator/image_upload_progress_notifier.dart';

final imageUsecaseProvider = Provider<ImageUsecase>((ref) {
  return ImageUsecase(ref, ref.read(imageRepositoryProvider));
});

class ImageUsecase {
  const ImageUsecase(this._ref, this._imageRepository);

  final Ref _ref;
  final ImageRepository _imageRepository;

  Future<void> upload(List<XFile?> imageList) async {
    if (imageList.isEmpty) {
      return;
    }

    await _imageRepository.upload(
      imageList,
      (bytes, totalBytes) {
        print(bytes);
        print(totalBytes);
        final progressValue = bytes / totalBytes;
        _ref.read(imageUploadProgressProvider.notifier).upload(progressValue);
      },
    );
    _ref.read(imageUploadProgressProvider.notifier).reset();
  }
}
