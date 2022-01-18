import 'package:app/models/user/user.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  final User user;

  const HelpPage({Key key, this.user}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: Text(widget.user.email.toString()));
  }
}
