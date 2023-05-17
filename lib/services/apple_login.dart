// Needed because we can't import `dart:html` into a mobile app,
// while on the flip-side access to `dart:io` throws at runtime (hence the `kIsWeb` check below)
// import 'html_shim.dart' if (dart.library.html) 'dart:html' show window;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../models/device_info.dart';
import '../providers/auth.dart';

class AppleLogin extends StatefulWidget {
  const AppleLogin({Key? key}) : super(key: key);

  @override
  State<AppleLogin> createState() => _AppleLoginState();
}

class _AppleLoginState extends State<AppleLogin> {
  @override
  Widget build(BuildContext context) {
    Auth authContext = Provider.of<Auth>(context);
    return Consumer<DeviceInfo>(builder: (_, deviceInfo, child) {
      return SignInWithAppleButton(
        onPressed: () async {
          try {
            await authContext.appleAuthenticate(deviceInfo.hash as String);
          } catch (e) {
            print("unable to authenticate");
          }
        },
      );
    });
  }
}
