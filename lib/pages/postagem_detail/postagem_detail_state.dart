import 'package:flutter/material.dart';
import 'package:harpia_flutter/pages/postagem_detail/postagem_detail.dart';
import 'package:harpia_flutter/pages/postagem_detail/postagem_detail_arguments.dart';
import 'package:harpia_flutter/widgets/postagem_detail_widget.dart';

class PostagemDetailState extends State<PostagemDetail> {
  @override
  Widget build(BuildContext context) {
    final argsFromHome =
        ModalRoute.of(context)!.settings.arguments as PostagemDetailArguments;

    return PostagemDetailWidget(
        descricao: argsFromHome.descricao,
        titulo: argsFromHome.titulo,
        id: argsFromHome.id,
        valor: argsFromHome.valor,
        url: argsFromHome.url);
  }
}
