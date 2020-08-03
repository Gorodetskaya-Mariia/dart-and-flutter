import 'dart:async';

class Cake {}

class Order {
  String type;
  Order(this.type);
}

void main() {
  final controller = new StreamController();

  final order = new Order('banana'); //customer has been ordered a bake

  final baker =
      new StreamTransformer.fromHandlers(handleData: (cakeType, sink) {
    if (cakeType == 'chocolate') {
      sink.add(new Cake());
    } else {
      sink.addError('I cant bake that type!!!');
    }
  });

  controller.sink.add(order); //order taker takes  the order
  controller.stream
      .map((order) => order.type) //extract order type
      .transform(
          baker) //run order type through our baker who is going to produce new cake or add an error
      .listen(
        (cake) => print('Heres your cake $cake'),
        onError: (err) => print(err),
      ); // order inspector
}
