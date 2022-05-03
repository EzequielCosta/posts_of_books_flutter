import 'dart:convert';
import 'package:harpia_flutter/entities/postagem.dart';
import 'package:harpia_flutter/widgets/circular_progress_indicator_listview_widget.dart';
import 'package:harpia_flutter/widgets/postagem_scroll_view_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:harpia_flutter/pages/home/home.dart';

class HomeState extends State<Home> {
  List<Postagem> imagesPost = [];
  int page = 1;
  int limitPerPage = 20;
  late final ScrollController _scrollController;
  bool _loading = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(() => {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent)
            {/*fetchPosts()*/}
        });

    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 244, 247),
      appBar: AppBar(
        title: const Text("List Post"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              navigationAdicionarPostagem();
            },
          )
        ],
      ),
      body: Center(
          child: Stack(
        children: <Widget>[
          PostagemScrollViewWidget(
            scrollController: _scrollController,
            imagesPosts: imagesPost,
            fecthPost: fetchPosts,
          ),
          if (_loading) ...[
            CircularProgressIndicatorListView(
              alignment:
                  (page == 1 ? Alignment.center : Alignment.bottomCenter),
            )
          ],
        ],
      )),
    );
  }

  Future<void> fetchPosts() async {
    setState(() {
      _loading = true;
    });
    final response = await http
        .get(Uri.parse("https://harpia-inc-api.herokuapp.com/postagem/getAll"));

    if (response.statusCode == 200) {
      List<dynamic> imagesPostJson = jsonDecode(response.body);

      setState(() {
        for (var element in imagesPostJson) {
          imagesPost.add(Postagem.fromJson(element));
        }
        page++;
        _loading = false;
      });
    } else {
      throw Exception('Failed to load Album');
    }
  }

  void navigationAdicionarPostagem() {
    Navigator.pushNamed(context, "/adicionarPostagem");
  }
}
