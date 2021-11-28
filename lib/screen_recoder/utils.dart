import 'dart:developer';

class Url {
  Url({
    this.protocol = Protocol.http,
    this.username,
    this.password,
    this.hostname = 'localhost',
    this.port,
    this.pathname,
    this.search,
  });

  final Protocol protocol;
  final String? username;
  final String? password;
  final String hostname;
  final int? port;
  final String? pathname;
  final String? search;

  // TODO: suppport for [username] and [password]
  String buildURL() {
    return Uri(
      scheme: protocol.value,
      // userInfo: '$username:$password',
      host: hostname,
      port: port,
      path: pathname,
      query: search,
    ).toString();
  }
}

// main() {
//   log(Url(hostname: '127').buildURL());
// }

// abstract class Protocol {
//   static const String http = 'http';
//   static const String https = 'https';
// }

enum Protocol { http, https }

extension Protocal on Protocol {
  String get value {
    switch (this) {
      case Protocol.http:
        return 'http';
      case Protocol.https:
        return 'https';
      default:
        return '';
    }
  }
}

var url = Url();
