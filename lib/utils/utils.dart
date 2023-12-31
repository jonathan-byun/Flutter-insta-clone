import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return _file;
  }
}

pickMultipleImages() async {
  final ImagePicker _imagePicker = ImagePicker();
  List<XFile>? _file = await _imagePicker.pickMultiImage(
    imageQuality: 100,
  );
  if (_file != null) {
    return _file;
  }
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
