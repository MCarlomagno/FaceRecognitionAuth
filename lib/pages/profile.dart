import 'package:flutter/material.dart';

import 'home.dart';

class Profile extends StatelessWidget {
  const Profile({Key key, @required this.username}) : super(key: key);

  final String username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome back, ' + username + '!'),
        leading: Container(),
      ),
      body: Container(
        child: Column(
          children: [
            Text('This is your super amazing profile'),
            RaisedButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage()
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
