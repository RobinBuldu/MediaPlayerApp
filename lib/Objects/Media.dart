class Media {
  String title;
  String path;
  DateTime addedAt;
  Media({
    required this.title,
    required this.path,
    required this.addedAt,
  });
  //setters
  set setTitle(String title) {
    this.title = title;
  }

  set setAddedAt(DateTime addedAt) {
    this.addedAt = addedAt;
  }
  set setPath(String path) {
    this.path = path;
  }
  //getters
  String get getTitle {
    return title;
  }
  DateTime get getAddedAt {
    return addedAt;
  }
  String get getPath {
    return path;
  }
  //toString method
  @override
  String toString() {
    return '$title\naddedAt: $addedAt';
  }
}