import 'dart:io';

Future main() async {
  var ip = InternetAddress.loopbackIPv4;
  var port = 4040;
  var server = await HttpServer.bind(
    ip,
    port,
  );

  print('\$ server activated - ${server.address.address}:${server.port}');

  await for (HttpRequest request in server) {
    try {
      print('\$ http request for ${request.uri.path} at (${DateTime.now()}).');

      if (request.uri.path == '/') {
        print("\$ http response is 'Hello, World!.'");
        print("\$ send '200 ok'.");

        request.response
          ..statusCode = HttpStatus.ok
          ..write('Hello, World!');
      } else if (request.uri.path.contains('/add')) {
        print("\$ http response is result of 'add' operation.");
        print("\$ send '200 ok'.");

        var varList = request.uri.path.split(',');
        var result = int.parse(varList[1]) + int.parse(varList[2]);

        request.response
          ..statusCode = HttpStatus.ok
          ..write("${varList[1]} + ${varList[2]} = $result");
      } else if (await File(request.uri.path.substring(1)).exists()) {
        // 서버가 시작된 프로젝트의 root
        // d_client_server/sample.txt 에 두면 찾지 못한다.
        print("\$ http response is '${request.uri.path}' file transfer.");
        print("\$ send '200 ok'.");

        var file = File(request.uri.path.substring(1));
        var fileContent = await file.readAsString();

        request.response
          ..statusCode = HttpStatus.ok
          ..headers.contentType = ContentType('text', 'plain', charset: 'utf-8')
          ..write(fileContent);
      } else {
        print("\$ unsupported uri.");
        print("\$ send '404 not-found'.");

        request.response
          ..statusCode = HttpStatus.notFound
          ..write('Unsupported URI.');
      }

      await request.response.close();
    } catch (err) {
      print('\$ exception in http request processing.');
    }
  }
}
