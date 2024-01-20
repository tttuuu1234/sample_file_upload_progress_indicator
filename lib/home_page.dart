import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_file_upload_progress_indicator/image_picker_service.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          IconButton(
            onPressed: () async {
              try {
                await imagePicker.takePhoto();
              } catch (e) {}
            },
            icon: const Icon(Icons.camera),
          ),
          IconButton(
            onPressed: () async {
              try {
                await imagePicker.selectFromGallery();
              } catch (e) {}
            },
            icon: const Icon(Icons.album),
          ),
        ],
      ),
    );
  }
}
