import 'dart:io';
import 'dart:convert';

// https://api.dart.dev/stable/3.3.0/dart-io/HttpRequest-class.html

// Fetch data from the internet
// https://dart.dev/tutorials/server/fetch-data
void printHttpServerActivated(HttpServer server) {
  var ip = server.address.address;
  var port = server.port;

  print('\$ Server activated in $ip:$port');
}

void printHttpReqeustInfo(HttpRequest request) async {
  var ip = request.connectionInfo!.remoteAddress.address;
  var port = request.connectionInfo!.remotePort;
  var method = request.method;
  var path = request.uri.path;

  print('\$ $method $path from $ip:$port');

  if (request.headers.contentLength != -1) {
    print('\> content-type   : ${request.headers.contentType}');
    print('\> content-length : ${request.headers.contentLength}');
  }
}

void printAndSendHttpResponse(
    Map<dynamic, dynamic> db, HttpRequest request, String content) async {
  print('\r\n\$ $content  \n   current DB    : $db');

  request.response
    ..headers.contentType = ContentType.json
    ..headers.contentLength = content.length
    ..statusCode = HttpStatus.ok
    ..write(content);
  await request.response.close();
}

void createDB(Map<dynamic, dynamic> db, HttpRequest request) async {
  var content = await utf8.decoder.bind(request).join();
  var transaction = jsonDecode(content) as Map;
  var key, value;

  print('\> content        : $content');

  transaction.forEach((k, v) {
    key = k;
    value = v;
  });

  if (db.containsKey(key) == false) {
    db[key] = value;
    content = 'Success < $transaction created >';
  } else {
    content = 'Fail < $key already exist >';
  }

  printAndSendHttpResponse(db, request, content);
}

void readDB(Map<dynamic, dynamic> db, HttpRequest request) async {
  var key = request.uri.pathSegments.last;
  var content = '';
  var transaction = {};

  if (db.containsKey(key) == false) {
    content = 'Fail < $key not-exist >';
  } else {
    transaction[key] = db[key];
    content = 'Success < $transaction retrieved >';
  }

  printAndSendHttpResponse(db, request, content);
}

void updateDB(Map<dynamic, dynamic> db, HttpRequest request) async {
  var content = await utf8.decoder.bind(request).join();
  var transaction = jsonDecode(content) as Map;
  var key, value;

  print('\> content        : $content');

  transaction.forEach((k, v) {
    key = k;
    value = v;
  });

  if (db.containsKey(key)) {
    db[key] = value;
    content = 'Success < $transaction updated >';
  } else {
    content = 'Fail < $key already exist >';
  }

  printAndSendHttpResponse(db, request, content);
}

void deleteDB(Map<dynamic, dynamic> db, HttpRequest request) async {
  var key = request.uri.pathSegments.last;
  var content, value;

  if (db.containsKey(key) == false) {
    content = 'Fail < $key not-exist >';
  } else {
    value = db[key];
    db.remove(key);
    content = 'Success < $key:$value delete >';
  }

  printAndSendHttpResponse(db, request, content);
}

Future main() async {
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    4040,
  );
  var db = {};

  printHttpServerActivated(server);

  await for (HttpRequest request in server) {
    if (request.uri.path.contains('/api/') == false) {
      printAndSendHttpResponse(
          db, request, '${request.method} {ERROR: Unsupported API}');

      continue;
    }

    printHttpReqeustInfo(request);

    try {
      switch (request.method) {
        case 'POST': // Create
          createDB(db, request);
        case 'GET': // Read
          readDB(db, request);
        case 'PUT': // Update
          updateDB(db, request);
        case 'DELETE': // Delete
          deleteDB(db, request);
        default:
          print('Unsupported http method');
      }
    } catch (err) {
      print('\$ Exception in http request processing...\r\n$err');
    }
  }
}

void closeServer(HttpServer server) {
  server.close();
}
