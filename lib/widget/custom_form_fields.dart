import 'package:flutter/material.dart';
import 'package:weight_loser/utils/dimensions.dart';

class CustomFormFields {
  static Widget formField({
    String hint,
    IconData iconField,
    Function onChange,
    Function validator,
    isObscure = false,
    Function onSubmitted,
    Function onSaved,
    TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool autoValidate = false,
  }) {
    return Container(
      child: Theme(
        data: ThemeData(
            primaryColor: ConstantColors.LIGHT_BLUE,
            hintColor: ConstantColors.DARK_GRAY),
        child: TextFormField(
          controller: controller,
          obscureText: isObscure,
          // ignore: deprecated_member_use
          //autovalidate: autoValidate,
          decoration: InputDecoration(

            hintText: hint,
            labelStyle: const TextStyle(color: Colors.black),
            hintStyle: const TextStyle(),
            filled: true,
            fillColor: ConstantColors.WHITE_COLOR,
            focusedBorder: const OutlineInputBorder(
            ),
          ),
          onChanged: onChange,
          onFieldSubmitted: onSubmitted,
          validator: validator,
          onSaved: onSaved,
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  static Widget formFieldWithoutIcon({
    String hint,
    TextEditingController controller,
    IconData iconField,
    Widget suffixIcon,
    Function onChange,
    Widget icon,

    Function validator,
    String errorText,
    isObscure = false,
    Function onSaved,
    Function onSubmitted,
    TextInputType keyboardType = TextInputType.text,
    bool autoValidate = false,
  }) {
    return Container(
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: controller,
        obscureText: isObscure,
        // ignore: deprecated_member_use
        //autovalidate: autoValidate,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: icon,
          suffixIcon: suffixIcon,
          labelStyle: const TextStyle(color: Colors.black),

          filled: true,
          // border: OutlineInputBorder(),
          errorText: errorText,
          fillColor: ConstantColors.WHITE_COLOR,

          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:  Colors.blue.withOpacity(0.3),

            ),

          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.withOpacity(0.3),),

          ),
        ),
        onChanged: onChange,
        onSaved: onSaved,
        onFieldSubmitted: onSubmitted,
        validator: validator,
        keyboardType: keyboardType,
      ),
    );
  }

  static Widget simpleFormField({
    String hint,
    IconData iconField,
    Function onChange,
    Function validator,
    isObscure = false,
    Function onSaved,
    Function onSubmitted,
    TextInputType keyboardType = TextInputType.text,
    bool autoValidate = false,
  }) {
    return Container(
      child: TextFormField(
        obscureText: isObscure,
        // ignore: deprecated_member_use
        //autovalidate: autoValidate,
        decoration: InputDecoration(
          hintText: hint,
          labelStyle: const TextStyle(color: Colors.black),
          hintStyle: const TextStyle(),
          filled: true,

          fillColor: ConstantColors.WHITE_COLOR,
          // border: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS)),
          // enabledBorder: OutlineInputBorder(
          //   // borderSide: BorderSide(
          //   //   color: ConstantColors.GRAY.withOpacity(0.4),
          //   //   width: Dimensions.BORDER_WIDTH,
          //   // ),
          //   borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: ConstantColors.GRAY),
          //   borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS),
          // ),
        ),
        onChanged: onChange,
        onSaved: onSaved,
        onFieldSubmitted: onSubmitted,
        validator: validator,
        keyboardType: keyboardType,
      ),
    );
  }
}
