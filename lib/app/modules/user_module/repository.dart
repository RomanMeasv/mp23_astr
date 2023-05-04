
import '../../data/model/user.dart';
import '../../data/provider/user_provider.dart';

class UserRepository {
  final UserProvider api;

  UserRepository(this.api);

  Future<UserModel> getUser(String uid) {
    return api.getUser(uid);
  }
}