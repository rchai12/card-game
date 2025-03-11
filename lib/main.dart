import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class Card {
  final String suit;
  final String rank;
  final String frontImageUrl;
  final String backImageUrl;
  bool isFaceUp = false;
  bool isMatched = false;

  Card({
    required this.suit,
    required this.rank,
    required this.frontImageUrl,
    required this.backImageUrl,
  });

  bool matches(Card other) => suit == other.suit && rank == other.rank;
}

class CardGame extends StatefulWidget {
  @override
  _CardGameState createState() => _CardGameState();
}

class _CardGameState extends State<CardGame> {
  final List<Card> _cards = [];
  Card? _firstSelected;

  @override
  void initState() {
    super.initState();
    _initializeCards();
  }

  void _initializeCards() {
    List<String> suits = ['Diamonds', 'Clubs', 'Hearts', 'Spades'];
    List<String> ranks = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13'];
    List<String> images = [
      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/01_of_diamonds_A.svg/800px-01_of_diamonds_A.svg.png', 
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/02_of_diamonds.svg/800px-02_of_diamonds.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/03_of_diamonds.svg/800px-03_of_diamonds.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/04_of_diamonds.svg/800px-04_of_diamonds.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/05_of_diamonds.svg/800px-05_of_diamonds.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/06_of_diamonds.svg/800px-06_of_diamonds.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/07_of_diamonds.svg/800px-07_of_diamonds.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/08_of_diamonds.svg/800px-08_of_diamonds.svg.png', 
      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/09_of_diamonds.svg/800px-09_of_diamonds.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/10_of_diamonds_-_David_Bellot.svg/800px-10_of_diamonds_-_David_Bellot.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Jack_of_diamonds_fr.svg/800px-Jack_of_diamonds_fr.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Queen_of_diamonds_fr.svg/800px-Queen_of_diamonds_fr.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/King_of_diamonds_fr.svg/800px-King_of_diamonds_fr.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/01_of_clubs_A.svg/800px-01_of_clubs_A.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/02_of_clubs.svg/800px-02_of_clubs.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/03_of_clubs.svg/800px-03_of_clubs.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/04_of_clubs.svg/800px-04_of_clubs.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/05_of_clubs.svg/800px-05_of_clubs.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/06_of_clubs.svg/800px-06_of_clubs.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/07_of_clubs.svg/800px-07_of_clubs.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/08_of_clubs.svg/800px-08_of_clubs.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/09_of_clubs.svg/800px-09_of_clubs.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/10_of_clubs_-_David_Bellot.svg/800px-10_of_clubs_-_David_Bellot.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/Jack_of_clubs_fr.svg/800px-Jack_of_clubs_fr.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Queen_of_clubs_fr.svg/800px-Queen_of_clubs_fr.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/King_of_clubs_fr.svg/800px-King_of_clubs_fr.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/01_of_hearts_A.svg/800px-01_of_hearts_A.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/02_of_hearts.svg/800px-02_of_hearts.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/03_of_hearts.svg/800px-03_of_hearts.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/04_of_hearts.svg/800px-04_of_hearts.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/05_of_hearts.svg/800px-05_of_hearts.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/06_of_hearts.svg/800px-06_of_hearts.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/07_of_hearts.svg/800px-07_of_hearts.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/08_of_hearts.svg/800px-08_of_hearts.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/09_of_hearts.svg/800px-09_of_hearts.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/10_of_hearts_-_David_Bellot.svg/800px-10_of_hearts_-_David_Bellot.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Jack_of_hearts_fr.svg/800px-Jack_of_hearts_fr.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Queen_of_hearts_fr.svg/800px-Queen_of_hearts_fr.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/King_of_hearts_fr.svg/800px-King_of_hearts_fr.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/01_of_spades_A.svg/800px-01_of_spades_A.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/02_of_spades.svg/800px-02_of_spades.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/03_of_spades.svg/800px-03_of_spades.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/04_of_spades.svg/800px-04_of_spades.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/05_of_spades.svg/800px-05_of_spades.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/06_of_spades.svg/800px-06_of_spades.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/07_of_spades.svg/800px-07_of_spades.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/08_of_spades.svg/800px-08_of_spades.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/09_of_spades.svg/800px-09_of_spades.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/10_of_spades_-_David_Bellot.svg/800px-10_of_spades_-_David_Bellot.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Jack_of_spades_fr.svg/800px-Jack_of_spades_fr.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Queen_of_spades_fr.svg/800px-Queen_of_spades_fr.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/King_of_spades_fr.svg/800px-King_of_spades_fr.svg.png'
    ];

    List<Card> fullDeck = [];
    for (int j = 0; j < 4; j++) {
      for (int i = 0; i < 13; i++) {
        var suit = suits[j];
        var rank = ranks[i];
        var frontImageUrl = images[j * 1 + i];
        var backImageUrl = 'https://opengameart.org/sites/default/files/card%20back%20red.png';

        fullDeck.add(Card(suit: suit, rank: rank, frontImageUrl: frontImageUrl, backImageUrl: backImageUrl));
      }
    }

    fullDeck.shuffle(Random());
    var selectedCards = fullDeck.take(8).toList();

    for (var card in selectedCards) {
      _cards.add(card);
      _cards.add(Card(
        suit: card.suit,
        rank: card.rank,
        frontImageUrl: card.frontImageUrl,
        backImageUrl: card.backImageUrl,
      ));
    }
  }

  void shuffleCards() => _cards.shuffle(Random());

  void _selectCard(int index) {
    if (_cards[index].isFaceUp || _cards[index].isMatched) return;

    setState(() {
      _cards[index].isFaceUp = true;
    });

    if (_firstSelected == null) {
      _firstSelected = _cards[index];
    } else {
      if (_firstSelected!.matches(_cards[index])) {
        setState(() {
          _firstSelected!.isMatched = true;
          _cards[index].isMatched = true;
        });
      } else {
        Timer(Duration(seconds: 2), () {
          setState(() {
            _firstSelected!.isFaceUp = false;
            _cards[index].isFaceUp = false;
          });
        });
      }
      _firstSelected = null;
    }
  }
}
