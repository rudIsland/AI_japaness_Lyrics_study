import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceUtil {
  static const String _key = 'device_uid';

  /// 저장된 UID가 있으면 반환, 없으면 새로 생성해서 저장 후 반환
  static Future<String> getDeviceUid() async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(_key);
    if (uid == null) {
      uid = const Uuid().v4(); // 랜덤 고유 ID 생성
      await prefs.setString(_key, uid);
    }
    return uid;
  }
}
