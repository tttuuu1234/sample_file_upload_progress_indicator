import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_file_upload_progress_indicator/image_picker_service.dart';
import 'package:sample_file_upload_progress_indicator/image_upload_progress_notifier.dart';
import 'package:sample_file_upload_progress_indicator/image_usecase.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final imagePicker = ref.watch(imagePickerServiceProvider);
    final imageUsecase = ref.watch(imageUsecaseProvider);
    final progress = ref.watch(imageUploadProgressProvider);
    final loading = ref.watch(loadingProvider);
    final loadingNotifier = ref.watch(loadingProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    try {
                      final photo = await imagePicker.takePhoto();
                    } catch (e) {}
                  },
                  icon: const Icon(Icons.camera),
                ),
                IconButton(
                  onPressed: () async {
                    try {
                      loadingNotifier.show();
                      final photoList = await imagePicker.selectFromGallery();
                      await imageUsecase.upload(photoList);
                    } catch (e) {
                    } finally {
                      loadingNotifier.hide();
                    }
                  },
                  icon: const Icon(Icons.album),
                ),
              ],
            ),
            if (loading)
              CircularProgressIndicator(
                value: progress,
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
              ),
          ],
        ),
      ),
    );
  }
}
