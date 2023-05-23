class MovieModel {
  String? status;
  List<Data>? data;
  dynamic info;
  String? error;

  MovieModel({this.status, this.data, this.info});

  MovieModel.withError(String errorMessage) {
    error = errorMessage;
  }

  MovieModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['info'] = info;
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? description;
  String? poster;
  String? createdDate;

  Data({this.id, this.title, this.description, this.poster, this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    poster = json['poster'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['poster'] = poster;
    data['created_date'] = createdDate;
    return data;
  }
}
