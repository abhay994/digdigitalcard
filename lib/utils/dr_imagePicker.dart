import 'dart:io';

import 'package:image_picker/image_picker.dart';



final picker = ImagePicker();

Future<File?>  getImageCamera() async {
  final PickedFile? pickedFile = await picker.getImage(source: ImageSource.camera,
      imageQuality: 10
  );
  if (pickedFile != null) {
    return  File(pickedFile.path);
  }

}
Future<File?>  getImageGallary() async {
  final pickedFile = await picker.getImage(source: ImageSource.gallery,
      imageQuality: 10
  );
  if (pickedFile != null) {
    return  File(pickedFile.path);
  }

}
