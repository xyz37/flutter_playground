import 'dart:convert';
import 'dart:io';

Future main() async {
  var host = InternetAddress.loopbackIPv4.address;
  var port = 4040;
  var path = '';

  var httpClient = HttpClient();

  var jsonContent = {};
  const api = '/api';
  var key = '00001';

  print('-> [step.1] Create by POST: Seoul');
  jsonContent = {key: 'Seoul'};
  path = '$api/$key';
  var httpRequest = await httpClient.post(host, port, path);
  requestAction(jsonContent, path, httpRequest);

  print('-> [step.2] Create by POST: Busan');
  key = '00002';
  jsonContent = {key: 'Busan'};
  path = '$api/$key';
  httpRequest = await httpClient.post(host, port, path);
  requestAction(jsonContent, path, httpRequest);

  print('-> [step.3] Read by GET');
  key = '00001';
  path = '$api/$key';
  httpRequest = await httpClient.get(host, port, path);
  requestNoCloseAction(httpRequest);

  print('-> [step.4] Update by PUT');
  key = '00001';
  jsonContent = {key: 'JeonJu'};
  path = '$api/$key';
  httpRequest = await httpClient.put(host, port, path);
  requestAction(jsonContent, path, httpRequest);

  print('-> [step.5] Delete by DELETE');
  key = '00001';
  path = '$api/$key';
  httpRequest = await httpClient.delete(host, port, path);
  requestNoCloseAction(httpRequest);

  print('-> [step.6] Unsupported API: GET ERROR');
  key = '00001';
  path = '${api}x/$key';
  httpRequest = await httpClient.delete(host, port, path);
  requestNoCloseAction(httpRequest);

  print('-> [step.7] Unsupported Read (deleted key)');
  key = '00001';
  path = '$api/$key';
  httpRequest = await httpClient.get(host, port, path);
  requestNoCloseAction(httpRequest);
}

void requestNoCloseAction(HttpClientRequest httpRequest) async {
  var httpResponse = await httpRequest.close();
  var httpResponseContent = await utf8.decoder.bind(httpResponse).join();

  printHttpContentInfo(httpResponse, httpResponseContent);
}

void requestAction(Map<dynamic, dynamic> jsonContent, String path,
    HttpClientRequest httpRequest) async {
  var content = jsonEncode(jsonContent);

  httpRequest
    ..headers.contentType = ContentType.json
    ..headers.contentLength = content.length
    ..write(content);

  var httpResponse = await httpRequest.close();
  var httpResponseContent = utf8.decoder.bind(httpResponse).join();

  printHttpContentInfo(httpResponse, httpResponseContent);
}

void printHttpContentInfo(
    HttpClientResponse httpResponse, httpResponseContent) {
  print('|<- status-code     : ${httpResponse.statusCode}');
  print('|<- content-type    : ${httpResponse.headers.contentType}');
  print('|<- content-length  : ${httpResponse.contentLength}');
  print('|<- content         : ${httpResponseContent}');
  print('');
}
