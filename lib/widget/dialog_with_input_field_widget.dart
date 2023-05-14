import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';

class DialogWithInputFieldWidget extends StatefulWidget {
  final Function function;
  final String text, title;

  DialogWithInputFieldWidget(this.function, this.text, this.title);

  @override
  _DialogWithInputFieldWidgetState createState() =>
      _DialogWithInputFieldWidgetState();
}

class _DialogWithInputFieldWidgetState
    extends State<DialogWithInputFieldWidget> {
  TextEditingController textController = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        width: Responsive1.isMobile(context)?null:300,
        height: 270,
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
            padding: EdgeInsets.only(top: 10),
            child: Text(
              widget.title == "Name" ? "Custom Plan Name" : "Custom Plan Days",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 10),
            child: Text(
              widget.title == "Name"
                  ? 'Edit Your Custom Plan Name'
                  : 'Edit Your Custom Plan Days',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Form(
            key: formKey,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: textController,
                textCapitalization: TextCapitalization.words,
                minLines: 1,
                maxLines: 5,
                keyboardType: widget.title == "Name"
                    ? TextInputType.text
                    : TextInputType.number,
                maxLength: widget.title=="Days"?1:25,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                  hintText:
                      widget.title == "Name" ? "Enter Name" : "Enter Days",
                  labelStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  labelText: widget.title == "Name" ? "Name" : "Days",
                  helperStyle:TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500) ,
                  helperText: widget.title=="Name"?"":"Days Enter between 1 to 7",
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: primaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: primaryColor)),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return widget.title == "Name"
                        ? 'Please Enter Name'
                        : 'Please Enter Days';
                  }
                  if (value.isNotEmpty &&
                      widget.title != "Name" &&
                      int.tryParse(value) == 0) {
                    return 'Please Enter Valid Days';
                  } else {
                    return null;
                  }
                  ;
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [primaryColor, primaryColor]),
              ),
              height: 45,
              margin: EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  if (formKey.currentState.validate()) {
                    Navigator.pop(context);
                    widget.function(textController.text);
                  }
                },
                child: Center(
                  child: Text(
                    "Update",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
