import 'package:get_storage/get_storage.dart';

class IntroFunctions {
  final String key = "LaunchStatus";
  Future<void> saveLaunchStatus({required bool status}) async {
    final GetStorage storage = GetStorage();
    await storage.write(key, status);
  }

  bool getLaunchStatus() {
    bool? status;
    final GetStorage storage = GetStorage();
    status = storage.read(key);
    return status ?? true;
  }


  bool isDark = false;
  final GetStorage themestatus = GetStorage();
  void inittheme() {

    bool? cacheTheme = themestatus.read('theme');
    isDark = cacheTheme ?? false;

  }

  bool get theme => isDark;

  set theme(bool value) {
    isDark = value;

    themestatus.write('theme', value);

  }
}
