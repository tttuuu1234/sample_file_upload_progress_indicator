import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageUploadProgressProvider =
    NotifierProvider<ImageUploadProgressNotifier, double>(
        ImageUploadProgressNotifier.new);

class ImageUploadProgressNotifier extends Notifier<double> {
  @override
  build() {
    return 0;
  }

  void upload(double value) {
    state = value;
  }

  void reset() {
    state = 0;
  }
}

final loadingProvider =
    NotifierProvider<LoadingNotifier, bool>(LoadingNotifier.new);

class LoadingNotifier extends Notifier<bool> {
  @override
  build() {
    return false;
  }

  void show() {
    state = true;
  }

  void hide() {
    state = false;
  }
}
