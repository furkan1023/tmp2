import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/homepage.dart';
import 'states/cardState.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => CardState()),
      ],
      child:MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    )
    );
  }
}