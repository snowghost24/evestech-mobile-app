abstract class Constants {
  static const String companyName = 'Evestech';
// ignore: constant_identifier_names
  static const String BASE_URL = 'https://jose.evestech.com';

  // ignore: constant_identifier_names
  static const String API_ROOT = '$BASE_URL/api';

// ignore: constant_identifier_names
  static const String forgotPassword = '$BASE_URL/#/login';

  static const Map<String, String> termsOfService = {
    'title': 'Terms of Service',
    'url': 'https://getecio.com/terms-of-service',
  };

  static const Map<String, String> privacyPolicy = {
    'title': 'Privacy Policy',
    'url': 'https://getecio.com/privacy-policy',
  };

  static const String userToken = String.fromEnvironment(
    'TOKEN',
    defaultValue: '',
  );

  static const String myEcioGoogleClientId = String.fromEnvironment(
    'MYECIO_GOOGLE_CLIENT_ID',
    defaultValue: '',
  );
}

  // final IO.Socket socket = IO.io(
  //       'https://jose.evestech.com',
  //       OptionBuilder()
  //           .setTransports([
  //             'websocket'
  //           ]) // for Flutter or Dart VM // disable auto-connection
  //           // .setQuery({
  //           //   'token':
  //           //       'eyJhbGciOiJSUzI1NiIsImtpZCI6IjE2ZGE4NmU4MWJkNTllMGE4Y2YzNTgwNTJiYjUzYjUzYjE4MzA3NzMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZmx1dHRlci10ZXN0LTcwY2I4IiwiYXVkIjoiZmx1dHRlci10ZXN0LTcwY2I4IiwiYXV0aF90aW1lIjoxNjgyMDE2Njg1LCJ1c2VyX2lkIjoiakZhdW9qQXVpamdoU0RvM0o1NGI3dTVNWTF6MSIsInN1YiI6ImpGYXVvakF1aWpnaFNEbzNKNTRiN3U1TVkxejEiLCJpYXQiOjE2ODIwMTY2ODUsImV4cCI6MTY4MjAyMDI4NSwiZW1haWwiOiJsb2xAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbImxvbEBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.PLl_bmTfsQlM2Tzh-vEgG5q2dLVTP9cuGkvDf1ZNu-boZD9HVtxUK9sfy5QH_AZnym2r9RKNbzimAeoBZLsz3T9aAgp8fK8j_czvsr0GAuwGMSPe1aUQF5JZ4754nUUbMEF_GJ2ZK1R23BlfRcJtcpGSNFxpf7wLZVkzoSvHQNhs-tzo14syQquia0YXRUT-3-ycwe8Ud-myoR6dx9kY9Qrha1AdWvVq5HmsUyrL5k48hKEdLnhDHoZqAJm1X5FsApPcQf6nGsE-ySy9dmIMZpLmFAUIZUiYMMH-mp_8NSsItnFHdPjiRTIoUXqRwsJdvTVVPi1Ca4LOSm514acdHw'
  //           // })
  //           .setPath('/api/realtime/ws') // optional
  //           .build());