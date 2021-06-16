import 'package:designflutter/css/style.dart';
import 'package:designflutter/css/values.dart';
import 'package:designflutter/model/card_model.dart';
import 'package:designflutter/states/cardState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var cardState;
  late AnimationController _controller;
  TextEditingController description = TextEditingController();
  late Animation animation;
  @override
  void initState() {
    cardState = Provider.of<CardState>(context, listen: false);
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0, 1.0, curve: Curves.easeOut)));
    _controller.forward();
    _controller.addListener(() {
      setState(() {
      });
    });
    super.initState();
  }
  late Orientation currentOrientation;
  late double totalHeight,
      totalWidth,
      fontSize,
      appBarHeight,
      titleHeight,
      cardHeight,
      backBtnWidth,
      addBtnHeight,
      listViewHeight;
  String title = "News";
  @override
  Widget build(BuildContext context) {
    currentOrientation = MediaQuery.of(context).orientation;
    totalHeight = MediaQuery.of(context).size.height;
    totalWidth = MediaQuery.of(context).size.width;
    if (currentOrientation.index == 0) {
      appBarHeight = totalHeight * 0.1;
      titleHeight = totalHeight * 0.07;
      cardHeight = totalHeight * 0.14;
      listViewHeight = totalHeight * 6.5 / 10;
    } else {
      appBarHeight = totalHeight * 0.2;
      titleHeight = totalHeight * 0.15;
      cardHeight = totalHeight * 0.25;
      listViewHeight = totalHeight * 4 / 10;
    }
    addBtnHeight = totalHeight * 0.07;
    backBtnWidth = totalWidth * 0.07;
    fontSize = titleHeight * 0.7;
    return Scaffold(
      backgroundColor: backGroundColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Positioned(
              child: Container(
            width: totalWidth * 0.15,
            height: appBarHeight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                color: Colors.blue),
          )),
          Padding(
            padding: EdgeInsets.only(
                left: totalWidth * 0.04, right: totalWidth * 0.03),
            child: Column(
              children: [
                Container(
                    height: appBarHeight,
                    width: totalWidth,
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        width: backBtnWidth,
                        height: backBtnWidth,
                        decoration: BoxDecoration(
                            color: primaryColor, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.arrow_back,
                          color: iconText,
                        ),
                      ),
                    )),
                Center(
                  child: Container(
                    width: totalWidth * 0.49,
                    height: titleHeight,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: iconText),
                    alignment: Alignment.center,
                    child: Text(title,
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize)),
                  ),
                ),
                SizedBox(
                  height: totalHeight * 0.03,
                ),
                Container(
                  height: listViewHeight,
                  child: Consumer<CardState>(
                    builder: (context, value, child) {
                      List<CardModel> cards = value.cardList;
                      return Opacity(
                        opacity: animation.value,
                        child: ListView(
                          children: [
                            for (int i = 0; i < cards.length; i++)
                              cardWidget(
                                  cards[i].imagePath, cards[i].description, i,cards[i])
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          showAddCard();
                        },
                        child: Container(
                          width: addBtnHeight,
                          height: addBtnHeight,
                          decoration: BoxDecoration(
                              color: primaryColor, shape: BoxShape.circle),
                          child: Icon(
                            Icons.add,
                            color: iconText,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget textfield(String text, TextEditingController controller, double width,
      double height, String hintText) {
    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            height: height,
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(),
            child: TextField(
              controller: controller,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                  hintText: hintText,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  )),
            ),
          )
        ],
      ),
    );
  }

  List<Color> imageColors = [iconText, iconText];
  Future<void> showAddCard() async {
    clearColors();
    String descriptionHint = "Type..",selectedImagePath=image1Path;
    description.text = "";
    
    return showDialog(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: backGroundColor,
              content: SingleChildScrollView(
                child: ListBody(children: <Widget>[
                  Container(
                    width: totalWidth * 7 / 10,
                    height: currentOrientation.index == 0?totalHeight * 6 / 10:totalHeight * 8 / 10,
                    padding:
                        EdgeInsets.symmetric(horizontal: totalWidth * 0.2 / 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Choose Image",
                          style: TextStyle(),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                onPressed: () {
                                  clearColors();
                                  selectedImagePath=image1Path;
                                  setState(() {
                                    imageColors[0] = primaryColor;
                                  });
                                },
                                child: Container(
                                  height: cardHeight,
                                  padding: EdgeInsets.all(10),
                                  color: imageColors[0],
                                  child: Container(
                                    height: cardHeight,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(image1Path),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                onPressed: () {
                                  clearColors();
                                  selectedImagePath=image2Path;
                                  setState(() {
                                    imageColors[1] = primaryColor;
                                  });
                                },
                                child: Container(
                                  height: cardHeight,
                                  padding: EdgeInsets.all(10),
                                  color: imageColors[1],
                                  child: Container(
                                    height: cardHeight,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(image2Path),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        textfield(
                            "Description",
                            description,
                            totalWidth * 6.5 / 10,
                            totalHeight * 0.6 / 10,
                            descriptionHint),
                        TextButton(
                          onPressed: () async{
                            CardModel card=CardModel(description.text, selectedImagePath);
                            Navigator.of(context).pop();
                              await _controller.reverse();
                            cardState.addCard(card);
                            _controller.forward();
                          },
                          child: Container(
                            width: totalWidth * 4 / 10,
                            height: addBtnHeight,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(29)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Add",
                                    style: TextStyle(color: Colors.white)),
                                Icon(
                                  Icons.add,
                                  color: iconText,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              ),
            );
          });
        });
  }
  Future<void> showEditCard(CardModel card) async {
    clearColors();

    String descriptionHint = "Type..",selectedImagePath=card.imagePath;
    if(selectedImagePath==image1Path)imageColors[0]=primaryColor;
    else imageColors[1]=primaryColor;
    description.text = card.description;
    
    return showDialog(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: backGroundColor,
              content: SingleChildScrollView(
                child: ListBody(children: <Widget>[
                  Container(
                    width: totalWidth * 7 / 10,
                    height: currentOrientation.index == 0?totalHeight * 6 / 10:totalHeight * 8 / 10,
                    padding:
                        EdgeInsets.symmetric(horizontal: totalWidth * 0.2 / 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Choose Image",
                          style: TextStyle(),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                onPressed: () {
                                  clearColors();
                                  selectedImagePath=image1Path;
                                  setState(() {
                                    imageColors[0] = primaryColor;
                                  });
                                },
                                child: Container(
                                  height: cardHeight,
                                  padding: EdgeInsets.all(10),
                                  color: imageColors[0],
                                  child: Container(
                                    height: cardHeight,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(image1Path),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                onPressed: () {
                                  clearColors();
                                  selectedImagePath=image2Path;
                                  setState(() {
                                    imageColors[1] = primaryColor;
                                  });
                                },
                                child: Container(
                                  height: cardHeight,
                                  padding: EdgeInsets.all(10),
                                  color: imageColors[1],
                                  child: Container(
                                    height: cardHeight,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(image2Path),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        textfield(
                            "Description",
                            description,
                            totalWidth * 6.5 / 10,
                            totalHeight * 0.6 / 10,
                            descriptionHint),
                        TextButton(
                          onPressed: () async{
                            CardModel cardNew=CardModel(description.text, selectedImagePath);
                            Navigator.of(context).pop();
                              await _controller.reverse();
                            cardState.editCard(card,cardNew);

                            _controller.forward();
                          },
                          child: Container(
                            width: totalWidth * 4 / 10,
                            height: addBtnHeight,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(29)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Edit",
                                    style: TextStyle(color: Colors.white)),
                                Icon(
                                  Icons.edit,
                                  color: iconText,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              ),
            );
          });
        });
  }


  clearColors() {
    for (int i = 0; i < imageColors.length; i++) {
      imageColors[i] = iconText;
    }
  }

  Widget cardWidget(String imagePath, String description, int index,CardModel card) {
    return Padding(
      padding: EdgeInsets.only(bottom: totalHeight * 0.02),
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: cardHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imagePath), fit: BoxFit.fill),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: cardHeight,
                padding: EdgeInsets.symmetric(
                    horizontal: totalWidth * 0.02, vertical: 10),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Icon(
                              Icons.close,
                              color: closeColor,
                            ),
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(description),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              showEditCard(card);
                            },
                            child: Icon(
                              Icons.edit,
                              color: primaryColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await _controller.reverse();
                              cardState.removeCard(index);
                              _controller.forward();
                            },
                            child: Icon(
                              Icons.delete,
                              color: primaryColor,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
