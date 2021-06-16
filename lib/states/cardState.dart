import 'package:designflutter/css/values.dart';
import 'package:designflutter/model/card_model.dart';
import 'package:flutter/foundation.dart';

class CardState with ChangeNotifier {
  List<CardModel> cards = [
    new CardModel(descriptionTmp, image1Path),
    new CardModel(descriptionTmp, image2Path),
    new CardModel(descriptionTmp, image1Path),
    new CardModel(descriptionTmp, image2Path)
  ];
  removeCard(int index) {
    cards.removeAt(index);
    notifyListeners();
  }

  addCard(CardModel card) {
    cards.add(card);
    notifyListeners();
  }
  editCard(CardModel oldCard,CardModel newCard) {
    int index=cards.indexOf(oldCard);
    cards[index]=newCard;
    notifyListeners();
  }

  get cardList => cards;
}
