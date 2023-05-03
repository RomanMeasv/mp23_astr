import 'dart:io' show Platform;

class PlatformHelper {
  static bool isMobile = Platform.isAndroid || Platform.isIOS;
}
