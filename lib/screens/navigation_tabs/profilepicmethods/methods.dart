import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/AppConfig.dart';

Future<Response> upload(CroppedFile imageFile) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int userid = prefs.getInt('userid');
  Dio dio = new Dio();
  FormData formdata = new FormData();
  //var datetime = DateTime.fromMillisecondsSinceEpoch(
  //  start.millisecondsSinceEpoch,
  //isUtc: true);
  String fileName = imageFile.path.split('/').last;
  formdata = FormData.fromMap({
    "UserId": userid,
    "ImageFile": await MultipartFile.fromFile(
      imageFile.path,
      filename: fileName,
      //contentType: MediaType("image", 'jpg/jpeg'),
    ),
  });

  var response = await dio.post(
    '$apiUrl/api/profile/image',
    onSendProgress: (int sent, int total) {
      print('$sent $total');
    },
    data: formdata,
    options: Options(
        method: 'POST', responseType: ResponseType.json // or ResponseType.JSON
        ),
  );
  print("response of uploading:" + response.toString());
  if (response.statusCode == 200) {
    return response;
  }
}
