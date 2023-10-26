import 'package:equatable/equatable.dart';

class FeedListModel extends Equatable{

  String? id;
  String? author;
  int? width;
  int? height;
  String? url;
  String? downloadUrl;

  FeedListModel(
      {this.id,
        this.author,
        this.width,
        this.height,
        this.url,
        this.downloadUrl});

  FeedListModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    author = json['author'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['author'] = author;
    data['width'] = width;
    data['height'] = height;
    data['url'] = url;
    data['download_url'] = downloadUrl;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, author, width, height, url, downloadUrl];
}
