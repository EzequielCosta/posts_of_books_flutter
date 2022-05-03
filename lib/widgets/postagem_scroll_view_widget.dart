import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:harpia_flutter/entities/postagem.dart';
import 'package:harpia_flutter/pages/postagem_detail/postagem_detail_arguments.dart';
import 'package:harpia_flutter/widgets/postagem_widget.dart';

class PostagemScrollViewWidget extends StatefulWidget {
  final List<Postagem> imagesPosts;
  final ScrollController scrollController;
  final Future<void> Function() fecthPost;

  const PostagemScrollViewWidget(
      {required this.scrollController,
      required this.imagesPosts,
      Key? key,
      required this.fecthPost})
      : super(key: key);

  @override
  PostagemScrollViewWidgetState createState() {
    return PostagemScrollViewWidgetState();
  }
}

class PostagemScrollViewWidgetState extends State<PostagemScrollViewWidget> {
  List<Postagem> imagesPosts = [];

  @override
  void initState() {
    imagesPosts = widget.imagesPosts;
    super.initState();
  }
  // final ScrollController scrollController;
  // final Future<void> Function() fecthPost;

  // PostagemScrollViewWidgetState(
  //     {required this.scrollController,
  //     required this.imagesPosts,
  //     Key? key,
  //     required this.fecthPost});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return fetchPosts2();
        // return Future.delayed(const Duration(seconds: 3), () {
        //   print("ola");
        // });
      },
      child: ListView.separated(
        controller: widget.scrollController,
        padding: const EdgeInsets.all(8),
        itemCount: imagesPosts.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, "/detail",
                arguments: PostagemDetailArguments(
                  id: imagesPosts[index].id,
                  titulo: imagesPosts[index].titulo,
                  descricao: imagesPosts[index].descricao,
                  url: imagesPosts[index].postagem?["url"],
                  valor: imagesPosts[index].valor,
                )),
            child: PostagemWidget(
              id: imagesPosts[index].id,
              url: imagesPosts[index].postagem?["url"],
              titulo: imagesPosts[index].titulo,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 4,
        ),
      ),
    );
    // ListView(padding: EdgeInsets.all(8), children: widgets);
  }

  Future<void> fetchPosts2() async {
    final response = await http
        .get(Uri.parse("https://harpia-inc-api.herokuapp.com/postagem/getAll"));

    if (response.statusCode == 200) {
      List<dynamic> imagesPostJson = jsonDecode(response.body);

      setState(() {
        imagesPosts = [];
        for (var element in imagesPostJson) {
          imagesPosts.add(Postagem.fromJson(element));
        }
      });
    } else {
      throw Exception('Failed to load Album');
    }
  }
}
