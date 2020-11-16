import 'package:flutter/material.dart';

import 'package:anonymous_chat/screens/settings/components/link.dart';
import 'package:anonymous_chat/screens/settings/components/alert_dialogue.dart';
import 'package:anonymous_chat/screens/change_password/change_password.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen(this._userData);

  final Map<String, dynamic> _userData;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final bool _isPortrait = _mediaQuery.orientation == Orientation.portrait;

    final PreferredSizeWidget appBar = AppBar(title: Text('Settings'));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: _isPortrait
              ? _mediaQuery.size.height -
                  appBar.preferredSize.height -
                  _mediaQuery.padding.top
              : null,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 15),
                alignment: Alignment.center,
                child: Icon(
                  Icons.account_circle,
                  size: 120,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              Text(
                _userData['name'],
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                _userData['email'],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Link(
                Icons.vpn_key_outlined,
                'Change Password',
                () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ChangePasswordScreen(),
                  ),
                ),
              ),
              Link(
                Icons.exit_to_app,
                'Logout',
                () => openDialogue(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
