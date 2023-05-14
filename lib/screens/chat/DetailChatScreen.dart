import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/chatService.dart';
import 'package:weight_loser/constants/constant.dart';

import 'package:weight_loser/screens/chat/ReceivedMessageScreen.dart';
import 'package:weight_loser/screens/chat/SentMessageScreen.dart';

class DetailChatScreen extends StatefulWidget {
  final title;

  const DetailChatScreen({Key key, this.title}) : super(key: key);

  _DetailChatScreen createState() => _DetailChatScreen();
}

class _DetailChatScreen extends State<DetailChatScreen> {
  TextEditingController textFieldController;

  TextInputAction _textInputAction = TextInputAction.newline;
  ScrollController _scrollController = ScrollController();
  List<Widget> _chatWidgets = [];

  @override
  void initState() {
    super.initState();
    textFieldController = TextEditingController();
  }

  final ImagePicker _picker = ImagePicker();

  // ignore: unused_field
  List<XFile> _imageFileList;

// #################################### SETTER FOR IMAGE  ################################
  set _imageFile(XFile value) {
    _imageFileList = value == null ? null : [value];
  }

  // ignore: unused_field
  dynamic _pickImageError;

// #################################### GETTING IMAGE FROM GALLERY ################################

  Future<File> getImageFromGallery() async {
    XFile pickedFile;
    try {
      pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      // setState(() {
      //   _imageFile = pickedFile;
      // });
    } catch (e) {
      // setState(() {
      //   _pickImageError = e;
      // });
    }
    File _newFile = File(pickedFile.path);
    return _newFile;
  }

  @override
  Widget build(BuildContext context) {
    var iconColor;
    var textFieldHintColor;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset('assets/icons/back_arrow.png')),
              ),
            ),
            SizedBox(height: MySize.size5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(""),
                      Text(""),
                      Text(""),
                      Padding(
                        padding: EdgeInsets.only(left: MySize.size10),
                        child: DDText(
                          title: widget.title == null ? "" : widget.title,
                          size: MySize.size12,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.person,
                          color: Color(0xffafafaf),
                          size: 40,
                        ),
                        radius: 30,
                      ),
                      DDText(
                        title: "Staff",
                        size: MySize.size15,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(""),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Flexible(
              // flex: 8,
              flex: 7,
              child: Container(
                height: double.infinity,
                // color: Colors.blue,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: _scrollController,
                  child: StreamBuilder(
                      stream: ChatService.getMessages(
                          widget.title, ChatService.senderId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.connectionState ==
                                ConnectionState.active) {
                          _chatWidgets.clear();
                          for (var item in snapshot.data.docs) {
                            var chat = item.data();

                            print(chat['msg']);
                            if (chat['senderId'] == ChatService.senderId) {
                              if (chat['isMedia'] &&
                                  chat['mediaLink'] != null) {
                                print(chat['mediaLink']);
                                _chatWidgets.add(Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 15),
                                      height: 200,
                                      width: 100,
                                      child: Image.network(chat['mediaLink']),
                                    )));
                              } else
                                _chatWidgets.add(
                                    SentMessageScreen(message: chat['msg']));
                            } else {
                              if (chat['isMedia'] &&
                                  chat['mediaLink'] != null) {
                                print(chat['mediaLink']);
                                _chatWidgets.add(Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 15),
                                      height: 200,
                                      width: 100,
                                      child: Image.network(chat['mediaLink']),
                                    )));
                              } else
                                _chatWidgets.add(ReceivedMessageScreen(
                                    message: chat['msg']));
                            }
                          }

                          return Column(children: [
                            ..._chatWidgets,
                          ]);
                        } else
                          return Center(child: CircularProgressIndicator());
                      }),
                ),
              ),
            ),
            Flexible(
              // flex: 2,
              child: Container(
                height: 100,
                // color: Colors.red,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(left: 0),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(const Radius.circular(30.0)),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: <Widget>[
                            // IconButton(
                            //   padding: const EdgeInsets.all(0.0),
                            //   disabledColor: iconColor,
                            //   color: iconColor,
                            //   icon: Icon(Icons.insert_emoticon),
                            //   onPressed: () {},
                            // ),
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[100],
                                    ),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: TextField(
                                          controller: textFieldController,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          textInputAction: _textInputAction,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.all(3),
                                            hintText: 'Type a message',
                                            hintStyle: TextStyle(
                                              color: textFieldHintColor,
                                              fontSize: 16.0,
                                            ),
                                            counterText: '',
                                          ),
                                          onSubmitted: (String text) {
                                            if (_textInputAction ==
                                                TextInputAction.send) {
                                              _sendMessage(widget.title, text);
                                            }
                                          },
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          maxLength: 200,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      color: iconColor,
                                      icon: Icon(
                                        FontAwesomeIcons.paperclip,
                                        color: Colors.grey[300],
                                        size: 20,
                                      ),
                                      onPressed: () async {
                                        File _uploadFile =
                                            await getImageFromGallery();
                                        if (_uploadFile != null &&
                                            _uploadFile.path.isNotEmpty) {
                                          await ChatService.sendChatMsg(
                                              widget.title,
                                              "",
                                              true,
                                              _uploadFile);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              color: iconColor,
                              icon: Icon(
                                Icons.send,
                                color: primaryColor,
                              ),
                              onPressed: () async {
                                _sendMessage(widget.title,
                                    textFieldController.value.text);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  int offsetUnsentMessage = 0;

  Future<void> _sendMessage(recieverId, String msg) async {
    if (msg.isNotEmpty) {
      textFieldController.clear();
      await ChatService.sendChatMsg(recieverId, msg).then((value) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    }
  }
}
