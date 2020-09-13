import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository(); //1
  final _topIds = PublishSubject<List<int>>(); //as a StreamController 2

  //Getters to streams
  Stream<List<int>> get topIds => _topIds.stream; //3

//method allows to get info from repositiry (1), added to a stream controller (2) and topIds are avelaible outside the world through use of topIds getter (3)

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  dispose() {
    _topIds.close();
  }
}
