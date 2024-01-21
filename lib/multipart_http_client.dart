import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

final multiPartHttpClientProvider = Provider<MultipartHttpClient>((ref) {
  return const MultipartHttpClient();
});

class MultipartHttpClient {
  const MultipartHttpClient();

  Future<http.Response> post({
    required List<XFile?> imageList,
  }) async {
    final request = http.MultipartRequest('POST', Uri());
    final fileList = await _getFileList(imageList);
    print(fileList);
    request.files.addAll(fileList);
    request.headers.addAll({});
    final stream = await request.send();
    return http.Response.fromStream(stream).then((value) async {
      await Future.delayed(const Duration(seconds: 3));
      if (value.statusCode == 200) {
        return value;
      }

      return Future.error(value);
    });
  }

  Future<List<http.MultipartFile>> _getFileList(List<XFile?> imageList) async {
    final fileList = <http.MultipartFile>[];
    for (final image in imageList) {
      if (image == null) {
        continue;
      }

      final byteList = await image.readAsBytes();
      final multipartFile = http.MultipartFile.fromBytes('image', byteList);
      fileList.add(multipartFile);
    }

    return fileList;
  }
}
