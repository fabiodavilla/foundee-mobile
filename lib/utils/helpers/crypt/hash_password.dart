import 'dart:convert';
import 'package:crypto/crypto.dart';

String hashPassword(String secret) {
  final List<int> bytes = utf8.encode(secret); // codifica a string em bytes
  final Digest hash = sha256.convert(bytes); // cria o hash SHA-256 dos bytes

  return hash.toString();
}
