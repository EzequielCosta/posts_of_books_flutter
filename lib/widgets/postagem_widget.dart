import 'package:flutter/material.dart';

class PostagemWidget extends StatelessWidget {
  final String id;
  final String titulo;
  final String? url;

  const PostagemWidget(
      {required this.id, required this.titulo, required this.url, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        //color: Colors.orange,
        shadowColor: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/62070653?v=4",
                    ),
                    //backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(width: 10),
                  Text(titulo)
                ],
              ),
            ),
            Container(
                color: Colors.black,
                width: double.infinity,
                child: Image.network(
                  url!,
                  height: 400,
                ))
          ],
        ),
      ),
    );
  }
}
