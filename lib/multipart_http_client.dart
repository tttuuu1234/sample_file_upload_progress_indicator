import 'dart:async';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sample_file_upload_progress_indicator/custom_multipart_request.dart';

final multiPartHttpClientProvider = Provider<MultipartHttpClient>((ref) {
  return MultipartHttpClient();
});

class MultipartHttpClient {
  MultipartHttpClient();

  final url = 'https://api.imgur.com/3/image';
  final _clientId = dotenv.env['IMGUR_CLIENT_ID'];

  Future<http.Response> post({
    required List<XFile?> imageList,
    required void Function(int bytes, int totalBytes) onProgress,
  }) async {
    final request = CustomMultipartRequest(
      'POST',
      Uri.parse(url),
      onProgress: onProgress,
    );
    final fileList = await _setFileList(imageList);
    request.files.addAll(fileList);
    request.fields.addAll({'type': 'file'});
    request.headers.addAll(
      {'Authorization': 'Client-ID $_clientId'},
    );

    final stream = await request.send();
    return http.Response.fromStream(stream).then((value) async {
      if (value.statusCode == 200) {
        return value;
      }

      return Future.error(value);
    });
  }

  Future<List<http.MultipartFile>> _setFileList(List<XFile?> imageList) async {
    final fileList = <http.MultipartFile>[];
    for (final image in imageList) {
      if (image == null) {
        continue;
      }

      final byteList = await image.readAsBytes();
      final stream = await createFileStream(image.path);
      final multipartFile = http.MultipartFile(
        'image',
        stream,
        byteList.length,
      );
      fileList.add(multipartFile);
    }

    return fileList;
  }

  Future<Stream<List<int>>> createFileStream(String path) async {
    final file = File(path);
    return file.openRead();
  }
}
