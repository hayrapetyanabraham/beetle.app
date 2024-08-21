import 'package:app/constants/colors.dart';
import 'package:app/models/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  final User user;

  const HelpPage({Key key, this.user}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  var textStyleHeader = const TextStyle(
    color: AppColors.tuna,
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
  );

  var textStyleTitle = TextStyle(
    color: AppColors.tuna.withOpacity(0.7),
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: _bodyBuild());
  }

  Widget _bodyBuild() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.user.fullName != null) ...[
            Text(
              'Full Name',
              style: textStyleTitle,
            ),
            Text(
              widget.user.fullName.toString(),
              style: textStyleHeader,
            ),
          ],
          const SizedBox(
            height: 8,
          ),
          if (widget.user.email != null) ...[
            Text(
              'Email',
              style: textStyleTitle,
            ),
            Text(
              widget.user.email.toString(),
              style: textStyleHeader,
            ),
          ],
          const SizedBox(
            height: 8,
          ),
          if (widget.user.phone != null) ...[
            Text(
              'Phone Number',
              style: textStyleTitle,
            ),
            Text(
              widget.user.phone.toString(),
              style: textStyleHeader,
            ),
          ],
          const SizedBox(
            height: 8,
          ),
          if (widget.user.gender != null) ...[
            Text(
              'Gender',
              style: textStyleTitle,
            ),
            Text(
              int.parse(widget.user.gender.toString()) == 0 ? 'Male' : 'Female',
              style: textStyleHeader,
            ),
          ]
        ],
      ),
    );
  }
}
