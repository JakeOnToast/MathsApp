import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  // If the UUID does not match the current authenticated user when attempting
  // to upload to firebase, the user will not be allowed to upload the data.
  @HiveField(0)
  String _uuid = "";

  @HiveField(1)
  String _username = "";

  bool pendingUploadReward = false;

  UserCredential? signedInUser;

  String get uuid => _uuid;
  String get username => _username;

  bool get canUserUpload {
    // user must be signed in and be using the same account as last time
    // if the _uuid is "" then they haven't uploaded or downloaded before
    return _uuid == "" || (signedInUser != null && _uuid == signedInUser!.user!.uid);
  }

  set uuid(String uuid) {
    // The UUID will only get set when data is loaded from firebase
    _uuid = uuid;
    save();
  }

  set username(String username) {
    _username = username;
    save();
  }
}
