import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_file_upload_progress_indicator/image_picker_service.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async {
                try {
                  final photo = await imagePicker.takePhoto();
                  await imageUsecase.upload([photo]);
                } catch (e) {}
              },
              icon: const Icon(Icons.camera),
            ),
            IconButton(
              onPressed: () async {
                try {
                  final photoList = await imagePicker.selectFromGallery();
                  await imageUsecase.upload(photoList);
                } catch (e) {}
              },
              icon: const Icon(Icons.album),
            ),
          ],
        ),
      ),
    );
  }
}
