class Photo {
  int? id;
  String path;

  Photo({this.id, required this.path});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'path': path,
    };
  }

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      id: map['id'],
      path: map['path'],
    );
  }
}
