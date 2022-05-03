import 'package:flutter/material.dart';
import 'package:harpia_flutter/widgets/field_information.dart';

class PostagemDetailWidget extends StatelessWidget {
  final String id;
  final String titulo;
  final String descricao;
  final int valor;
  final String? url;

  const PostagemDetailWidget(
      {required this.descricao,
      required this.titulo,
      required this.id,
      required this.valor,
      required this.url,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail")),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(8),
          color: Colors.black,
          width: double.infinity,
          child: InteractiveViewer(
            child: Image.network(
              url!,
              height: 350,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FieldInformation(
                label: "Título", value: titulo, icon: const Icon(Icons.title)),
            FieldInformation(
                label: "Descrição",
                value: descricao,
                icon: const Icon(Icons.description)),
            FieldInformation(
                label: "Valor",
                value: valor.toString(),
                icon: const Icon(Icons.money_outlined)),
          ],
        )
      ]),
    );
  }
}
