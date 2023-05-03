
import '../../data/provider/shopping_list_provider.dart';

class ShoppingListRepository {

final ShoppingListProvider api;

ShoppingListRepository(this.api);

getAll(){
  return api.getAll();
}
getId(id){
  return api.getId(id);
}
delete(id){
  return api.delete(id);
}
edit(obj){
  return api.edit( obj );
}
add(obj){
    return api.add( obj );
}

}