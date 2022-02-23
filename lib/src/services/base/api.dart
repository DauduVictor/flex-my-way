class API {
  static const String scheme = 'https';
  static const host = 'e-ticketing.herokuapp.com';

  //Authentication
  Uri get registerUri => Uri(scheme: scheme, host: host, path: 'api/register');

 
}
