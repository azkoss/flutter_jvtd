import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:simple_rc4/simple_rc4.dart';

/// 生成md5
String jvtdMd5(String value) {
  return hex.encode(md5.convert(utf8.encode(value)).bytes);
}

/// 生成sha1
String jvtdSha1(String value) {
  return hex.encode(sha1.convert(utf8.encode(value)).bytes);
}

/// rc4加密
///
/// value 加密字符串
/// key 秘钥
/// base64 是否base64
String jvtdRc4Encode(String value, {String key, bool base64 = true}) {
  if (key == null || key.isEmpty) {
    key = jvtdMd5('jvtd');
  }
  RC4 rc4 = RC4(key);
  return rc4.encodeString(value, base64);
}

/// rc4解密
///
/// value 解密字符串
/// key 秘钥
/// base64 是否base64
String jvtdRc4Decode(String value, {String key, bool base64 = true}) {
  if (key == null || key.isEmpty) {
    key = jvtdMd5('jvtd');
  }
  RC4 rc4 = RC4(key);
  return rc4.decodeString(value, base64);
}

/// utf8加密，主要用于fluro跳转传中文异常问题
///
/// value 加密字符串
/// key 秘钥
String jvtdUtf8Encode(String value, {String key}) {
  return jvtdRc4Encode(value, key: key).replaceAll('/', '*').replaceAll('+', '-');
}

/// utf8解密，主要用于fluro跳转传中文异常问题
///
/// value 加密字符串
/// key 秘钥
String jvtdUtf8Decode(String value, {String key}) {
  return jvtdRc4Decode(value, key: key).replaceAll('*', '/').replaceAll('-', '+');
}
