import 'package:image_picker/image_picker.dart';

/**
 * created by IT19123196(K.H.T.N Dewangi)
 */
// ignore: slash_for_doc_comments
/**From Tutorial
 * for picking up image from gallery
 * 1st create inizilize and create instance of image picker
 * xfile can be null then check file received or not
 * if received return file
*/
pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Any Image Selected');
}
