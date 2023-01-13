  import 'dart:typed_data';
  import 'package:image_picker/image_picker.dart';
  import 'package:firebase_storage/firebase_storage.dart';
  import 'package:uuid/uuid.dart';

pickImage(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  XFile? _file = await _picker.pickImage(source: source);

  if (_file != null) {
    return _file.readAsBytes();
  } else {
    print('image Not picked');
  }
}


