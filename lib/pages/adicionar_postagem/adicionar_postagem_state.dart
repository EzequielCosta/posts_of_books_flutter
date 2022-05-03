import 'dart:io';

import 'package:flutter/material.dart';
import 'package:harpia_flutter/pages/adicionar_postagem/adicionar_postagem.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart' as http_parse;

class AdicionarPostagemState extends State<AdicionarPostagem> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  String titulo = '';
  String descricao = '';
  String valor = '';

  XFile? galleryFile;
  bool galleryFileIsNull = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Adicionar Postagem"),
        ),
        body: Container(
          color: const Color.fromARGB(255, 234, 241, 245),
          child: Center(
            child: Form(
                key: _formKey,
                child: Container(
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  height: 500,
                  //color: Colors.orange,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                            child: Icon(
                          Icons.post_add,
                          size: 50,
                          color: Colors.lightBlue,
                        )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Digite o título',
                                label: Text("Título")),
                            validator: validateIsEmptyField,
                            onSaved: (String? value) {
                              titulo = value ?? '';
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Digite a descrição',
                                label: Text("Descrição")),
                            validator: validateIsEmptyField,
                            onSaved: (String? value) {
                              descricao = value ?? '';
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Digite o valor',
                                label: Text("Valor")),
                            validator: validateIsEmptyField,
                            onSaved: (String? value) {
                              valor = value ?? '';
                            },
                          ),
                        ),
                        Container(
                          child: TextButton(
                              onPressed: () {
                                _setGalleryFile();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.add_a_photo_outlined,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Adicionar imagem",
                                      )
                                    ],
                                  ),
                                  if (galleryFileIsNull) ...[
                                    const Text(
                                      "Necessário adicionar uma imagem",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12),
                                    )
                                  ],
                                ],
                              )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.lightBlue,
                          ),
                          width: 100,
                          margin: const EdgeInsets.only(top: 10),
                          child: TextButton(
                              onPressed: () {
                                _save();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.save,
                                    color: Colors.white,
                                  ),
                                  const Text(
                                    "Salvar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  if (_saving) ...[
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const SizedBox(
                                        width: 10,
                                        height: 10,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ))
                                  ]
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ));
  }

  Future<void> _save() async {
    _validateImage();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      http.StreamedResponse response = await adicionarPostagem(
          titulo: titulo,
          descricao: descricao,
          valor: valor,
          file: galleryFile);
      String message = response.statusCode == 200
          ? "Postagem adicionada com sucesso"
          : "Não foi possível adicionar a postagem";

      SnackBar snackBar = SnackBar(
        content: Text(message),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<http.StreamedResponse> adicionarPostagem(
      {required String titulo,
      required String descricao,
      required String valor,
      required XFile? file}) async {
    XFile imagemDaPostagem = file ?? XFile("assets/images/not-found.png");

    http_parse.MediaType mimeType =
        http_parse.MediaType.parse(imagemDaPostagem.mimeType ?? "image/jpg");

    var pic = await http.MultipartFile.fromPath("file", file!.path,
        contentType: mimeType);

    const url = 'https://harpia-inc-api.herokuapp.com/postagem/criar';

    http.MultipartRequest request =
        http.MultipartRequest("POST", Uri.parse(url));

    request.fields.addAll(<String, String>{
      "titulo": titulo,
      "descricao": descricao,
      "valor": valor,
      "idUsuario": "61a954874f3da2409c352ae6"
    });

    request.headers.addAll(<String, String>{
      'Accept': "application/json",
      'Content-Type': 'multipart/form-data; charset=UTF-8',
    });

    request.files.add(pic);
    setState(() {
      _saving = true;
    });
    http.StreamedResponse response = await request.send();
    setState(() {
      _saving = false;
    });

    return response;
  }

  Future<XFile?> _imageSelectorGallery() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image

    return await _picker.pickImage(source: ImageSource.gallery);
  }

  Future<void> _setGalleryFile() async {
    var image = await _imageSelectorGallery();
    setState(() {
      galleryFile = image;
    });
    _validateImage();
  }

  String? validateIsEmptyField(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo obrigatório";
    }
    return null;
  }

  String? validateNumberField(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo obrigatório";
    }
    return null;
  }

  void _validateImage() {
    setState(() {
      galleryFileIsNull = (galleryFile == null) ? true : false;
    });
  }
}
