import 'models.dart';

class BookResponse {
  String? id;
  DateTime? uploadDate;
  User? uploader;
  int? amountDownloads;
  String? category;
  bool? vip;
  String? book;
  String? title;
  String? author;
  String? description;

  BookResponse(
      {this.id,
      this.uploadDate,
      this.uploader,
      this.amountDownloads,
      this.category,
      this.vip,
      this.book,
      this.title,
      this.author,
      this.description});

  BookResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uploadDate = DateTime.tryParse(reformat(json['uploadDate']));
    uploader = User.fromJson(json['uploader']);
    amountDownloads = json['amountDownloads'];
    category = json['category'];
    vip = json['vip'];
    book = json['book'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uploadDate'] = uploadDate;
    data['uploader'] = uploader;
    data['amountDownloads'] = amountDownloads;
    data['category'] = category;
    data['vip'] = vip;
    data['book'] = book;
    data['title'] = title;
    data['author'] = author;
    data['description'] = description;
    return data;
  }
}
