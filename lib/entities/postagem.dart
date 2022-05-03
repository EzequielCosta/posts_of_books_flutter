class Postagem {
  final String id;
  final String titulo;
  //final String categoria;
  final String descricao;
  //final String localizacao;
  final String idUsuario;
  final int valor;
  // final String dataCadastro;
  // final String dataDevolucao;
  // final String dataRealDevolucao;
  // final int multa;
  // final bool status;
  // final String itensInteresse;

  // final String cep;
  // final String uf;
  // final String codigoCidade;
  // final String bairro;
  // final String logradouro;
  // final String cidade;
  final Map<String, dynamic>? postagem;

  Postagem(
      {required this.id,
      required this.titulo,
      required this.descricao,
      required this.idUsuario,
      required this.valor,
      required this.postagem});

  factory Postagem.fromJson(Map<String, dynamic> json) {
    return Postagem(
        id: json["_id"],
        titulo: json["titulo"],
        descricao: json["descricao"],
        idUsuario: json["idUsuario"],
        valor: json["valor"],
        postagem: json["postagem"]);
  }
}
