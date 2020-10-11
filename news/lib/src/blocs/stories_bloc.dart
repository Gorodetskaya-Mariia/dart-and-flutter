import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository(); //1
  final _topIds = PublishSubject<List<int>>(); //as a StreamController 2
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  //Getters to streams
  Stream<List<int>> get topIds => _topIds.stream; //3
  Stream<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  //Getters to Sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;

//method allows to get info from repositiry (1), added to a stream controller (2) and topIds are avelaible outside the world through use of topIds getter (3)

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  clearCache() {
    return _repository.clearCache();
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, index) {
        cache[id] = _repository.fetchItem(id);
        print(index);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}
