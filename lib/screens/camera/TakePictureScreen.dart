import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AttachmentsTakeCamera extends StatefulWidget {
  final CameraDescription camera;
  AttachmentsTakeCamera(this.camera);
  @override
  _AttachmentsTakeCameraState createState() => _AttachmentsTakeCameraState();
}

class _AttachmentsTakeCameraState extends State<AttachmentsTakeCamera> {
  CameraController controller;
  Future<void> _initializeControllerFuture;
  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.camera, ResolutionPreset.veryHigh);
    _initializeControllerFuture = controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            // return CameraPreview(controller);
            final size = MediaQuery.of(context).size;
            final deviceRatio = size.width / size.height;
            return Transform.scale(
              scale: controller.value.aspectRatio / deviceRatio,
              child: Center(
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: CameraPreview(controller),
                ),
              ),
            );
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
        future: _initializeControllerFuture,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;
            // Construct the path where the image should be saved using the
            // pattern package.
            // final path = join(
            //   // Store the picture in the temp directory.
            //   // Find the temp directory using the `path_provider` plugin.
            //   (await getTemporaryDirectory()).path,
            //   '${DateTime.now()}.png',
            // );
            // Attempt to take a picture and log where it's been saved.
            var path = await controller.takePicture();
            File file = new File(path.path);
            // Uint8List bytes = file.readAsBytesSync();
            // String base64Image = base64Encode(bytes);
            // ignore: unnecessary_cast
            var result = await (FlutterImageCompress.compressWithFile(
              file.absolute.path,
              minWidth: 1080,
              minHeight: 720,
              quality: 50,
              rotate: 0,
            ) as FutureOr<Uint8List>);
            String base64Image = base64Encode(result);
            // If the picture was taken, display it on a new screen.
            Navigator.pop(context, base64Image);
          } catch (e) {
            // If an error occurs, log the error to the console.

          }
        },
      ),
    );
  }
}
