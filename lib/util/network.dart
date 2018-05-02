import 'dart:async';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the UTF8.encode method
import 'package:http/http.dart' as http;

class Network {
  static const BASE_URL = "https://api.fptplay.net";
  static const PATH_GET_IP = "/api/getip";

  static Future<http.Response> loadData(
      String userAgent, String st, String e) async {
    String dataURL = BASE_URL;
    getCurrentTimeStamp();
//    encodeParams(PATH_GET_IP,1525249040);

    http.Response response = await http.get(dataURL, headers: {
      "X-VID": "a5796a4b-40dc-3099-b87f-fa5d6a1a1ae0",
//      "User-Agent": http.BaseClient().,
      "Content-Type": "application/json",
      "X-DID": "ba93adb01b1d636",
      "X-VTYPE": "WEB_ANDROID",
      "st": st,
      "e": e,
    });
//    setState(() {
//      _members = JSON.decode(response.body);
    return response;
  }

  static Future<http.Response> getIP() async{
    return getResponseWithHeader(PATH_GET_IP);
  }

  static  Future<http.Response> getResponseWithHeader(String path,) async {
    var dataURL = BASE_URL + path;
    var e = getCurrentTimeStamp().toString();
    var st = encodeParams(path, e);
    dataURL+="?e=$e&st=$st";
    http.Response response = await http.get(dataURL, headers: {
      "X-VID": "a5796a4b-40dc-3099-b87f-fa5d6a1a1ae0",
//      "User-Agent": "Mozilla/5.0 (compatible; MSIE 10.0; android-phone(version:6.0.1,model:MI 4LTE); Trident/6.0; IEMobile/10.0; ARM; Touch; XiaomiMI 4LTE)",
      "Content-Type": "application/json",
      "X-DID": "ba93adb01b1d636",
      "X-VTYPE": "WEB_ANDROID",
      "st": st,
      "e": e,
    });
    return response;
  }


  static int getCurrentTimeStamp() {
    int currentMiliSecond = new DateTime.now().microsecondsSinceEpoch;
    return (currentMiliSecond / 1000).toInt() + 14400;
  }

  static String encodeParams(String path, String currentTimeStamp) {
    String secretString = "IPGETsMQsiis9Uvv0sAopdls03H$currentTimeStamp$path";
    var messageDigest = md5.convert(UTF8.encode(secretString));
    var st = base64.encode(messageDigest.bytes).replaceAll("==", "");
    return st;
  }
}
