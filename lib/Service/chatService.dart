import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ChatService {
  static final _firebaseStorage = FirebaseStorage.instance.ref();
  static var _chatRef = FirebaseFirestore.instance.collection("Chats");
  static String senderId = "FAHAD";

  static Future<void> sendChatMsg(recieverId, msg,
      [isMedia = false, File mediaFile]) async {
    Map<String, dynamic> msgMap = {};
    msgMap['msg'] = msg;
    msgMap['createdAt'] = DateTime.now();
    msgMap['senderId'] = senderId;
    msgMap['recieverId'] = recieverId;
    msgMap['isMedia'] = isMedia;
    if (isMedia) {
      msgMap['mediaLink'] = await uploadImagesToStorage(mediaFile, senderId);
    }
    await _chatRef.doc().set(msgMap);
  }

  static getMessages(recieverId, senderId) {
    // return FirebaseFirestore.instance.collection("Chats").snapshots();
    return FirebaseFirestore.instance
        .collection("Chats")
        .where("senderId", isEqualTo: senderId)
        .where("recieverId", isEqualTo: recieverId)
        .orderBy("createdAt")
        .snapshots();
    // return _chatRef.where('senderId', isEqualTo: senderId).where('recieverId',
    // isEqualTo: recieverId).orderBy('createdAt').snapshots();
  }

  static Future<String> uploadImagesToStorage(
      File imageFile, String userId) async {
    var url;
    var _data = DateTime.now().millisecondsSinceEpoch.toString();

    try {
      Reference storageReference =
          _firebaseStorage.child("UserImages").child(userId).child(_data);
      UploadTask storageUploadTask = storageReference.putFile(imageFile);
      url = await (await storageUploadTask.whenComplete(() => true))
          .ref
          .getDownloadURL();
      return url;
    } catch (e) {
      Get.snackbar("Error", "$e");
      print(e);
    }
    return url;
  }
}
