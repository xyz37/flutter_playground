import 'dart:io';
import 'dart:convert';

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

void httpGetHandler(HttpRequest request) async {
  var path = request.uri.path;

  if (path == '/') {
    var content = 'Hello, Dart server world!';

    request.response
      ..headers.contentType = ContentType.text
      ..headers.contentLength = content.length
      ..statusCode = HttpStatus.ok
      ..write(content);
  } else if (path.contains('/add')) {
    var vars = path.split(',');
    var result = int.parse(vars[1]) + int.parse(vars[2]);
    var content = '${vars[1]} + ${vars[2]} = $result';

    request.response
      ..headers.contentType = ContentType.text
      ..headers.contentLength = content.length
      ..statusCode = HttpStatus.ok
      ..write(content);
  } else if (await File(path.substring(1)).exists()) {
    var file = File(path.substring(1));
    var content = await file.readAsString();

    request.response
      ..headers.contentType = ContentType.text
      ..headers.contentLength = content.length
      ..statusCode = HttpStatus.ok
      ..write(content);
  } else {
    var content = 'Unsupported URI';

    request.response
      ..headers.contentType = ContentType.text
      ..headers.contentLength = content.length
      ..statusCode = HttpStatus.notFound
      ..write(content);
  }

  await request.response.close();
}

void httpPutHandler(var addr, var port, HttpRequest request) async {
  var content = await utf8.decoder.bind(request).join();
  var file = await File(request.uri.path.substring(1)).openWrite();

  print('\> content        : $content');

  file
    ..write(content)
    ..close();

  content = 'http://$addr:$port${request.uri.path} created';

  request.response
    ..headers.contentType = ContentType.text
    ..headers.contentLength = content.length
    ..statusCode = HttpStatus.ok
    ..write(content);

  await request.response.close();
}

void httpPostHandler(HttpRequest request, HttpServer server) async {
  var content = await utf8.decoder.bind(request).join();
  var product = content.split('=');

  print('\> content        : $content');

  content = "Product '${product[1]}' accepted";

  request.response
    ..headers.contentType = ContentType.text
    ..headers.contentLength = content.length
    ..statusCode = HttpStatus.ok
    ..write(content);

  await request.response.close();
}

void httpDeleteHandler(HttpRequest request) async {
  var filename = request.uri.path.substring(1);

  if (await File(filename).exists()) {
    var content = '$filename deleted';

    File(filename).deleteSync();

    request.response
      ..headers.contentType = ContentType.text
      ..headers.contentLength = content.length
      ..statusCode = HttpStatus.ok
      ..write(content);
  } else {
    var content = '$filename not found';

    request.response
      ..headers.contentType = ContentType.text
      ..headers.contentLength = content.length
      ..statusCode = HttpStatus.notFound
      ..write(content);
  }

  await request.response.close();
}

void httpJsonHandler(HttpRequest request) async {
  var content = await utf8.decoder.bind(request).join();
  var jsonData = jsonDecode(content) as Map;

  print('\> content        : $jsonData');

  for (var entry in jsonData.entries) {
    print("\$ jsonData['${entry.key}] is ${entry.value}");
  }

  content = 'POST JSON accepted';
  request.response
    ..headers.contentType = ContentType.json
    ..headers.contentLength = content.length
    ..statusCode = HttpStatus.ok
    ..write(content);

  await request.response.close();
}

Future main() async {
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    4040,
  );

  printHttpServerActivated(server);

  await for (HttpRequest request in server) {
    printHttpReqeustInfo(request);

    try {
      switch (request.method) {
        case 'GET':
          //***********************************************/
          // start of chapter 4. JSON
          if (request.headers.contentType == ContentType.json) {
            httpJsonHandler(request);

            break;
          }
          // end of chapter 4. JSON
          //***********************************************/

          httpGetHandler(request);
        case 'PUT':
          httpPutHandler(server.address.address, server.port, request);
        case 'POST':
          httpPostHandler(request, server);
        case 'DELETE':
          httpDeleteHandler(request);
        case 'PATCH':
          closeServer(server);
          exit(0);
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
