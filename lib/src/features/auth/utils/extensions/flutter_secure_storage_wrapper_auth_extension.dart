import 'package:five_on_4_mobile/src/features/auth/utils/constants/secure_storage_auth_key_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';

extension FlutterSecureStorageWrapperAuthExtension
    on FlutterSecureStorageWrapper {
  Future<(String, int)?> getAuthData() async {
    final token = await readKeyValue(
      key: SecureStorageAuthKeyConstants.TOKEN.value,
    );
    if (token == null) return null;

    final authIdString = await readKeyValue(
      key: SecureStorageAuthKeyConstants.AUTH_ID.value,
    );
    if (authIdString == null) return null;

    final authId = int.tryParse(authIdString);
    if (authId == null) return null;

    return (token, authId);
  }
}
