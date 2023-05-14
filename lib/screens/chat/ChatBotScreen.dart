import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/Provider/ChatProvider.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/ChatModel.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/body.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/gender.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/height_screen_1.dart';
import 'package:weight_loser/screens/auth/login_screen.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/SizeConfig.dart';

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  ScrollController _scrollController = ScrollController();
  String name;
  checkingapi() {}
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (mounted) {
        scrollToBottom();
      } else {
        timer.cancel();
      }
    });
  }

  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 60,
                  width: 60,
                  child: Image.asset(ImagePath.chat),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Coach",
                style: lightText16Px,
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3,
              ),
              Consumer<ChatProvider>(
                builder: (ctx, chatProv, ch) => Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                    shrinkWrap: true,
                    separatorBuilder: (ctx, index) => Container(
                      height: 10,
                    ),
                    itemBuilder: (ctx, index) =>
                        buildChatRow(chatProv.chatsList[index]),
                    itemCount: chatProv.chatsList.length,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Consumer<ChatProvider>(
                builder: (ctx, chatProv, ch) => chatProv.suggestionList == null
                    ? Container()
                    : Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          child: Wrap(
                            direction: Axis.horizontal,
                            children: [
                              for (ChatModel model in chatProv.suggestionList)
                                GestureDetector(
                                  onTap: () => suggestionItemTap(model),
                                  behavior: HitTestBehavior.translucent,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 7),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.black.withOpacity(0.07),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    child: Text(
                                      model.message,
                                      style: darkText12Px,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Consumer<ChatProvider>(
                      builder: (ctx, chatProv, ch) => TextField(
                        controller: _messageController,
                        style: lightText12Px,
                        keyboardType:
                            (chatProv.chatIndex == 3 || chatProv.chatIndex == 5)
                                ? TextInputType.numberWithOptions()
                                : TextInputType.text,
                        onTap: () {
                          setState(() {
                            _scrollController.jumpTo(
                                _scrollController.position.maxScrollExtent);
                          });
                        },
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                    color: Colors.black45, width: 0.1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                    color: Colors.black45, width: 0.1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                    color: Colors.black45, width: 0.1)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                    color: Colors.black45, width: 0.1)),
                            hintText: "Write Something..."),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.send,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        sendMessage();
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildChatRow(ChatModel chat) {
    return chat.isMe
        ? Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding:
                  EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 25),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  color: primaryColor,
                ),
                child: Text(
                  chat.message,
                  style: whiteText16Px,
                ),
              ),
            ),
          )
        : Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  EdgeInsets.only(right: SizeConfig.safeBlockHorizontal * 25),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black12,
                ),
                child: Text(
                  chat.message,
                  style: darkText16Px,
                ),
              ),
            ),
          );
  }

  void sendMessage() {
    final provider = Provider.of<ChatProvider>(context, listen: false);

    if (_messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: darkColor,
        content: Text(
          "Please enter a message",
          style: whiteText14Px,
        ),
      ));
    } else {
      setState(() {
        ChatModel model =
            ChatModel(message: _messageController.text, isMe: true);

        provider.addChatMessage(model);

        scrollToBottom();
        _messageController.text = "";
        FocusScope.of(context).unfocus();

        Responsive1.isMobile(context)
            ? Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => GenderQuestion()))
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Padding(
                          padding: const EdgeInsets.only(
                              left: 430, right: 430, top: 30, bottom: 30),
                          child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: GenderQuestion()),
                        )),
              );
      });
    }
  }

  suggestionItemTap(ChatModel model) {
    final provider = Provider.of<ChatProvider>(context, listen: false);
    provider.addChatMessage(model);
    provider.incrementIndex();
    provider.clearSuggestionList();

    _messageController.text = "";
    FocusScope.of(context).unfocus();

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        scrollToBottom();
        // checkIndexAndReply(provider);
      });
    });
  }

  void checkIndexAndReply(ChatProvider provider) {
    if (provider.chatIndex == 1) {
      name = _messageController.text;
      ChatModel m = ChatModel(
          message:
              "$name I will be taking a couple of minutes of your time to ask"
              "some questions which will help me understand your habits better.",
          isMe: false);
      provider.addChatMessage(m);

      ChatModel m1 = ChatModel(message: "So what is your gender?", isMe: false);
      provider.addChatMessage(m1);
      provider.setSuggestionList(provider.genderList);
    } else if (provider.chatIndex == 2) {
      ChatModel m =
          ChatModel(message: "So $name how old are you?", isMe: false);
      provider.addChatMessage(m);
      provider.incrementIndex();
    } else if (provider.chatIndex == 3) {
      ChatModel m =
          ChatModel(message: "What is your current weight(lbs)?", isMe: false);
      provider.addChatMessage(m);
      provider.incrementIndex();
    } else if (provider.chatIndex == 4) {
      ChatModel m =
          ChatModel(message: "And how tall are you?(inches)", isMe: false);
      provider.addChatMessage(m);
      provider.incrementIndex();
    } else if (provider.chatIndex == 5) {
      ChatModel m =
          ChatModel(message: "What is your goal weight(lbs)?", isMe: false);
      provider.addChatMessage(m);
      provider.incrementIndex();
    } else if (provider.chatIndex == 6) {
      ChatModel m = ChatModel(
          message: "Ok so according to our record your recommended "
              "BMI lies in between(numbers)",
          isMe: false);
      provider.addChatMessage(m);

      ChatModel m1 = ChatModel(
          message:
              "Now $name tell me at what pace would you like to lose weight?",
          isMe: false);
      provider.addChatMessage(m1);
      provider.setSuggestionList(provider.loseWeightList);
    } else if (provider.chatIndex == 7) {
      ChatModel m =
          ChatModel(message: "Now lets talk about your habits", isMe: false);
      provider.addChatMessage(m);
      ChatModel m1 = ChatModel(
          message: "On which area would you like little support?", isMe: false);
      provider.addChatMessage(m1);
      provider.setSuggestionList(provider.areaSupportList);
    } else if (provider.chatIndex == 8) {
      ChatModel m =
          ChatModel(message: "$name when do you mostly give up? ", isMe: false);
      provider.addChatMessage(m);
      provider.setSuggestionList(provider.giveUpList);
    } else if (provider.chatIndex == 9) {
      ChatModel m = ChatModel(
          message: "$name how much time you spend sitting? ", isMe: false);
      provider.addChatMessage(m);
      provider.setSuggestionList(provider.sittingList);
    } else if (provider.chatIndex == 10) {
      ChatModel m = ChatModel(
          message: "What type of activity do you like? ", isMe: false);
      provider.addChatMessage(m);
      provider.setSuggestionList(provider.activityLikeList);
    } else if (provider.chatIndex == 11) {
      ChatModel m =
          ChatModel(message: "How many days a week you work out?", isMe: false);
      provider.addChatMessage(m);
      provider.setSuggestionList(provider.daysWeekWorkoutList);
    } else if (provider.chatIndex == 12) {
      ChatModel m = ChatModel(
          message: "How much time of the day you spend moving?", isMe: false);
      provider.addChatMessage(m);
      provider.setSuggestionList(provider.sependMovingList);
    } else if (provider.chatIndex == 13) {
      ChatModel m = ChatModel(
          message: "How many hours a day you sleep on average?", isMe: false);
      provider.addChatMessage(m);
      provider.setSuggestionList(provider.averageSleepList);
    } else if (provider.chatIndex == 14) {
      ChatModel m = ChatModel(
          message: "$name do you have any issues with sleeping?", isMe: false);
      provider.addChatMessage(m);
      provider.setSuggestionList(provider.issuesSleepList);
    } else if (provider.chatIndex == 15) {
      ChatModel m1 = ChatModel(
          message: "Because sleeps impacts weight loss this is the area"
              "we dont want you to ignore",
          isMe: false);
      provider.addChatMessage(m1);

      ChatModel m2 = ChatModel(
          message: "Ok $name, this is the info i need, i am analyzing"
              "and creating a plan for you",
          isMe: false);
      provider.addChatMessage(m2);
      provider.incrementIndex();
      provider.clearSuggestionList();
      Get.to(() => GenderQuestion());
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => HeightScreen()),
      //       // LoginScreen()),
      // );
    }
  }

  void scrollToBottom() {
    final bottomOffset = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      bottomOffset,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
