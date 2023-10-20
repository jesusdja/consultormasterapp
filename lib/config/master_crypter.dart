import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;
import 'package:encrypt/encrypt.dart' as encrypt;

class MasterEncrypted{

  static const secretKey = 'G03awefbko';
  static const secretIV = 'AfHggGh78o03Rg0';

  String encryptPassword(String password) {

    final key = encrypt.Key.fromUtf8(generateKey(secretKey));
    final iv = encrypt.IV.fromUtf8(generateIV(secretIV));

    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(password, iv: iv);
    final base64Encrypted = base64.encode(utf8.encode(encrypted.base64));
    return base64Encrypted;
  }

  String generateKey(String secret) {
    var key = crypto.sha256.convert(utf8.encode(secret)).toString();
    return key.substring(0, 32); // Tomar los primeros 32 caracteres
  }
  String generateIV(String secret) {
    var iv = crypto.sha256.convert(utf8.encode(secret)).toString();
    return iv.substring(0, 16); // Tomar los primeros 16 caracteres
  }

}