class Journal {
  int? id;
  String title;
  String description;
  String mood;
  String voicePath;
  String date;

  Journal(
      {this.id,
      required this.title,
      required this.description,
      required this.mood,
      required this.voicePath,
      required this.date});

  factory Journal.fromMap(Map<String, dynamic> map) {
    return Journal(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      mood: map['mood'],
      voicePath: map['voice_path'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'title': title,
      'description': description,
      'mood': mood,
      'voice_path': voicePath,
      'date': date,
    };
  }
}
