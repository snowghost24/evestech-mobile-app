import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:convert';

import '../constants.dart';
// import '../models/device_info.dart';
import '../models/api_client.dart';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expireDate;
  String? _userId;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    // if the token exists and its still valid
    if (_token != null && !JwtDecoder.isExpired(_token as String)) {
      return _token;
    }
    return null;
  }

  Future<void> handleTokenResponse(String returnedToken) async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(returnedToken);
    _token = returnedToken;
    _userId = decodedToken['_id'];

    if (decodedToken['exp'] != null) {
      _expireDate = DateTime.now()
          .add(Duration(seconds: int.parse(decodedToken['exp'].toString())));
    }
    // automatically log the user out when the time has passed
    _autoLogout();
    //store auth date in device
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode(
      {
        'TOKEN': _token,
        'userId': _userId,
        'expireDate': _expireDate!.toIso8601String(),
      },
    );
    prefs.setString('userData', userData);
  }

  Future<void> emaiPasswordAuthenticate(
      String email, String password, String deviceHash) async {
    try {
      var response = await ApiClient.user.authenticate(
          {'email': email, 'password': password, 'deviceHash': deviceHash});

      await handleTokenResponse(response.body);

      notifyListeners();
    } catch (error) {
      print(error.toString());
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email already exists';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This email is invalid';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find user with this email ';
      } else if (error.toString().contains('Invalid password')) {
        errorMessage = 'Invalid password ';
      }
      throw HttpException(errorMessage);
    }
  }

  Future<void> googleAuthenticate(String devieHash) async {
    try {
      /// The scopes required by this application.
      const List<String> scopes = <String>[
        'email',
      ];

      GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: Constants.myEcioGoogleClientId.toString(),
        scopes: scopes,
      );

      final GoogleSignInAccount? googleUser =
          await googleSignIn.signIn().catchError((onError) {
        //do nothing this is just here
        // to catch the cancel exception
      });
      // If the user cancels an error will be throw
      // that error will not be caught if its
      // running on debug mode
      if (googleUser != null) {
        final GoogleSignInAuthentication gAuth =
            await googleUser.authentication;
        var response = await ApiClient.user.authenticateWithGoogle(
            {'tokenId': gAuth.idToken, 'deviceHash': devieHash});
        await handleTokenResponse(response.body);
        notifyListeners();
      }
    } catch (error) {
      developer.log("Something went wrong!", error: error);

      var errorMessage = 'Authentication failed';
      if (error.toString().contains('Invalid email address')) {
        errorMessage = error.toString();
      }
      throw HttpException(errorMessage);
    }
  }

  Future<void> appleAuthenticate(String devieHash) async {
    try {
      /// The scopes required by this application.
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      var response = await ApiClient.user.authenticateUserFromApple(
          {'tokenId': credential.identityToken, 'deviceHash': devieHash});
      await handleTokenResponse(response.body);
      notifyListeners();
    } catch (error) {
      print(error);
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('Invalid email address')) {
        errorMessage = error.toString();
      }
      throw HttpException(errorMessage);
    }
  }

  Future<bool> tryAutoLogin() async {
    print("trying auto login");
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData = json.decode(prefs.getString('userData') as String)
        as Map<String, dynamic>;

    DateTime expiryDate;
    if (extractedUserData['expireDate'] == null) {
      return false;
      // expires int he future;
    } else {
      expiryDate = DateTime.parse(extractedUserData['expireDate']);
    }

    if (JwtDecoder.isExpired(extractedUserData['TOKEN'])) {
      return false;
    }
    _expireDate = expiryDate;
    _token = extractedUserData['TOKEN'] as String;
    // developer.log(_token);
    _userId = extractedUserData['userId'] as String;

    // sets up the auto logout
    _autoLogout();
    notifyListeners();
    return true;
  }

  Future<void> signup(String email, String password, String deviceHash) async {
    // return authenticate(email, password, deviceHash, 'signUp');
  }

  Future<void> login(String email, String password, String deviceHash) async {
    // return authenticate(email, password, deviceHash, 'signInWithPassword');
  }

  void logout() async {
    _token = null;
    _expireDate = null;
    _userId = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    if (_authTimer != null) {
      // cancels the old timer before creating a new one
      _authTimer?.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      // cancels the old timer before creating a new one
      _authTimer?.cancel();
    }

    int secondsToExpire =
        _expireDate?.difference(DateTime.now()).inSeconds as int;
    print("loggin user out");
    _authTimer = Timer(Duration(seconds: secondsToExpire), logout);
  }
}
