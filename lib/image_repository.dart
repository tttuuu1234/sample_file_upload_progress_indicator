import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_file_upload_progress_indicator/multipart_http_client.dart';

final imageRepositoryProvider = Provider<ImageRepository>((ref) {
  return ImageRepository(MultipartHttpClient());
});

class ImageRepository {
  const ImageRepository(this._client);

  final MultipartHttpClient _client;

  Future<void> upload(
    List<XFile?> imageList,
    void Function(int bytes, int totalBytes) onProgress,
  ) async {
    await _client.post(imageList: imageList, onProgress: onProgress);
  }
}
