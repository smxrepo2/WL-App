import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;
  final Color color;

  const CircleButton({Key key, this.onTap, this.iconData, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 10.0;

    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: iconData == null
            ? Text("")
            : Icon(
                iconData,
                color: Colors.transparent,
              ),
      ),
    );
  }
}
