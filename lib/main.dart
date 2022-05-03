import 'package:flutter/material.dart';
import 'package:harpia_flutter/pages/adicionar_postagem/adicionar_postagem.dart';
import 'package:harpia_flutter/pages/home/home.dart';
import 'package:harpia_flutter/pages/postagem_detail/postagem_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/detail": (context) => PostagemDetail(),
        "/adicionarPostagem": (context) => AdicionarPostagem(),
      },
    );
  }
}
