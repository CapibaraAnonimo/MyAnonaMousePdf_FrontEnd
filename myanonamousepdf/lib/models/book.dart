import 'models.dart';

class BookResponse {
  late String id;
  late DateTime? uploadDate;
  late User uploader;
  late int amountDownloads;
  late String category;
  late bool vip;
  late String book;
  late String title;
  late String author;
  late String description;

  BookResponse(
      {required this.id,
      required this.uploadDate,
      required this.uploader,
      required this.amountDownloads,
      required this.category,
      required this.vip,
      required this.book,
      required this.title,
      required this.author,
      required this.description});

  BookResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uploadDate = DateTime.tryParse(reformat2(json['uploadDate']));
    uploader = User.fromJson(json['uploader']);
    amountDownloads = json['amountDownloads'];
    category = json['category'];
    vip = json['vip'];
    book = json['book'];
    author = json['author'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uploadDate'] = dateToString(uploadDate!);
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
