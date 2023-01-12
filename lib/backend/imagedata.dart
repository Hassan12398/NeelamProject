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


class ImageUpload {
  Future<String> uploadImage(Uint8List image) async {
    var uuid = Uuid();
    var id = uuid.v1();
    // folder name & iamge name
    Reference ref = await FirebaseStorage.instance
        .ref()
        .child('ProductImages')
        .child('${id}.jpg');
    // image is uploading from putData()
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
