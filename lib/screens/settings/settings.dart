import 'package:flutter/material.dart';

import 'package:anonymous_chat/models/user.dart';
import 'package:anonymous_chat/screens/settings/components/link.dart';
import 'package:anonymous_chat/screens/settings/components/alert_dialogue.dart';
import 'package:anonymous_chat/screens/change_password/change_password.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen(this.userData);

  final UserM userData;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isPortrait = mediaQuery.orientation == Orientation.portrait;

    final PreferredSizeWidget appBar = AppBar(title: Text('Settings'));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: SizedBox(
          height: isPortrait
              ? mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top
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
              const SizedBox(height: 8),
              Text(
                userData.name,
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                userData.email,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
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
