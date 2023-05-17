import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';

import '../constants.dart';
import '../services/helpers.dart';

class TermsPolicy extends StatelessWidget {
  static const routeName = '/terms-policy';
  const TermsPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      // height: 60,
      // width: 300,
      margin: const EdgeInsets.symmetric(vertical:10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).colorScheme.onPrimary),
      child: Consumer<Helpers>(builder: (ctx, helpers, _) {
        // print(helpers);
        return Container(
          alignment: Alignment.center,
          // padding: const EdgeInsets.all(10),
          child: Center(
              child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      text: 'By continuing, you agree to our ',
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Terms of Service',
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              helpers.launchURL(
                                  Constants.termsOfService['url'] as String);
                            },
                        ),
                        TextSpan(
                            text: ' and ',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Privacy Policy',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    helpers.launchURL(Constants
                                        .privacyPolicy['url'] as String);
                                  },
                              )
                            ])
                      ]))),
        );
      }),
    );
  }
}
