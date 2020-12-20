import 'dart:io';

class PlatformUtils {

  static bool isWebPlatform() {
    bool isWeb;
    try{
      if(Platform.isAndroid||Platform.isIOS) {
        isWeb=false;
      } else {
        isWeb=true;
      }
    } catch(e){
      isWeb=true;
    }

    return isWeb;
  }



}