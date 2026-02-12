import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
@lazySingleton

class UploadService {
  final Dio dio;

  UploadService(this.dio);

  Future<List<String>> uploadImages(List<XFile> images) async {
    final formData = FormData();

    for (final image in images) {
      formData.files.add(
        MapEntry(
          'images',
          await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          ),
        ),
      );
    }

    final response = await dio.post(
      '/api/upload',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    return List<String>.from(response.data['urls']);
  }
}
