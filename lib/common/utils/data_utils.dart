import 'dart:convert';

import 'package:delivery_app/common/const/data/data.dart';

class DataUtils {

  static String pathToURL(String path) {
    return '$DOMAIN$path';
  }

  static String toBasic64(String str) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(str);

    return encoded;
  }

  static List<String> pathToURLForList(List list) {

    return list.map((e) => pathToURL(e)).toList();
  }
}