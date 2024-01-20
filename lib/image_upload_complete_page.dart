import 'package:flutter/material.dart';

class ImageUploadCompletePage extends StatelessWidget {
  const ImageUploadCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload complete'),
      ),
      body: const Column(
        children: [
          Text('完了！'),
        ],
      ),
    );
  }
}
