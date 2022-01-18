import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final bool isDisabled;
  final Color buttonColor;
  final Color disabledColor;
  final Color textColor;
  final VoidCallback onPressed;

  const RoundedButtonWidget({
    Key key,
     this.buttonText,
     this.buttonColor,
     this.disabledColor,
    this.textColor = Colors.white,
     this.isDisabled,
     this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      height: 50,
      color: buttonColor,
      disabledColor: disabledColor,
      shape: const StadiumBorder(),
      onPressed: isDisabled ? null : onPressed,
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.button.copyWith(color: textColor),
      ),
    );
  }
}
