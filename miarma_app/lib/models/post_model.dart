class PostModel {
  String? id;
  String? titulo;
  String? contenido;
  String? media;
  String? nickUsuario;
  String? fechaPublicacion;
  bool? public;

  PostModel(
      {this.id,
      this.titulo,
      this.contenido,
      this.media,
      this.nickUsuario,
      this.fechaPublicacion,
      this.public});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    contenido = json['contenido'];
    media = json['media'];
    nickUsuario = json['nickUsuario'];
    fechaPublicacion = json['fechaPublicacion'];
    public = json['public'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['contenido'] = this.contenido;
    data['media'] = this.media;
    data['nickUsuario'] = this.nickUsuario;
    data['fechaPublicacion'] = this.fechaPublicacion;
    data['public'] = this.public;
    return data;
  }
}
