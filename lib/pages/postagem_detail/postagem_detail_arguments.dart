class PostagemDetailArguments {
  final String id;
  final String titulo;
  final String descricao;
  final int valor;
  final String? url;

  PostagemDetailArguments({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.valor,
    required this.url,
  });
}
