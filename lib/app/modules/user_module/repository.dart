
import '../../data/model/user.dart';
import '../../data/provider/user_provider.dart';

class UserRepository {
  final UserProvider api;

  UserRepository(this.api);

  Future<UserModel> getUser(String uid) {
    return api.getUser(uid);
  }

  Future<List<UserModel>> getAll() async {
    List<UserModel> listUsers = <UserModel>[];
    listUsers = await api.getAll();
    return listUsers;
  }

  Future<void> assignShoppingList(String uid, String shoppingListId) {
    return api.assignShoppingList(uid, shoppingListId);
  }

  Future<void> deAssignShoppingList(String uid, String shoppingListId) {
    return api.deAssignShoppingList(uid, shoppingListId);
  }

  addFcmToken(uid, String token) {
    return api.addFcmToken(uid, token);
  }
}