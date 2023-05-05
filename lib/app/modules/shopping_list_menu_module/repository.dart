
import 'package:mp23_astr/app/data/provider/shopping_list_menu_provider.dart';

class ShoppingListMenuRepository {

final ShoppingListMenuProvider shoppingListMenuProvider;

ShoppingListMenuRepository(this.shoppingListMenuProvider);

getAll(){
  return shoppingListMenuProvider.getAll();
}
getId(id){
  return shoppingListMenuProvider.getId(id);
}
delete(id){
  return shoppingListMenuProvider.delete(id);
}
edit(obj){
  return shoppingListMenuProvider.edit( obj );
}
add(obj){
    return shoppingListMenuProvider.add( obj );
}

}