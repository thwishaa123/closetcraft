import 'dart:convert';
import 'package:http/http.dart' as http;

class CloudinaryService {
  final String cloudName;
  final String uploadPreset;

  CloudinaryService({required this.cloudName, required this.uploadPreset});

  Future<String?> uploadImage(String filePath) async {
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', filePath));

    final response = await request.send();
    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      final data = json.decode(respStr);
      return data['secure_url'];
    } else {
      return null;
    }
  }
}
