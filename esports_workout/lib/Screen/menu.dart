import 'package:flutter/material.dart';
import '/data/User.dart';

class Menu extends StatelessWidget {
  final User user;

  const Menu({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${user.name}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Email: ${user.email}'),
          ],
        ),
      ),
    );
  }
}
