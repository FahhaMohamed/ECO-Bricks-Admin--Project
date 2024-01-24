import 'package:image_picker/image_picker.dart';

uploadImage() async {
  final ImagePicker imagePicker = ImagePicker();
  final XFile? _file = await imagePicker.pickImage(source: ImageSource.gallery);
  if(_file != null){
    return await _file.readAsBytes();
  }
  else{
    print("No Image selected");
  }
}