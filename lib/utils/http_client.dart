import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:dio/dio.dart';

Dio dio = Dio();

const String customBrowserAgent = 'V2flex/1.0';

const String iOSUserAgent =
    'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1 $customBrowserAgent';

const String androidUserAgent =
    'Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.122 Mobile Safari/537.36 $customBrowserAgent';

void initDio() {
  dio.options.baseUrl =
      kReleaseMode ? 'https://www.v2ex.com' : 'http://127.0.0.1:7001';
  dio.options.headers = {
    HttpHeaders.userAgentHeader:
        Platform.isAndroid ? androidUserAgent : iOSUserAgent,
  };
}
