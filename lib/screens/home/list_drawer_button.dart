import 'package:flutter/material.dart';
import 'package:alpaga/utils/color_constants.dart';

class ListDrawerButton extends FlatButton {
  ListDrawerButton({
    @required this.onPressed,
    @required this.selected,
    @required this.iconData,
    @required this.text
  });

  final GestureTapCallback onPressed;
  final bool selected;
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: const Radius.circular(20), bottomLeft: const Radius.circular(20)),
      ),
      color: selected ? Colors.white : Colors.transparent,
      //color: Colors.grey[100],
      onPressed: onPressed,

      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.only(top: 22, bottom: 22, right: 22, left: 10),
          child: Row(children: [
            Icon(
              iconData,
              color: selected ? ColorConstants.darkOrange : ColorConstants.lightGrey,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: TextStyle(
                color: selected ? Colors.black : ColorConstants.lightGrey,
                fontSize: 18,
                fontFamily: 'HelveticaNeue',
              ),
            ),
          ]),
        ),
      ),
    );
  }
}