import 'dart:convert';
import 'dart:io';

String convertToBase64(File file) {
  List<int> fileBytes = file.readAsBytesSync();
  String base64String = base64.encode(fileBytes);
  return base64String;
}

List<int> convertToImage(String base64String) {
  return base64.decode(
      base64String.contains(',') ? base64String.split(',')[1] : base64String);
}
