class Note {
  int? id;
  String title;
  String description;
  int position;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.position,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'position': position,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      position: map['position'],
    );
  }
}
