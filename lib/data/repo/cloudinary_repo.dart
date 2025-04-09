import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CloudinaryRepo {
  Future<String?> uploadToCloudinary(XFile imageFile) async {
    const cloudName = 'dtcvutusn';
    const uploadPreset = 'closetcraft';
    const uploadUrl = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

    final request = http.MultipartRequest('POST', Uri.parse(uploadUrl))
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final resStream = await response.stream.bytesToString();
      final jsonData = json.decode(resStream);
      return jsonData['secure_url']; // This is the image URL
    } else {
      print('Upload failed: ${response.statusCode}');
      return null;
    }
  }
}
