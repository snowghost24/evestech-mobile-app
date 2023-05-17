import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/device_info.dart';
import '../providers/auth.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    Auth authContext = Provider.of<Auth>(context);
    return Consumer<DeviceInfo>(builder: (_, deviceData, child) {
      return SizedBox(
        //  margin: EdgeInsets.all(5),
        width: double.infinity,
        child: OutlinedButton.icon(
          icon: const FaIcon(FontAwesomeIcons.google),
          label: const Text(
            "Sign in with Google",
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            authContext.googleAuthenticate(deviceData.hash as String);
          },
          // child: const Text('SIGN IN'),
        ),
      );
    });
  }
}
