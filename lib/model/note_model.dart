class Notes {
  int id;
  String notes, title;
  Notes({this.id, this.notes, this.title});
  factory Notes.fromJson(Map json) => Notes(
      id: int.parse(json['id']), notes: json['notes'], title: json['title']);
}
