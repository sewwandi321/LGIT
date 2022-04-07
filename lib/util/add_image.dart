import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/*Created by - IT19246024 - Warnakulasuriya D.A*/
/*Learn from a tutorial - this method is use to pick an image from the gallery */
pickImage() async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: ImageSource.gallery);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  const AlertDialog(semanticLabel: 'Please select image');
}
