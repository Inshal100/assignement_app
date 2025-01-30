import 'package:image_picker/image_picker.dart';

class Filepickerutils {
  final ImagePicker _image = ImagePicker();

  Future<XFile?> GalleryPicker() async {
    final XFile? file = await _image.pickImage(source: ImageSource.gallery);
    return file;
  }

  Future<XFile?> CameraPicker() async {
    final XFile? file = await _image.pickImage(source: ImageSource.camera);
    return file;
  }
}
