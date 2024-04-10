import 'dart:convert';
import 'dart:io';

Future main() async {
  var serverIp = InternetAddress.loopbackIPv4.address;
  var serverPort = 4040;
  var httpClient = HttpClient();
  var serverPath = '';

  //***********************************************/
  // start of chapter 4. JSON
  print('|-> POST JSON Format');
  var jsonContent = {'Korea': 'Seoul', 'Japan': 'Tokyo', 'China': 'Beijing'};
  var content = jsonEncode(jsonContent);

  serverPath = '/';
  var httpRequest = await httpClient.get(serverIp, serverPort, serverPath)
    ..headers.contentType = ContentType.json
    ..headers.contentLength = content.length
    ..write(content);
  var httpResponse = await httpRequest.close();
  var httpResponseContent = await utf8.decoder.bind(httpResponse).join();

  printHttpContentInfo(httpResponse, httpResponseContent);
  // end of chapter 4. JSON
  //***********************************************/

  print('|-> [step.1] GET /');
  serverPath = '';
  httpRequest = await httpClient.get(serverIp, serverPort, serverPath);
  httpResponse = await httpRequest.close();
  httpResponseContent = await utf8.decoder.bind(httpResponse).join();

  printHttpContentInfo(httpResponse, httpResponseContent);

  print('|-> [step.2] GET /add,3,6');
  serverPath = '/add,3,6';
  httpRequest = await httpClient.get(serverIp, serverPort, serverPath);
  httpResponse = await httpRequest.close();
  httpResponseContent = await utf8.decoder.bind(httpResponse).join();

  printHttpContentInfo(httpResponse, httpResponseContent);

  print('|-> [step.3] GET /sample.txt');
  serverPath = '/sample.txt';
  httpRequest = await httpClient.get(serverIp, serverPort, serverPath);
  httpResponse = await httpRequest.close();
  httpResponseContent = await utf8.decoder.bind(httpResponse).join();

  printHttpContentInfo(httpResponse, httpResponseContent);

  print('|-> [step.4] POST item=product#1234');
  var httpContent = 'item=product#1234';
  serverPath = '/';
  httpRequest = await httpClient.post(serverIp, serverPort, serverPath)
    ..headers.contentType = ContentType.text
    // ..headers.contentLength = httpContent.length // 생략 가능
    ..write(httpContent);

  httpResponse = await httpRequest.close();
  httpResponseContent = await utf8.decoder.bind(httpResponse).join();

  printHttpContentInfo(httpResponse, httpResponseContent);

  print('|-> [step.5] PUT /timestamp.txt');
  httpContent = 'created at ${DateTime.now()}';
  serverPath = '/timestamp.txt';
  httpRequest = await httpClient.put(serverIp, serverPort, serverPath)
    ..headers.contentType = ContentType.text
    ..headers.contentLength = httpContent.length
    ..write(httpContent);

  httpResponse = await httpRequest.close();
  httpResponseContent = await utf8.decoder.bind(httpResponse).join();

  printHttpContentInfo(httpResponse, httpResponseContent);

  print('|-> [step.6] DELETE /timestamp.txt');
  serverPath = '/timestamp.txt';
  httpRequest = await httpClient.delete(serverIp, serverPort, serverPath);
  httpResponse = await httpRequest.close();
  httpResponseContent = await utf8.decoder.bind(httpResponse).join();

  printHttpContentInfo(httpResponse, httpResponseContent);

  print('|-> [step.7] POST (remote server close)');
  httpContent = 'close';
  httpRequest = await httpClient.patch(serverIp, serverPort, serverPath)
    ..headers.contentType = ContentType.text
    ..write(httpContent);
  // httpResponse = await httpRequest.close();
  httpResponseContent = 'remote server closed';

  printHttpContentInfo(httpResponse, httpResponseContent);
}

void printHttpContentInfo(
    HttpClientResponse httpResponse, httpResponseContent) {
  print('|<- status-code     : ${httpResponse.statusCode}');
  print('|<- content-type    : ${httpResponse.headers.contentType}');
  print('|<- content-length  : ${httpResponse.contentLength}');
  print('|<- content         : ${httpResponseContent}');
}
