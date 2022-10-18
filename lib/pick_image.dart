import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class PickImage {
  static Future<File> getImage() async {
    var selectedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (selectedImage == null) return null;
    File image = File(selectedImage.path);

    return image;
  }
}
