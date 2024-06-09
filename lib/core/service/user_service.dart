

import 'package:project_train/core/manager/user_manager.dart';
import 'package:project_train/core/model/user_model.dart';

class UserService {
  HiveCacheManager<UserModel> manager = UserManager('users');
  static final UserService instance = UserService._privateConstructor();
  UserModel? currentUser;

  bool _isInitialized = false;

  factory UserService() {
    return instance;
  }

  Future<void> ensureInitialized() async {
    await manager.init();
    _isInitialized = true;
    await getUser();
  }

  UserService._privateConstructor();

  Future<void> getUser() async {
    if (!_isInitialized) {
      return;
    }

    List<UserModel>? userList = manager.getValues();
    if (userList != null && userList.isNotEmpty) {
      currentUser = userList[0];
    }
  }

  Future<void> setUser(UserModel user) async {
    List<UserModel> items = <UserModel>[user];
    manager.addItems(items);
    await getUser();
  }

  Future<void> singOut() async {
    manager.clearAll();
    currentUser = null;
  }
}