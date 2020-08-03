void main() {
  var deck = new Deck();
  print(deck);
  print(deck.deal(5));
  deck.removeCard('Hearts', 'Ace');
  print(deck);
}

class Deck {
  List<Card> cards = [];

  Deck() {
    var ranks = ['Ace', 'Two', 'Three', 'Four', 'Five'];
    var suits = ['Diamonds', 'Hearts', 'Clubs', 'Spades'];

    for (var suitItem in suits) {
      for (var rankItem in ranks) {
        var card = new Card(
          rank: rankItem,
          suit: suitItem,
        );
        cards.add(card);
      }
    }
  }

  toString() {
    return cards.toString();
  }

  shuffle() {
    cards.shuffle();
  }

  cardsWithSuit(String suit) {
    return cards.where((card) => card.suit == suit);
  }

  deal(int handSize) {
    var hand = cards.sublist(0, handSize);
    cards = cards.sublist(handSize);
    return hand;
  }

  removeCard(String suit, String rank) {
    return cards.removeWhere((card) => card.suit == suit && card.rank == rank);
  }
}

class Card {
  String suit;
  String rank;

  Card({this.rank, this.suit});

  toString() {
    return '$rank of $suit';
  }
}
