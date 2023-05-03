import 'package:get/get_connect/connect.dart';
import 'package:mp23_astr/app/data/model/item.dart';

const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class ItemProvider extends GetConnect {
  getAll() {}

  getId(id) {}

  edit(obj) {}

  add(obj) {}

  // Get request
  Future<Response> getUser(int id) => get('http://youapi/users/id');
// Post request
  Future<Response> postUser(Map data) => post('http://youapi/users', data);
// Post request with File
  Future<Response<ItemModel>> postCases(List<int> image) {
    final form = FormData({
      'file': MultipartFile(image, filename: 'avatar.png'),
      'otherFile': MultipartFile(image, filename: 'cover.png'),
    });
    return post('http://youapi/users/upload', form);
  }

  GetSocket userMessages() {
    return socket('https://yourapi/users/socket');
  }
}
