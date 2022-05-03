class ImagePost {
  final String id;
  final String nome;
  final int tamanho;
  final String key;
  final String? url;
  final String postagemId;
  final String dataCriacao;

  ImagePost({
    required this.id,
    required this.nome,
    required this.tamanho,
    required this.key,
    required this.url,
    required this.postagemId,
    required this.dataCriacao,
  });

  factory ImagePost.fromJson(Map<String, dynamic> json) {
    return ImagePost(
        id: json["_id"],
        nome: json["nome"],
        tamanho: json["tamanho"],
        key: json["key"],
        url: json["url"],
        postagemId: json["postagemId"],
        dataCriacao: json["dataCriacao"]);
  }
}
