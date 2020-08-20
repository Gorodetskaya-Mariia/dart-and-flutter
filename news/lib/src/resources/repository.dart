import "dart:async";
import "news_db_provider.dart";
import "news_api_provider.dart";
import "../models/item_model.dart";

class Repository {
  NewsDbProvider dbProvider =
      NewsDbProvider(); //creating instance of NewsDbProvider
  NewsApiProvider apiProvider =
      NewsApiProvider(); //creating instance of NewsApiProvider

  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    var item = await dbProvider.fetchItem(id);
    if (item != null) {
      return item;
    }

    item = await apiProvider.fetchItem(id);
    dbProvider.addItem(item);

    return item;
  }
}
