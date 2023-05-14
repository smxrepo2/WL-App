import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/utils/AppConfig.dart';

class DialogUploadVideoWidget extends StatefulWidget {
  final File videoFile;
  final Function function;

  DialogUploadVideoWidget(this.videoFile, this.function);

  @override
  _DialogUploadVideoWidgetState createState() => _DialogUploadVideoWidgetState();
}

class _DialogUploadVideoWidgetState extends State<DialogUploadVideoWidget> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  String duration = '0';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.videoFile.toString());
    getVideoDuration();
  }

  getVideoDuration() async {

    // final videoInfo = FlutterVideoInfo();
    // var info = await videoInfo.getVideoInfo(widget.videoFile.path);
    // duration = (info.duration / 1000).toStringAsFixed(0) ;
    // print("Duration : " + duration);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 320,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: showContainer(),
          ),
        ),
      ),
    );
  }

  showContainer() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              "Upload Video Data",
              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: titleController,
                    textCapitalization: TextCapitalization.words,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
                      hintText: "Enter Title",
                      labelStyle: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500),
                      labelText: "Title",
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: primaryColor)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: primaryColor)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) return 'Please Enter Title';
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: descriptionController,
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
                      hintText: "Enter Description",
                      labelStyle: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500),
                      labelText: "Description",
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: primaryColor)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: primaryColor)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) return 'Please Enter Description';
                      return null;
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [primaryColor, primaryColor]),
              ),
              height: 35,
              margin: EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  if (formKey.currentState.validate()) {
                    SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
                    _dialog.show(message: 'Please Wait', type: SimpleFontelicoProgressDialogType.normal);
                    upload(widget.videoFile).then((value) {
                      print("dio response data ${value.data} code ${value.statusCode} message ${value.statusMessage}");
                      print(value.data.toString());
                      _dialog.hide();
                      Flushbar(
                        title: "Message",
                        message: "Video Uploaded Successfully",
                        duration: Duration(seconds: 4),
                      )..show(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      widget.function();
                    }).onError((error, stackTrace) {
                      _dialog.hide();
                      Flushbar(
                        title: "Message",
                        message: error.toString(),
                        duration: Duration(seconds: 4),
                      )..show(context);
                      print("dio response error ${error.toString()}");
                    });
                  }
                },
                child: Center(
                  child: Text(
                    "Upload",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
int userid;
  Future<Response> upload(File imageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    Dio dio = new Dio();
    FormData formdata = new FormData();
    String fileName = imageFile.path.split('/').last;
    print("file data ${imageFile.path} $imageFile");
    formdata = FormData.fromMap({
      "Title": titleController.text,
      "Description": descriptionController.text,
      "Duration": duration,
      "UserId":userid,
      "IvideoFile": await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
        //contentType: new MediaType("image", "jpeg"),
      )
    });
    print(formdata.fields.toString());
    return dio.post(
      '$apiUrl/api/video',
      onSendProgress: (int sent, int total) {
        print('$sent $total');
      },
      data: formdata,
      options: Options(method: 'POST', responseType: ResponseType.json),
    );
  }
}
